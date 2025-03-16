import sqlite3 from 'sqlite3';

sqlite3.verbose();

let db: sqlite3.Database;


export function initDatabase() {
    db = new sqlite3.Database('./diskrot.sqlite3', (err) => {
        if (err) {
            console.error("Error opening database:", err.message);
        } else {
            console.log("Connected to SQLite database.");
            // Create the users table if it doesn't exist
            db.run(`CREATE TABLE IF NOT EXISTS prompt (
                    id INTEGER PRIMARY KEY AUTOINCREMENT,
                    prompt TEXT,
                    model TEXT,
                    category TEXT,
                    is_default BOOLEAN
          )`, (err) => {
                if (err) console.error("Error creating table:", err.message);
                else console.log("Table created or already exists.");
            });
        }
    });

}