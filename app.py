from flask import Flask, render_template, request
from flask_wtf import CSRFProtect
from flask_limiter import Limiter
from flask_limiter.util import get_remote_address
from dotenv import load_dotenv
import psycopg2
import os
import logging

# LOGGING SET UP
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')
logger = logging.getLogger(__name__)

load_dotenv()

app = Flask(__name__)
app.config['SECRET_KEY'] = os.getenv('SECRET_KEY', os.urandom(24))  # FOR CSRF - REQUIRED!!!!!!!!
csrf = CSRFProtect(app)
limiter_storage = os.getenv('RATE_LIMIT_STORAGE', 'memory://')  # DEFAULT TO IN-MEMORY FOR DEV
limiter = Limiter(
    get_remote_address,
    app=app,
    storage_uri=limiter_storage
)

def get_static_files():
    static_files = []
    for root, dirs, files in os.walk(app.static_folder):
        for file in files:
            relative_path = os.path.relpath(os.path.join(root, file), app.static_folder).replace('\\', '/')
            static_files.append(relative_path)
    return static_files

app.jinja_env.globals['static_files'] = get_static_files()

def get_db_connection():
    try:
        # RENDER DATABASE_URL
        database_url = os.getenv('DATABASE_URL')
        if database_url:
            conn = psycopg2.connect(database_url)
            return conn
        else:
            conn = psycopg2.connect(
                dbname=os.getenv('DB_NAME'),
                user=os.getenv('DB_USER'),
                password=os.getenv('DB_PASSWORD'),
                host=os.getenv('DB_HOST'),
                port=os.getenv('DB_PORT')
            )
            return conn
    except Exception as e:
        logger.error(f"Database connection error: {e}")
        return None

# HOME
@app.route('/')
def index():
    return render_template('index.html')

# TARGAREYNS WITH THEIR SORTING
@app.route('/targaryens')
def targaryens():
    sort = request.args.get('sort', 'alphabetical')
    page = int(request.args.get('page', 1))
    per_page = 10

    conn = get_db_connection()
    if conn is None:
        return 'Database connection failed', 500
    cur = conn.cursor()

    base_query = '''
        SELECT
            t.character_id, 
            t.name, 
            t.full_name, 
            t.birth_date, 
            t.death_date,
            t.reign_start,
            t.reign_end,
            COALESCE(STRING_AGG(a.alias_name, ', '), 'None') AS aliases,
            COALESCE(STRING_AGG(d.name, ', '), 'None') AS dragons
        FROM targaryen t
        LEFT JOIN targaryen_alias ta ON t.character_id = ta.targaryen_id
        LEFT JOIN alias a ON ta.alias_id = a.alias_id
        LEFT JOIN dragon_rider dr ON t.character_id = dr.targaryen_id
        LEFT JOIN dragon d ON dr.dragon_id = d.dragon_id
        GROUP BY t.character_id, t.name, t.full_name, t.birth_date, t.death_date, t.reign_start, t.reign_end
    '''

    offset = (page - 1) * per_page

    if sort == 'oldest':
        order_by = 'ORDER BY COALESCE(t.birth_year, -9999) ASC'
    elif sort == 'youngest':
        order_by = 'ORDER BY COALESCE(t.birth_year, -9999) DESC'
    elif sort == 'lineage':
        query = '''
        WITH RECURSIVE lineage AS (
            SELECT t.character_id, t.name, t.full_name, t.birth_date, t.death_date, 
                   t.reign_start, t.reign_end, t.birth_year, 0 AS generation
            FROM targaryen t
            WHERE NOT EXISTS (
                SELECT 1 FROM targaryen_parent tp WHERE tp.child_id = t.character_id
            )
            UNION ALL
            SELECT t.character_id, t.name, t.full_name, t.birth_date, t.death_date, 
                   t.reign_start, t.reign_end, t.birth_year, l.generation + 1
            FROM targaryen t
            JOIN targaryen_parent tp ON t.character_id = tp.child_id
            JOIN lineage l ON tp.parent_id = l.character_id
        )
        SELECT
            l.character_id, 
            l.name, 
            l.full_name, 
            l.birth_date, 
            l.death_date,
            l.reign_start,
            l.reign_end,
            COALESCE(STRING_AGG(a.alias_name, ', '), 'None') AS aliases,
            COALESCE(STRING_AGG(d.name, ', '), 'None') AS dragons
        FROM lineage l
        LEFT JOIN targaryen_alias ta ON l.character_id = ta.targaryen_id
        LEFT JOIN alias a ON ta.alias_id = a.alias_id
        LEFT JOIN dragon_rider dr ON l.character_id = dr.targaryen_id
        LEFT JOIN dragon d ON dr.dragon_id = d.dragon_id
        GROUP BY l.character_id, l.name, l.full_name, l.birth_date, l.death_date, l.reign_start, l.reign_end, l.generation, l.birth_year
        ORDER BY 
            CASE WHEN COALESCE(l.birth_year, -9999) < 0 THEN 0 ELSE 1 END,
            l.generation,
            COALESCE(l.birth_year, -9999) ASC
        '''
    else:  # DEFAULT
        order_by = 'ORDER BY t.name'

    # PAGINATION FOR ALL 
    if sort == 'lineage':
        query += ' LIMIT %s OFFSET %s'
        cur.execute(query, (per_page, offset))
    else:
        query = base_query + ' ' + order_by + ' LIMIT %s OFFSET %s'
        cur.execute(query, (per_page, offset))
    targaryens = cur.fetchall()

    # TOTAL PAGES 
    cur.execute('SELECT COUNT(*) FROM targaryen')
    total_targaryens = cur.fetchone()[0]
    total_pages = (total_targaryens + per_page - 1) // per_page
    cur.close()
    conn.close()

    return render_template('targaryens.html', targaryens=targaryens, sort=sort, page=page, total_pages=total_pages)

