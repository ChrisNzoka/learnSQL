-- Set operations
-- SQL has three main set operations, UNION, INTERSECT and EXCEPT.
-- The attached Venn diagrams visualizes the differences between them
-- also, there are other diagrams showing the different set operations attached too
-- For all set operations, the number of selected columns and their respective data types must be identical.
-- For instance, we can't stack a number field on top of a character field.

-- UNION ------------------------------------------------------------------
SELECT 
    first_name, last_name
FROM
    employee_demographics 
UNION
SELECT 
    occupation, salary
FROM
    employee_salary;

SELECT 
    first_name, last_name
FROM
    employee_demographics 
UNION
SELECT 
    first_name, last_name
FROM
    employee_salary;
-- notice that the above querries get rid of duplicates
-- Thus, Union is actually shorthand for Union Distinct as below

SELECT 
    first_name, last_name
FROM
    employee_demographics 
UNION DISTINCT
SELECT 
    first_name, last_name
FROM
    employee_salary;
-- UNION can be helpful for consolidating data from multiple tables into one result that
--   can then be ordered in meaningful ways.
-- Select all fields from economies2015
SELECT *
FROM economies2015
-- Set operation
UNION DISTINCT #same as using just UNION
-- Select all fields from economies2019
SELECT *
FROM economies2019
ORDER BY code, year;


-- UNION ALL ------------------------------------------------------------------
-- includes all records without eliminating duplicates
SELECT 
    first_name, last_name
FROM
    employee_demographics 
UNION ALL
SELECT 
    first_name, last_name
FROM
    employee_salary;


-- UNION can help with Creating Labels ---------------------------------------------------------------
SELECT 
    first_name, last_name, 'Old Lady' AS Label
FROM
    employee_demographics
WHERE
    age > 40 AND gender = 'Female' 
UNION SELECT 
    first_name, last_name, 'Old Man' 
FROM
    employee_demographics
WHERE
    age > 40 AND gender = 'Male' 
UNION SELECT 
    first_name, last_name, 'Highly Paid Employee'
FROM
    employee_salary
WHERE
    salary >= 70000
ORDER BY first_name;
-- Notice that the Alias needed for the labeling is on the first query
-- the labels in the other statements doesn't need to be Aliased for this UNION

-- INTERSECT -----------------------------------------------------------------
-- INTERSECT takes two tables as input, and
-- returns only the records that exist in both tables.

-- Example; Return all cities with the same name as a country
SELECT 
    *
FROM
    layoffs
INTERSECT
SELECT 
    *
FROM
    layoffs_staging2;

-- EXCEPT --------------------------------------------------------------------------
-- EXCEPT allows us to identify the records that are present in one table, but not the other.
-- it retains only records from the left table that are not present in the right table.
-- Now, let's find the names of cities that do not have the same names as their countries.

SELECT name
FROM cities
EXCEPT
SELECT name
FROM countries
ORDER BY name;

/*
Set Operations require all fields to match, since we do not specify any fields to match on. This is also why it requires the left and right table to have the same number of columns in order to compare records.
*/