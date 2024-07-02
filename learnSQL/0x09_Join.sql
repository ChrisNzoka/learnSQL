-- Joins

-- joins allow you to combine 2 tables together (or more) if they have a common column.
-- The common column doesn't need the same column name, but the data in it are the same and can be used to join the tables together
-- there are several joins we will look at, INNER JOIN, OUTER JOIN (LEFT JOIN, RIGHT JOIN and FULL JOIN), self joins, CROSS JOIN
-- check attached images for different joins
/* Also, the order of execution is:
FROM
WHERE
GROUP BY
HAVING
SELECT
ORDER BY
LIMIT.
*/

-- here are the first 2 tables - let's see what columns and data in the rows we have in common that we can join on
SELECT *
FROM employee_demographics;

SELECT *
FROM employee_salary;

-- INNER JOIN ----------------------------------------------------------------
-- inner joins return rows that are the same in both columns
-- since we have the same columns we need to specify which table they're coming from
SELECT *
FROM employee_demographics
JOIN employee_salary
        ON employee_demographics.employee_id = employee_salary.employee_id;
-- the JOIN keyword defaults to INNER JOIN. Thus, "JOIN" is the same as "INNER JOIN"
-- notice Ron Swanson isn't in the results? This is because he doesn't have an employee id in the demographics table. He refused to give his birth date or age or gender

-- using aliasing!
-- Aliasing employs the "AS" keyword to rename a column. For instance
SELECT 
    occupation AS job
FROM
    employee_salary;
-- This will display the occupation column titled as jobs
-- we can also create the alias without using the AS keyword by just writing the alias next to the column name

SELECT 
    occupation job
FROM
    employee_salary;

SELECT *
FROM employee_demographics dem
INNER JOIN employee_salary sal
        ON dem.employee_id = sal.employee_id;
        
-- We can select specific columns by listing them on the SELECT command
-- Notably, for join, we'll have to specify the common columns present on both tables
   -- using the "table.column" format

SELECT dem.employee_id, sal.first_name, dem.last_name, occupation, salary
FROM employee_demographics dem
INNER JOIN employee_salary sal
        ON dem.employee_id = sal.employee_id;
-- When the column is unique to only one table, we don't need the table.column name.


-- OUTER JOINS ----------------------------------------------------------------

-- for outer joins we have a left, right and full join
-- a left join will take everything from the left table even if there is no match in the join, but will only return matches from the right table
-- the exact opposite is true for a right join

SELECT *
FROM employee_salary sal
LEFT JOIN employee_demographics dem
        ON dem.employee_id = sal.employee_id;

-- so you'll notice we have everything from the left table or the salary table. Even though there is no match to ron swanson.
-- Since there is not match on the right table it's just all Nulls

-- if we just switch this to a right join it basically just looks like an inner join
-- that's because we are taking everything from the demographics table and only matches from the left or salary table. Since they have all the matches
-- it looks kind of like an inner join

SELECT *
FROM employee_salary sal
RIGHT JOIN employee_demographics dem
        ON dem.employee_id = sal.employee_id;
        
-- FULL JOIN joins all records of the selected fields with null values in cells that doesn't have a match
SELECT name AS country, code, region, basic_unit
FROM countries
-- Join to currencies
FULL JOIN currencies
USING (code)
-- Where region is North America or name is null
WHERE (region = 'North America') OR (name IS NULL)
ORDER BY region;



-- Self Join -----------------------------------------------------------

-- a self join is where you tie a table to itself
-- Here, ann alias is very important

SELECT *
FROM employee_salary;

-- what we could do is a secret santa so the person with the higher ID is the person's secret santa
-- here, we can use + and - on the parameters of the ON statement to alter the output
SELECT *
FROM employee_salary emp1
JOIN employee_salary emp2
        ON emp1.employee_id = emp2.employee_id
    ;

-- now let's change it to give them their secret santa
SELECT *
FROM employee_salary emp1
JOIN employee_salary emp2
        ON emp1.employee_id + 1  = emp2.employee_id
    ;

SELECT emp1.employee_id as emp_santa, emp1.first_name as santa_first_name, emp1.last_name as santa_last_name, emp2.employee_id, emp2.first_name, emp2.last_name
FROM employee_salary emp1
JOIN employee_salary emp2
        ON emp1.employee_id + 1  = emp2.employee_id;
-- So leslie is Ron's secret santa and so on

-- Next, let's compare records from 2010 and 2015 on a population database
-- eliminate unwanted records by extending the WHERE statement to include only records where
-- the p1.year matches p2.year - 5
SELECT 
    p1.country_code, p1.size AS size2010, p2.size AS size2015
FROM
    populations AS p1
        INNER JOIN
    populations AS p2 ON p1.country_code = p2.country_code
WHERE
    p1.year = 2010 AND p1.year = p2.year - 5;
    
    
-- Joining multiple tables --------------------------------------------------------
-- now we have another table we can join - let's take a look at it
SELECT *
FROM parks_and_recreation.parks_departments;