# INDIVIDUAL DETAILS
@app.route('/targaryen/<int:character_id>')
def individual_targaryen(character_id):
    conn = get_db_connection()
    if conn is None:
        return 'Database connection failed', 500
    cur = conn.cursor()

    # FETCH THE DETAILS
    cur.execute('''
        SELECT 
            t.character_id, 
            t.name, 
            t.full_name, 
            t.birth_date, 
            t.death_date,
            t.reign_start,
            t.reign_end,
            COALESCE(STRING_AGG(a.alias_name, ', '), 'None') AS aliases,
            COALESCE(STRING_AGG(d.name, ', '), 'None') AS dragons
        FROM targaryen t
        LEFT JOIN targaryen_alias ta ON t.character_id = ta.targaryen_id
        LEFT JOIN alias a ON ta.alias_id = a.alias_id
        LEFT JOIN dragon_rider dr ON t.character_id = dr.targaryen_id
        LEFT JOIN dragon d ON dr.dragon_id = d.dragon_id
        WHERE t.character_id = %s
        GROUP BY t.character_id, t.name, t.full_name, t.birth_date, t.death_date, t.reign_start, t.reign_end
    ''', (character_id,))
    targaryen = cur.fetchone()

    # PARENT FETCH
    cur.execute('''
        SELECT t2.name, t2.full_name
        FROM targaryen_parent tp
        JOIN targaryen t1 ON tp.child_id = t1.character_id
        JOIN targaryen t2 ON tp.parent_id = t2.character_id
        WHERE t1.character_id = %s
    ''', (character_id,))
    parents = cur.fetchall()

    cur.close()
    conn.close()

    # DID THEY RULE
    ruled = targaryen[5] is not None

    return render_template('individual.html', targaryen=targaryen, parents=parents, ruled=ruled)

# DRAGONS
@app.route('/dragons')
def dragons():
    conn = get_db_connection()
    if conn is None:
        return 'Database connection failed', 500
    cur = conn.cursor()
    cur.execute('''
        SELECT d.dragon_id, d.name, d.color, d.eye_color, d.fireball_color, d.birth_date, d.death_date,
               STRING_AGG(t.full_name || ' (' || dr.start_date || ' - ' || COALESCE(dr.end_date, 'Alive') || ')', ', ') AS riders
        FROM dragon d
        LEFT JOIN dragon_rider dr ON d.dragon_id = dr.dragon_id
        LEFT JOIN targaryen t ON dr.targaryen_id = t.character_id
        GROUP BY d.dragon_id, d.name, d.color, d.eye_color, d.fireball_color, d.birth_date, d.death_date
        ORDER BY d.name;
    ''')
    dragons = cur.fetchall()
    cur.close()
    conn.close()
    return render_template('dragons.html', dragons=dragons)

