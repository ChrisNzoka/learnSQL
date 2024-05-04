-- LIMIT "specifies how many rows we want in the output"

SELECT 
    *
FROM
    employee_demographics
LIMIT 3;

-- if we change something like the order or use a group by it would change the output
-- let's check for the oldest in the database

SELECT 
    *
FROM
    employee_demographics
ORDER BY age DESC
LIMIT 3;

-- now there is an additional paramater in limit which we can access using a comma that specifies the starting place

SELECT 
    *
FROM
    employee_demographics
ORDER BY first_name;

SELECT 
    *
FROM
    employee_demographics
ORDER BY first_name
LIMIT 3 , 2;

-- this now says start at position 3 and take 2 rows after that
-- this is not used a lot

SELECT 
    *
FROM
    employee_demographics
ORDER BY age DESC;
-- we can see it's Donna - let's try to select her
SELECT 
    *
FROM
    employee_demographics
ORDER BY age DESC
LIMIT 2 , 1;
