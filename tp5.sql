PRAGMA foreign_keys = ON;   -- SQLite ignore les clés étrangères sans ça

CREATE TABLE IF NOT EXISTS users (
    id            INTEGER PRIMARY KEY AUTOINCREMENT,
    username      TEXT    NOT NULL UNIQUE,
    password TEXT    NOT NULL,
    is_admin      INTEGER NOT NULL DEFAULT 0 CHECK (is_admin IN (0, 1)),
    is_blocked    INTEGER NOT NULL DEFAULT 0 CHECK (is_blocked IN (0, 1))
);



CREATE TABLE IF NOT EXISTS orders (
    id          INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id     INTEGER NOT NULL,
    pickup_date TEXT    NOT NULL,                       -- format 'YYYY-MM-DD'
    status      TEXT    NOT NULL DEFAULT 'en_attente'
                CHECK (status IN ('en_attente', 'prete', 'recuperee', 'non_honoree')),
    created_at  TEXT    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id)
);