# RELATIONSHIPS
@app.route('/relationships')
def relationships():
    page = request.args.get('page', 1, type=int)
    per_page = 10 

    conn = get_db_connection()
    if conn is None:
        return 'Database connection failed', 500
    cur = conn.cursor()
    
    cur.execute('SELECT COUNT(*) FROM targaryen')
    total_targaryens = cur.fetchone()[0]
    total_pages = (total_targaryens + per_page - 1) // per_page

    offset = (page - 1) * per_page

    cur.execute('''
        SELECT 
            t.character_id,
            t.name,
            t.full_name,
            -- Parents (name and ID, distinct to avoid duplicates)
            STRING_AGG(DISTINCT t2.name || '|' || t2.character_id, ',') AS parents,
            -- Targaryen Spouses (name, ID, and marriage dates, distinct to avoid duplicates)
            STRING_AGG(DISTINCT t3.name || '|' || t3.character_id || '|' || ts.marriage_date || '|' || COALESCE(ts.end_date, 'N/A'), ',') AS targaryen_spouses,
            -- Non-Targaryen Spouses (name, full name, and marriage dates, distinct to avoid duplicates)
            STRING_AGG(DISTINCT nt.name || '|' || COALESCE(nt.full_name, 'Unknown') || '|' || tnts.marriage_date || '|' || COALESCE(tnts.end_date, 'N/A'), ',') AS non_targaryen_spouses,
            -- Children (name and ID, distinct to avoid duplicates)
            STRING_AGG(DISTINCT t4.name || '|' || t4.character_id, ',') AS children
        FROM targaryen t
        -- Parents
        LEFT JOIN targaryen_parent tp ON t.character_id = tp.child_id
        LEFT JOIN targaryen t2 ON tp.parent_id = t2.character_id
        -- Targaryen Spouses
        LEFT JOIN targaryen_spouse ts ON t.character_id = ts.targaryen_id
        LEFT JOIN targaryen t3 ON ts.spouse_id = t3.character_id
        -- Non-Targaryen Spouses
        LEFT JOIN targaryen_non_targaryen_spouse tnts ON t.character_id = tnts.targaryen_id
        LEFT JOIN non_targaryen nt ON tnts.non_targaryen_id = nt.non_targaryen_id
        -- Children
        LEFT JOIN targaryen_parent tc ON t.character_id = tc.parent_id
        LEFT JOIN targaryen t4 ON tc.child_id = t4.character_id
        GROUP BY t.character_id, t.name, t.full_name
        ORDER BY t.name
        LIMIT %s OFFSET %s;
    ''', (per_page, offset))
    relationships = cur.fetchall()
    
    cur.close()
    conn.close()
    
    return render_template('relationships.html', 
                          relationships=relationships, 
                          page=page, 
                          total_pages=total_pages, 
                          per_page=per_page)

# SEARCH
@app.route('/search', methods=['GET', 'POST'])
@limiter.limit("10 per minute")
def search():
    if request.method == 'POST':
        # SANITIZE AND VALIDATE
        search_term = request.form.get('search_term', '').strip()
        if not search_term:
            logger.info("Search attempt with empty term")
            return render_template('search.html', results=None, search_term='', error="Please enter a search term.")

        MAX_LENGTH = 100
        if len(search_term) > MAX_LENGTH:
            logger.info(f"Search term too long: {search_term[:MAX_LENGTH]}")
            return render_template('search.html', results=None, search_term=search_term[:MAX_LENGTH], 
                                  error=f"Search term too long (max {MAX_LENGTH} characters).")

        logger.info(f"Search performed with term: {search_term}")

        conn = get_db_connection()
        if conn is None:
            logger.error("Database connection failed")
            return "Database connection failed", 500
        cur = conn.cursor()

        try:
            cur.execute("""
                SELECT character_id, name, full_name
                FROM targaryen
                WHERE name ILIKE %s
                ORDER BY name;
            """, (f'%{search_term}%',))
            results = cur.fetchall()
        except psycopg2.Error as e:
            logger.error(f"Database error during search: {e}")
            return render_template('search.html', results=None, search_term=search_term, 
                                  error="An error occurred while searching.")
        finally:
            cur.close()
            conn.close()

        return render_template('search.html', results=results, search_term=search_term)
    return render_template('search.html', results=None)

if __name__ == '__main__':
    debug_mode = os.getenv('FLASK_DEBUG', 'False').lower() in ('true', '1', 't')
    app.run(debug=debug_mode)