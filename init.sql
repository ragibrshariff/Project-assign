CREATE DATABASE IF NOT EXISTS testdb;
USE testdb;

CREATE TABLE IF NOT EXISTS users (
  id INT PRIMARY KEY,
  name VARCHAR(100)
);

INSERT INTO users (id, name) VALUES (1, 'sharan'), (2, 'samrudh');

CREATE USER IF NOT EXISTS 'user'@'%' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON testdb.* TO 'user'@'%';
FLUSH PRIVILEGES;
