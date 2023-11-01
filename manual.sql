-- Create the database
CREATE DATABASE IF NOT EXISTS mundo;

-- Use the database
USE mundo;

-- To continue with the example of the 'mundo' database, we will create the 'pais' table to store country data:
CREATE TABLE IF NOT EXISTS pais (
    id int PRIMARY KEY,
    nombre varchar(20),
    continente varchar(50),
    poblacion int
);

-- Creating the 'Temp' table:
CREATE TABLE Temp (
id integer,
dato varchar(20)
);

-- Dropping the table:
DROP TABLE Temp;

-- Using the "ALTER TABLE" statement along with the "ADD PRIMARY KEY" clause, you can specify the column you want to set as the primary key.
ALTER TABLE pais;
ADD PRIMARY KEY (id);

-- Applying the insertion syntax to the 'pais' table to add 6 records would look like this:
INSERT INTO pais (id, nombre, continente, poblacion)
VALUES (101, "Colombia", "South America", 50000000);

INSERT INTO pais (id, nombre, continente, poblacion)
VALUES (102, "Ecuador", "South America", 17000000);

INSERT INTO pais (id, nombre, continente, poblacion)
VALUES (103, "Guatemala", "Central America", 17000000);

INSERT INTO pais (id, nombre, continente, poblacion)
VALUES (104, "Mexico", "Central America", 126000000);

INSERT INTO pais (id, nombre, continente, poblacion)
VALUES (105, "United States", "North America", 331000000);

INSERT INTO pais (id, nombre, continente, poblacion)
VALUES (106, "Canada", "Central America", 38000000);

-- Continuing with the 'pais' table exercise, we will modify the record for Colombia with id=101, updating the population to 50887423. The UPDATE statement would be:
UPDATE pais
SET poblacion = 50887423
WHERE id = 101;

-- Continuing with the 'pais' table exercise, we want to delete the record for Canada, whose id is 106. The DELETE statement would be:
DELETE FROM pais
WHERE id = 106;

-- Display a list of all registered countries
SELECT id, nombre, continente, poblacion 
FROM pais;

-- When you want to query all fields of a table, you use the wildcard operator "*"; the previous query would look like this:
SELECT * 
FROM pais;

-- Select the names of countries with less than 100 million inhabitants:
SELECT nombre
FROM pais
WHERE poblacion <= 100000000;

-- Select the first two names of countries with less than 100 million inhabitants.
SELECT nombre 
FROM pais
ORDER BY nombre
LIMIT 2;

-- Using the 'pais' table, you can construct the following query to create a table:
CREATE TABLE tempPais
AS
SELECT nombre, poblacion
FROM pais
WHERE poblacion <= 100000000;

-- You can use the 'tempPais' table created in the previous section like this:
DESCRIBE tempPais;

-- Creating the 'ciudad' table and relating it to the 'pais' table:
CREATE TABLE ciudad (
    id int PRIMARY KEY,
    nombre varchar(20),
    id_pais int,
    FOREIGN KEY (id_pais)
    REFERENCES pais (id)
);

-- Now, you'll create a 'idioma' table and establish a relationship with the 'pais' table:
create table idioma(
id int primary key,
idioma varchar(50)
);

-- Then, you'll create the 'idioma_pais' table, which will have fields related to the 'idioma' and 'pais' tables. The SQL statement is as follows:
create table idioma_pais (
id_idioma int,
id_pais int,
es_oficial boolean default false,
primary key (id_idioma, id_pais),
foreign key (id_idioma) references idioma(id),
foreign key (id_pais) references pais(id)
);

-- 1. Simple Field Aliases:
SELECT nombre AS client_name, edad AS client_age FROM clients;

-- 2. Field Aliases with Functions:
SELECT AVG(precio) AS average_price FROM products;

-- 3. Field Aliases with Expressions:
SELECT cantidad * precio AS total FROM orders;

-- Simple table alias:
SELECT u.nombre, u.edad
FROM users AS u;

-- Table alias with joins:
SELECT u.nombre, p.fecha
FROM users AS u
JOIN orders AS p ON u.id = p.user_id;

