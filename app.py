from flask import Flask, render_template, request
from dotenv import load_dotenv
import psycopg2
import os

load_dotenv()

app = Flask(__name__)

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

# home
@app.route('/')
def index():
    return render_template('index.html')

# targaryens
@app.route('/targaryens')
def targaryens():
    conn = get_db_connection()
    if conn is None:
        return 'Database connection failed', 500
    cur = conn.cursor()
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
        GROUP BY t.character_id, t.name, t.full_name, t.birth_date, t.death_date, t.reign_start, t.reign_end
        ORDER BY t.name;
    ''')
    targaryens = cur.fetchall()
    cur.close()
    conn.close()
    return render_template('targaryens.html', targaryens=targaryens)

# dragons
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

# relationships
@app.route('/relationships')
def relationships():
    conn = get_db_connection()
    if conn is None:
        return 'Database connection failed', 500
    cur = conn.cursor()
    
    # parent-child
    cur.execute('''
        SELECT t1.name AS child, t2.name AS parent
        FROM targaryen_parent tp
        JOIN targaryen t1 ON tp.child_id = t1.character_id
        JOIN targaryen t2 ON tp.parent_id = t2.character_id
        ORDER BY t1.name;
    ''')
    parents = cur.fetchall()
    
    # spouses
    cur.execute('''
        SELECT t1.name AS targaryen, t2.name AS spouse, ts.marriage_date, ts.end_date
        FROM targaryen_spouse ts
        JOIN targaryen t1 ON ts.targaryen_id = t1.character_id
        JOIN targaryen t2 ON ts.spouse_id = t2.character_id
        ORDER BY t1.name;
    ''')
    spouses = cur.fetchall()
    
    cur.close()
    conn.close()
    return render_template('relationships.html', parents=parents, spouses=spouses)

# search
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