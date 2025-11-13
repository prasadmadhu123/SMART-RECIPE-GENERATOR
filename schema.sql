-- Drop tables if they already exist to start fresh
DROP TABLE IF EXISTS recipe_ingredients;
DROP TABLE IF EXISTS recipes;
DROP TABLE IF EXISTS ingredients;

-- Table for all ingredients
CREATE TABLE ingredients (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT KEY NULL UNIQUE
);

-- Table for all recipes
CREATE TABLE recipes (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    instructions TEXT NOT NULL
);

-- "Junction" table to link ingredients to recipes (many-to-many)
CREATE TABLE recipe_ingredients (
    recipe_id INTEGER,
    ingredient_id INTEGER,
    PRIMARY KEY (recipe_id, ingredient_id),
    FOREIGN KEY (recipe_id) REFERENCES recipes(id),
    FOREIGN KEY (ingredient_id) REFERENCES ingredients(id)
);

-- --- Insert Sample Data ---

-- Ingredients
INSERT INTO ingredients (name) VALUES
('Pasta'), ('Tomato Sauce'), ('Ground Beef'), ('Onion'), ('Garlic'),
('Olive Oil'), ('Lettuce'), ('Tomato'), ('Cucumber'), ('Chicken Breast'),
('Bread'), ('Cheese'), ('Butter'),
-- New Ingredients
('Rice'), ('Black Beans'), ('Bell Pepper'), ('Soy Sauce'), ('Eggs'),
('Milk'), ('Lemon'), ('Potato'), ('Carrot');

-- Recipe 1: Spaghetti Bolognese
INSERT INTO recipes (name, instructions) VALUES
('Spaghetti Bolognese', '1. Brown beef with onion and garlic in olive oil. 2. Add tomato sauce and simmer. 3. Cook pasta. 4. Serve sauce over pasta.');
INSERT INTO recipe_ingredients (recipe_id, ingredient_id) VALUES
(1, (SELECT id FROM ingredients WHERE name = 'Pasta')),
(1, (SELECT id FROM ingredients WHERE name = 'Tomato Sauce')),
(1, (SELECT id FROM ingredients WHERE name = 'Ground Beef')),
(1, (SELECT id FROM ingredients WHERE name = 'Onion')),
(1, (SELECT id FROM ingredients WHERE name = 'Garlic')),
(1, (SELECT id FROM ingredients WHERE name = 'Olive Oil'));

-- Recipe 2: Chicken Salad
INSERT INTO recipes (name, instructions) VALUES
('Chicken Salad', '1. Cook and chop chicken breast. 2. Chop lettuce, tomato, and cucumber. 3. Combine all ingredients in a bowl.');
INSERT INTO recipe_ingredients (recipe_id, ingredient_id) VALUES
(2, (SELECT id FROM ingredients WHERE name = 'Chicken Breast')),
(2, (SELECT id FROM ingredients WHERE name = 'Lettuce')),
(2, (SELECT id FROM ingredients WHERE name = 'Tomato')),
(2, (SELECT id FROM ingredients WHERE name = 'Cucumber')),
(2, (SELECT id FROM ingredients WHERE name = 'Olive Oil'));

-- Recipe 3: Grilled Cheese
INSERT INTO recipes (name, instructions) VALUES
('Grilled Cheese', '1. Butter two slices of bread. 2. Place cheese between bread. 3. Grill in a pan until golden brown on both sides.');
INSERT INTO recipe_ingredients (recipe_id, ingredient_id) VALUES
(3, (SELECT id FROM ingredients WHERE name = 'Bread')),
(3, (SELECT id FROM ingredients WHERE name = 'Cheese')),
(3, (SELECT id FROM ingredients WHERE name = 'Butter'));

-- Recipe 4: Simple Tomato Pasta
INSERT INTO recipes (name, instructions) VALUES
('Simple Tomato Pasta', '1. Cook pasta. 2. Heat tomato sauce with olive oil and garlic. 3. Combine pasta and sauce.');
INSERT INTO recipe_ingredients (recipe_id, ingredient_id) VALUES
(4, (SELECT id FROM ingredients WHERE name = 'Pasta')),
(4, (SELECT id FROM ingredients WHERE name = 'Tomato Sauce')),
(4, (SELECT id FROM ingredients WHERE name = 'Garlic')),
(4, (SELECT id FROM ingredients WHERE name = 'Olive Oil'));

-- NEW Recipe 5: Chicken Stir-Fry
INSERT INTO recipes (name, instructions) VALUES
('Chicken Stir-Fry', '1. Slice chicken breast and bell pepper. 2. Stir-fry chicken in olive oil with garlic. 3. Add bell pepper and soy sauce. 4. Serve over rice.');
INSERT INTO recipe_ingredients (recipe_id, ingredient_id) VALUES
(5, (SELECT id FROM ingredients WHERE name = 'Chicken Breast')),
(5, (SELECT id FROM ingredients WHERE name = 'Bell Pepper')),
(5, (SELECT id FROM ingredients WHERE name = 'Soy Sauce')),
(5, (SELECT id FROM ingredients WHERE name = 'Garlic')),
(5, (SELECT id FROM ingredients WHERE name = 'Rice')),
(5, (SELECT id FROM ingredients WHERE name = 'Olive Oil'));

-- NEW Recipe 6: Simple Omelette
INSERT INTO recipes (name, instructions) VALUES
('Simple Omelette', '1. Whisk 2-3 eggs with a splash of milk. 2. Melt butter in a pan. 3. Pour in eggs and cook until set. 4. Add cheese if desired.');
INSERT INTO recipe_ingredients (recipe_id, ingredient_id) VALUES
(6, (SELECT id FROM ingredients WHERE name = 'Eggs')),
(6, (SELECT id FROM ingredients WHERE name = 'Milk')),
(6, (SELECT id FROM ingredients WHERE name = 'Butter')),
(6, (SELECT id FROM ingredients WHERE name = 'Cheese'));

-- NEW Recipe 7: Rice and Beans
INSERT INTO recipes (name, instructions) VALUES
('Rice and Beans', '1. Cook rice. 2. Heat black beans with chopped onion and garlic in olive oil. 3. Serve beans over rice.');
INSERT INTO recipe_ingredients (recipe_id, ingredient_id) VALUES
(7, (SELECT id FROM ingredients WHERE name = 'Rice')),
(7, (SELECT id FROM ingredients WHERE name = 'Black Beans')),
(7, (SELECT id FROM ingredients WHERE name = 'Onion')),
(7, (SELECT id FROM ingredients WHERE name = 'Garlic')),
(7, (SELECT id FROM ingredients WHERE name = 'Olive Oil'));

-- NEW Recipe 8: Lemon Chicken
INSERT INTO recipes (name, instructions) VALUES
('Lemon Chicken', '1. Season chicken breast. 2. Pan-sear chicken in olive oil and butter. 3. Squeeze fresh lemon juice over the chicken just before serving.');
INSERT INTO recipe_ingredients (recipe_id, ingredient_id) VALUES
(8, (SELECT id FROM ingredients WHERE name = 'Chicken Breast')),
(8, (SELECT id FROM ingredients WHERE name = 'Lemon')),
(8, (SELECT id FROM ingredients WHERE name = 'Butter')),
(8, (SELECT id FROM ingredients WHERE name = 'Olive Oil'));