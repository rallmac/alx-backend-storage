--This script creates a table called users
--it drops the table if it already exits
DROP TABLE IF EXISTS users;


CREATE TABLE users (
	id INT PRIMARY KEY NOT NULL,
	email VARCHAR(255) NOT NULL UNIQUE,
	name VARCHAR(255),
	country VARCHAR(2) DEFAULT 'US' NOT NULL CHECK (country IN ('US', 'CO', 'TN'))
);
