SELECT 
    *
FROM
    employee_id;
-- prints all the content of the employee_id table (where * is a placeholder to specify all columns)

SELECT 
    *
FROM
    parks_and_recreation.employee_demographics;
    -- selects all the content of the table in the database specified in the format above (SCHEMA.TABLE)
    /* where;
    parks_and_recreation = SCHEMA
    employee_demographics = Table
*/

/*SELECT TOP 6 * FROM employee_id;
-- prints the top 6 rows of the table for sqlserver flavour*/

SELECT DISTINCT
    (id)
FROM
    employee_id;
-- selects unique information from the table


SELECT 
    id AS ticket_id
FROM
    employee_id;
-- prints the selected field with the name ticket_id on display

SELECT 
    *, firstname + ' ' + lastname AS display_name
FROM
    employee_id;
-- selects all columns and concatenates firstname and lastname to create a new column termed
-- display_name with a space (' ') between them

SELECT 
    *, CONCAT(firstname, ' ', lastname) AS display_name
FROM
    employee_id;
-- alternatively, we can use the CONCAT() function to concatenate columns

SELECT 
    customer_id, `name`
FROM
    customer;
-- selects only the specified columns, "customer_id, name", from the table

SELECT 
    *, price * 1.07 AS TAXED_PRICE
FROM
    product;
-- generates a calculated column called TAXED_PRICE that is 7% higher than PRICE.
-- AS statement (this is known as an alias):

SELECT 
    PRODUCT_ID,
    DESCRIPTION,
    PRICE AS UNTAXED_PRICE,
    PRICE * 1.07 AS TAXED_PRICE
FROM
    PRODUCT;
-- selects the specified columns and uses aliases where specified
-- PEMDAS is the order of calculation in MYSQL. where P = Parenthesis, E = Exponential, M = Multiplication, D = Division, A = Addition, and S = Subtraction

SELECT 
    PRODUCT_ID,
    DESCRIPTION,
    PRICE,
    ROUND(PRICE * 1.07, 2) AS TAXED_PRICE
FROM
    PRODUCT;

SELECT 
    NAME, CITY || ', ' || STATE AS LOCATION
FROM
    CUSTOMER;
-- concatenates the columns CITY and STATE into a new column termed LOCATION for SQLite flavour

SELECT 
    NAME,
    STREET_ADDRESS || ' ' || CITY || ', '
        || STATE
        || ' '
        || ZIP AS SHIP_ADDRESS
FROM
    CUSTOMER;

-- we can use count and distinct to count the exact number of unique entiries in a table.
-- Count the distinct countries from the films table
SELECT 
    COUNT(DISTINCT country) AS count_distinct_countries
FROM
    films;
-- If we reverse the keyword location, it;ll count first before executing the distinct which multiplies the count value by itself
SELECT DISTINCT
    COUNT(country) count_distinct_countries
FROM
    films;
--    The above querry will work but it'll give the wrong value.