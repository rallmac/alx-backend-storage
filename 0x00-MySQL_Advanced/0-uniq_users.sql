-- This script creates a table called users
-- it overwrites any existing table with the same name
CREATE TABLE users overwrite if EXISTS(
	id = 'PRIMARY KEY' 'not null'
	email = 'STRING' 'CHAR(255)' 'not Null' 'unique'
	name = 'STRING' 'CHAR(255)'
);
