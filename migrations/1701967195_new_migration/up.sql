-- Write your up migration here
CREATE TABLE IF NOT EXISTS new_users (
    name TEXT,
    password TEXT
);
