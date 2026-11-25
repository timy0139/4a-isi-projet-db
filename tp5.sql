PRAGMA foreign_keys = ON;  

CREATE TABLE IF NOT EXISTS user (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    username TEXT    NOT NULL UNIQUE,
    password TEXT    NOT NULL,
    is_admin INTEGER NOT NULL DEFAULT 0 CHECK (is_admin IN (0, 1)),
    is_blocked INTEGER NOT NULL DEFAULT 0 CHECK (is_blocked IN (0, 1))
);

CREATE TABLE IF NOT EXISTS product (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name         TEXT    NOT NULL,
    description  TEXT,
    price FLOAT    NOT NULL CHECK (price >= 0),
    stock INTEGER NOT NULL DEFAULT 0 CHECK (stock >= 0),
    is_available INTEGER NOT NULL DEFAULT 1 CHECK (is_available IN (0, 1))
);

CREATE TABLE IF NOT EXISTS menu (
    id   INTEGER PRIMARY KEY AUTOINCREMENT,
    name   TEXT NOT NULL,
    description TEXT,
    price REAL NOT NULL CHECK (price >= 0),
    available_from TEXT NOT NULL,                  -- 'YYYY-MM-DD'
    available_to   TEXT NOT NULL,                  -- 'YYYY-MM-DD'
    CHECK (available_to >= available_from)  -- vérif si date correspondante
);


CREATE TABLE IF NOT EXISTS `order` (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id     INTEGER NOT NULL,
    pickup_date TEXT    NOT NULL,                       -- format 'YYYY-MM-DD'
    status  TEXT    NOT NULL DEFAULT 'en_attente'
                CHECK (status IN ('en_attente', 'prete', 'recuperee', 'non_honoree')),
    create_at TEXT    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE IF NOT EXISTS order_line (
    id  INTEGER PRIMARY KEY AUTOINCREMENT,
    order_id INTEGER NOT NULL,
    product_id INTEGER,                                 -- NULL si la ligne est un menu
    menu_id    INTEGER,                                 -- NULL si la ligne est un produit
    quantity   INTEGER NOT NULL DEFAULT 1 CHECK (quantity > 0),
    FOREIGN KEY (order_id)   REFERENCES orders(id)   ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(id),
    FOREIGN KEY (menu_id)    REFERENCES menus(id),

    CHECK ((product_id IS NOT NULL) + (menu_id IS NOT NULL) = 1)
);




CREATE TABLE IF NOT EXISTS menu_product (
    menu_id    INTEGER NOT NULL,
    product_id INTEGER NOT NULL,
    PRIMARY KEY (menu_id, product_id),
    FOREIGN KEY (menu_id)    REFERENCES menus(id)    ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS closure_day (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    date TEXT NOT NULL,
    description TEXT
);