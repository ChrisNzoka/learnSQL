-- Aggregate functions are used with the select keyword to aggregate fields
-- functions like count(), max(), and min() can be used on non-numeric data
-- Min() and max() gives the lowest and highest values in a field respectively.
-- for strings, lowest and highest translates to A(lowest) - Z(highest) alphabetical order
-- for dates, lowest is the earliest date while highest is the latest date

SELECT 
    MAX(id)
FROM
    employee_id;
    
SELECT 
    MIN(id)
FROM
    employee_id;
    
SELECT 
    AVG(id)
FROM
    employee_id;
-- selects maximum, minimum or average value for int or decimal data types

SELECT
	SUM(budget)
FROM
	films;
-- sums up the entire budget field

SELECT 
    COUNT(id)
FROM
    employee_id;
-- gives the total number of entries for the id column of the employee_id table

SELECT 
    MIN(country)
FROM
    films;

SELECT 
    MAX(location)
FROM
    address;
    
SELECT 
    MIN(duration) shortest_film
FROM
    films;

-- using where statement with aggregate function
-- This works bcos where statements are executed b4 the select statements
SELECT 
    MIN(duration) shortest_film
FROM
    films
    where release_year = 2010;
    
-- Combining aggregate functions with WHERE
#When combining aggregate functions with WHERE, you get a powerful tool that allows you to get more granular with your insights, for example, to get the total budget of movies made from the year 2010 onwards.

-- Calculate the sum of gross from the year 2000 or later
SELECT 
    SUM(gross) total_gross
FROM
    films
WHERE
    release_year >= 2000;
    
-- Calculate the average gross of films that start with A
SELECT 
    AVG(gross) avg_gross_A
FROM
    films
WHERE
    title LIKE 'A%'
;

-- Calculate the lowest gross film in 1994
SELECT 
    MIN(gross) lowest_gross
FROM
    films
WHERE
    release_year = 1994;
    
-- Calculate the highest gross film released between 2000-2012
SELECT 
    MAX(gross) highest_gross
FROM
    films
WHERE
    release_year BETWEEN 2000 AND 2012;
    
# Using ROUND()
-- Round the average number of facebook_likes to one decimal place
SELECT 
    ROUND(AVG(facebook_likes), 1) avg_facebook_likes
FROM
    reviews;

-- Calculate the average budget rounded to the thousands
SELECT 
    ROUND(AVG(budget), - 3) avg_budget_thousands
FROM
    films;