import sqlite3
from flask import Flask, render_template, request, g
import os

DATABASE = 'recipes.db'
app = Flask(__name__)
app.config['DATABASE'] = DATABASE

# --- Database Setup ---

def get_db():
    db = getattr(g, '_database', None)
    if db is None:
        db = g._database = sqlite3.connect(app.config['DATABASE'])
        db.row_factory = sqlite3.Row  # Allows accessing columns by name
    return db

@app.teardown_appcontext
def close_connection(exception):
    db = getattr(g, '_database', None)
    if db is not None:
        db.close()

def init_db():
    with app.app_context():
        db = get_db()
        with app.open_resource('schema.sql', mode='r') as f:
            db.cursor().executescript(f.read())
        db.commit()

# --- Application Logic ---

@app.route('/')
def index():
    """Show all available ingredients on the homepage."""
    db = get_db()
    cur = db.execute('SELECT id, name FROM ingredients ORDER BY name')
    ingredients = cur.fetchall()
    return render_template('index.html', ingredients=ingredients)

@app.route('/generate', methods=['POST'])
def generate():
    """
    "Smart" generator logic.
    Finds recipes that match the most ingredients selected by the user.
    """
    selected_ids = request.form.getlist('ingredient_id')

    if not selected_ids:
        return render_template('results.html', recipes=[])

    # Create a string of placeholders (?,?,?) for the SQL query
    placeholders = ', '.join(['?'] * len(selected_ids))

    # This SQL query finds recipes, counts how many of the selected
    # ingredients they contain, and orders them by the highest match count.
    query = f"""
        SELECT
            r.name,
            r.instructions,
            COUNT(ri.ingredient_id) AS match_count
        FROM
            recipes r
        JOIN
            recipe_ingredients ri ON r.id = ri.recipe_id
        WHERE
            ri.ingredient_id IN ({placeholders})
        GROUP BY
            r.id, r.name, r.instructions
        ORDER BY
            match_count DESC;
    """

    db = get_db()
    cur = db.execute(query, selected_ids)
    recipes = cur.fetchall()

    return render_template('results.html', recipes=recipes)

# --- Run the App ---

def check_db_exists():
    return os.path.exists(DATABASE)

if __name__ == '__main__':
    if not check_db_exists():
        print("Database not found. Initializing new database 'recipes.db'...")
        try:
            init_db()
            print("Database initialized with sample data.")
        except Exception as e:
            print(f"Error initializing database: {e}")
    else:
        print("Database already exists.")
        
    print("Starting Flask server at http://127.0.0.1:5000/")
    app.run(debug=True)