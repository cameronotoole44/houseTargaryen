from flask import Flask, render_template, request
from dotenv import load_dotenv
import psycopg2
import os

load_dotenv()

app = Flask(__name__)

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
        conn = psycopg2.connect(
            dbname=os.getenv('DB_NAME'),
            user=os.getenv('DB_USER'),
            password=os.getenv('DB_PASSWORD'),
            host=os.getenv('DB_HOST'),
            port=os.getenv('DB_PORT')
        )
        return conn
    except Exception as e:
        print(f'Error connecting to database: {e}')
        return None

# HOME
@app.route('/')
def index():
    return render_template('index.html')

# TARGAREYNS WITH THEIR SORTING
@app.route('/targaryens')
def targaryens():
    sort = request.args.get('sort', 'alphabetical')

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
        ORDER BY l.generation, COALESCE(l.birth_year, -9999) ASC;
        '''
        cur.execute(query)
        targaryens = cur.fetchall()
        cur.close()
        conn.close()
        return render_template('targaryens.html', targaryens=targaryens, sort=sort)
    else:
        order_by = 'ORDER BY t.name'

    query = base_query + ' ' + order_by
    cur.execute(query)
    targaryens = cur.fetchall()
    cur.close()
    conn.close()
    return render_template('targaryens.html', targaryens=targaryens, sort=sort)

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
    ruled = targaryen[5] is not None  # reign_start index

    return render_template('individual.html', targaryen=targaryen, parents=parents, ruled=ruled)

# DRAGONS
@app.route('/dragons')
def dragons():
    conn = get_db_connection()
    if conn is None:
        return 'Database connection failed', 500
    cur = conn.cursor()
    cur.execute('''
        SELECT dragon_id, name, color, eye_color, fireball_color
        FROM dragon
        ORDER BY name;
    ''')
    dragons = cur.fetchall()
    cur.close()
    conn.close()
    return render_template('dragons.html', dragons=dragons)

# RELATIONSHIPS
@app.route('/relationships')
def relationships():
    conn = get_db_connection()
    if conn is None:
        return 'Database connection failed', 500
    cur = conn.cursor()
    
    # PARENT -- CHILD
    cur.execute('''
        SELECT t1.name AS child, t2.name AS parent
        FROM targaryen_parent tp
        JOIN targaryen t1 ON tp.child_id = t1.character_id
        JOIN targaryen t2 ON tp.parent_id = t2.character_id
        ORDER BY t1.name;
    ''')
    parents = cur.fetchall()
    
    # TARGARYEN - TARGARYEN SPOUSE
    cur.execute('''
        SELECT t1.name AS targaryen, t2.name AS spouse, ts.marriage_date, ts.end_date
        FROM targaryen_spouse ts
        JOIN targaryen t1 ON ts.targaryen_id = t1.character_id
        JOIN targaryen t2 ON ts.spouse_id = t2.character_id
        ORDER BY t1.name;
    ''')
    spouses = cur.fetchall()
    
    # NON TARGARYEN SPOUSES
    cur.execute('''
        SELECT 
            t.name AS targaryen, 
            nt.name AS non_targaryen_spouse,
            nt.full_name,
            tnts.marriage_date,
            tnts.end_date
        FROM targaryen_non_targaryen_spouse tnts
        JOIN targaryen t ON tnts.targaryen_id = t.character_id
        JOIN non_targaryen nt ON tnts.non_targaryen_id = nt.non_targaryen_id
        ORDER BY t.name;
    ''')
    non_targaryen_spouses = cur.fetchall()
    
    cur.close()
    conn.close()
    return render_template('relationships.html', 
                          parents=parents, 
                          spouses=spouses,
                          non_targaryen_spouses=non_targaryen_spouses)

# SEARCH
@app.route('/search', methods=['GET', 'POST'])
def search():
    if request.method == 'POST':
        search_term = request.form['search_term']
        conn = get_db_connection()
        if conn is None:
            return "Database connection failed", 500
        cur = conn.cursor()
        cur.execute("""
            SELECT character_id, name, full_name
            FROM targaryen
            WHERE name ILIKE %s
            ORDER BY name;
        """, (f'%{search_term}%',))
        results = cur.fetchall()
        cur.close()
        conn.close()
        return render_template('search.html', results=results, search_term=search_term)
    return render_template('search.html', results=None)

if __name__ == '__main__':
    app.run(debug=True)