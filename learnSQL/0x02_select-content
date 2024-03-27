SELECT * FROM employee_id;
--prints all the content of the employee_id table (where * is a placeholder to specify all columns)

SELECT TOP 6 * FROM employee_id;
--prints the top 6 rows of the table 

SELECT DISTINCT(id) FROM employee_id;
--selects specific information from the table

SELECT max(id) FROM employee_id;
SELECT min(id) FROM employee_id;
SELECT avg(id) FROM employee_id;
--selects maximum, minimum or average value for int or decimal data types

SELECT COUNT(id) FROM employee_id;
--gives the total number of entries for the id column of the employee_id table

SELECT id FROM employee_id AS ticket_id;
--prints the selected with the name ticket_id

SELECT *,
firstname + ' ' + lastname AS display_name
FROM employee_id;
--selects all columns and concatenates firstname and lastname to create a new column termed
--display_name with a space (' ') between them

SELECT *,
CONCAT(firstname, ' ', lastname) AS display_name
FROM employee_id;
--alternatively, we can use the CONCAT() function to concatenate columns


/*SQLite, SQLite, SQLite, SQLite, SQLite, SQLite, SQLite, SQLite, SQLite*/
SELECT customer_id, name FROM customer;
--selects only the specified columns, "customer_id, name", from the table

SELECT *, price * 1.07 AS TAXED_PRICE
FROM PRODUCT;
--generates a calculated column called TAXED_PRICE that is 7% higher than PRICE.
--AS statement (this is known as an alias):

SELECT
PRODUCT_ID,
DESCRIPTION,
PRICE AS UNTAXED_PRICE,
PRICE * 1.07 AS TAXED_PRICE
FROM PRODUCT
--selects the specified columns and uses aliases where specified

--SQLite provides a round() function that accepts two arguments in parentheses separated by a comma: the number
--to be rounded, and the number of decimal places to round to. To round the TAXED_PRICE to two decimal places, we can pass the multiplication expression PRICE
--* 1.07 as the first argument, and a 2 as the second:
SELECT
PRODUCT_ID,
DESCRIPTION,
PRICE,
round(PRICE * 1.07, 2) AS TAXED_PRICE
FROM PRODUCT;

SELECT NAME,
CITY || ', ' || STATE AS LOCATION
FROM CUSTOMER;
-- concatenates the columns CITY and STATE into a new column termed LOCATION

--You can even concatenate several fields into a single SHIP_ADDRESS value
SELECT NAME,
STREET_ADDRESS || ' ' || CITY || ', ' || STATE || ' ' || ZIP AS SHIP_ADDRESS
FROM CUSTOMER;