SELECT *
FROM employee_demographics dem
INNER JOIN employee_salary sal
        ON dem.employee_id = sal.employee_id
JOIN parks_departments dept
        ON dept.department_id = sal.dept_id;

-- now notice when we did that, since it's an inner join it got rid of andy because he wasn't a part of any department

-- if we do a left join we would still include him because we are taking everything from the left table which is the salary table in this instance
SELECT *
FROM employee_demographics dem
INNER JOIN employee_salary sal
        ON dem.employee_id = sal.employee_id
LEFT JOIN parks_departments dept
        ON dept.department_id = sal.dept_id;
        
-- Now, let's play on whatwe've learned
SELECT 
    dem.employee_id, dem.first_name, dem.last_name, age, gender, occupation, salary, department_name
FROM
    employee_demographics dem
JOIN employee_salary sal
    ON dem.employee_id = sal.employee_id
Join parks_departments pd
on sal.dept_id = pd.department_id;

-- Using USING -----------------------------------------------------------
# When joining on two identical column names, we can employ the USING command
# followed by the shared column name in parentheses.
# Here, since the join field is named "employee_id" in both tables, we can use USING.

SELECT 
    dem.employee_id,
    dem.first_name,
    dem.last_name,
    age,
    gender,
    occupation,
    salary
FROM
    employee_demographics dem
        JOIN
    employee_salary sal USING (employee_id);
    
-- ---------------------------------------------------------------------------------------------------
/* Question
Select the incorrect answer from the following options.
(a) There are at least three languages spoken in Armenia.
(b) Alsatian is spoken in more than one country.
(c) Bhojpuri is spoken in two countries.

Note: The query you generated in step 1 is provided below.
Run this query (or the amendment you made in step 2) in the console to find the answer to the question.

SELECT c.name AS country, l.name AS language
FROM countries AS c
INNER JOIN languages AS l
USING(code)
ORDER BY country;
*/

-- Solution: To find the answer, let's run the join code and pass it through a CTE to verify each of the answer
#1 checking if there are at least three languages spoken in Armenia
WITH lang_count AS
(
SELECT c.name AS country, l.name AS language
FROM countries AS c
INNER JOIN languages AS l
USING(code)
ORDER BY country
)
Select country, count(language)
from lang_count
where country = 'Armenia'
group by country;

#2 checking if Bhojpuri is spoken in two countries
WITH lang_count AS
(
SELECT c.name AS country, l.name AS language
FROM countries AS c
INNER JOIN languages AS l
USING(code)
ORDER BY country
)
Select country, count(language)
from lang_count
where language = 'Bhojpuri'
group by country;

#3 checking if Alsatian is spoken in more than one country.
WITH lang_count AS
(
SELECT c.name AS country, l.name AS language
FROM countries AS c
INNER JOIN languages AS l
USING(code)
ORDER BY country
)
Select country, count(language)
from lang_count
where language = 'Alsatian'
group by country;

-- from our findings, the incorrect answer is (b) Alsatian is spoken in more than one country.

-- Modify this query to use RIGHT JOIN instead of LEFT JOIN
/* SELECT countries.name AS country, languages.name AS language, percent
FROM countries
LEFT JOIN languages
USING(code)
ORDER BY language;
*/
-- Answer
SELECT c.name AS country, l.name AS language, percent
FROM languages AS l
RIGHT JOIN countries AS c
USING(code)
ORDER BY language;

-- CROSS JOIN -----------------------------------------------------------------
-- they create all possible combinations of two tables.
/*
CROSS JOIN can be incredibly helpful when asking questions that involve
looking at all possible combinations or pairings between two sets of data.

Imagine you are a researcher interested in the languages spoken in two countries:
Pakistan and India. You are interested in asking:

- What are the languages presently spoken in the two countries?
- Given the shared history between the two countries,
  what languages could potentially have been spoken in either country
  over the course of their history?

In this exercise, we will explore how INNER JOIN and CROSS JOIN can help us
answer these two questions, respectively.
*/

-- What are the languages presently spoken in the two countries?
SELECT c.name AS country, l.name AS language
FROM countries AS c
INNER JOIN languages AS l
using (code)
WHERE c.code IN ('PAK','IND')
	AND l.code in ('PAK','IND');
    
-- what languages could potentially have been spoken in either country over the course of their history?
SELECT c.name AS country, l.name AS language
FROM countries AS c        
-- Perform a cross join to languages (alias as l)
CROSS JOIN languages AS l
WHERE c.code in ('PAK','IND')
	AND l.code in ('PAK','IND');

-- random test
SELECT 
	c.name AS country,
    region,
    life_expectancy AS life_exp
FROM countries AS c
-- Join to populations (alias as p) using an appropriate join
INNER JOIN populations AS p
ON c.code = p.country_code
-- Filter for only results in the year 2010
WHERE year = 2010
-- Sort by life_exp
order BY life_exp
-- Limit to five records
LIMIT 5;