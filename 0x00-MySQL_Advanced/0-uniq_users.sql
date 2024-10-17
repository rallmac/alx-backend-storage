-- This script creates a table called users
-- It drops the table if it already exists
DROP TABLE IF EXISTS users;

CREATE TABLE users (
    id INT PRIMARY KEY NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    name VARCHAR(255)
);