-- Using table alias in subqueries:
SELECT u.nombre
FROM (SELECT * FROM users WHERE age > 30) AS u;

-- Here is some information about some of the most commonly used field functions in MySQL, along with their definitions and usage examples.

Function
Definition
Example Usage
CONCAT()
Concatenates two or more strings


SELECT CONCAT(nombre, ' ', apellido) AS full_name FROM users;
UPPER()
Converts a string to uppercase


SELECT UPPER(nombre) AS uppercase_name FROM users;
LOWER()
Converts a string to lowercase


SELECT LOWER(apellido) AS lowercase_lastname FROM users;
LENGTH()
Returns the length of a string


SELECT LENGTH(nombre) AS name_length FROM users;
SUBSTRING()
Extracts a part of a string


SELECT SUBSTRING(nombre, 1, 3) AS substring FROM users;
TRIM()
Removes spaces from a string


SELECT TRIM(nombre) AS name_without_spaces FROM users;
ROUND()
Rounds a number


SELECT ROUND(precio, 2) AS rounded_price FROM products;
DATE_FORMAT()
Formats a date
SELECT DATE_FORMAT(fecha_nacimiento, '%d-%m-%Y') AS formatted_date FROM users;
NOW()
Returns the current date and time


SELECT NOW() AS current_date FROM users;
IFNULL();
-- Returns an alternative value if it is null

SELECT IFNULL(nombre, 'N/A') AS alternative_name FROM users;

-- Example of conditional assignment:
SELECT nombre, precio, IF(precio > 100, 'High', 'Low') AS price_category 
FROM products;

-- Example of conditional calculation:
SELECT nombre, salario, bono, 
    IF(salario > 5000, salario + bono, salario) AS total_salary 
FROM employees;

-- Inner Joins
SELECT column_name(s)
FROM table1
INNER JOIN table2
ON table1.column_name = table2.column_name;

-- An example with INNER JOINS would be to list all cities in Mexico. The SQL query would be:
SELECT pais.nombre AS country, ciudad.nombre AS city
FROM pais
INNER JOIN ciudad
ON pais.id = ciudad.id_pais
WHERE pais.nombre = "Mexico";

-- Left Joins

-- The syntax for LEFT JOINS is:
SELECT column_name(s)
FROM table1
LEFT JOIN table2
ON table1.column_name = table2.column_name;

-- An example with LEFT JOINS would be to list all countries and the cities in the database. The SQL query would be:
SELECT pais.nombre AS country, ciudad.nombre AS city
FROM pais
LEFT JOIN ciudad
ON pais.id = ciudad.id_pais;

-- Right Join

-- The syntax for RIGHT JOIN is:
SELECT column_name(s)
FROM table1
RIGHT JOIN table2
ON table1.column_name

-- An example with RIGHT JOINS would be to list all cities and the countries they belong to. The SQL query would be:
SELECT pais.nombre AS country, ciudad.nombre AS city
FROM pais
RIGHT JOIN ciudad
ON pais.id = ciudad.id_pais;

-- Subqueries
SELECT column_name(s)
FROM table1
WHERE column_name OPERATOR (SELECT column_name(s) FROM table2);

-- A first example of a subquery would be:
SELECT nombre 
FROM pais 
WHERE poblacion > (SELECT AVG(poblacion) FROM pais);

--     1. Step 1: Identify the tables and solve the inner query.
-- The inner query answers the question of finding the lowest population in the 'pais' table.

SELECT min(poblacion) FROM pais;

--     2. Step 2: Identify the tables and solve the outer query.
-- The outer query lists the names of cities in the countries.

SELECT C.nombre
FROM ciudad AS C
INNER JOIN pais AS P ON P.id = C.id_pais;

--     3. Step 3: Add the inner query to the outer query.
-- To add the inner query to the outer query, it's done through a WHERE clause that equates the population of a country to the result of the subquery that found the lowest population among all countries.
SELECT C.nombre
FROM ciudad AS C
INNER JOIN pais AS P ON P.id = C.id_pais
WHERE P.poblacion = (SELECT min(poblacion) FROM pais);