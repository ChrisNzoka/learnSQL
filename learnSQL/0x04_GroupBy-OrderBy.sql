-- Order by
-- Sorts in ascending order by default

SELECT 
    *
FROM
    employee_id
ORDER BY age DESC;
-- arranges the table in descending order of age

SELECT 
    *
FROM
    employee_id
ORDER BY age;
-- arranges the table in order of age (the default order in SQL is ascending)

-- We can also order by multiple fields
SELECT 
    *
FROM
    employee_id
WHERE age is not null
ORDER BY gender, age DESC;
-- arranges the table in Ascending order of gender and descending order of age
-- Also, 'is not null' ensures that only records with a recorded age is outputed

SELECT 
    *
FROM
    employee_id
ORDER BY  age, gender DESC;
-- arranges the table in Ascending order of age and descending order of gender
-- (however, the age querry takes prescedence here making the gender useless)

-- We don't have to select the field we are sorting by
SELECT 
    first_name
FROM
    employee_demographics
ORDER BY age DESC;

SELECT 
    *
FROM
    employee_id
ORDER BY 4 DESC;
-- here, the column name is replaced with number (columns are numbered based on their position)
-- id | firstname | lastname | age | gender
-- id=1, firstname=2, lastname=3, ...

-- ---------------------------- GROUP BY ------------------------------------------------ -- 
-- Error handling
#SQL will return an error if we try to SELECT a field that is not in our GROUP BY clause.
-- Example
SELECT 
    certificate, title
FROM
    films
GROUP BY certificates;
#We'll need to correct this by adding an aggregate function around title.
SELECT 
    certificate, COUNT(title) sum_title
FROM
    films
GROUP BY certificates;

#Further examples
SELECT 
    Gender, COUNT(gender) AS gender_Count
FROM
    employee_id
GROUP BY gender;
-- groups the whole date based on gender and gives the total number of each gender as gender_Count column

SELECT 
    age, COUNT(age) AS ageCount
FROM
    employee_id
GROUP BY age;
-- groups the data by age giving the total number of people with each age as ageCount column

SELECT 
    gender, AVG(age)
FROM
    employee_demographics
group by gender;
-- tells us the average age of the employees by gender

SELECT 
    gender, MIN(age), MAX(age), COUNT(age), AVG(age)
FROM
    employee_demographics
GROUP BY gender;

-- GROUP BY with ORDER BY
# We can combine GROUP BY with ORDER BY to group our results,
-- make a calculation, and then order our results.
SELECT 
    certificate, COUNT(title) title_count
FROM
    films
GROUP BY certificates
order by title_count;
-- ORDER BY is always written after GROUP BY,
-- and notice that we can refer back to the alias within the query.
-- That is because of the order of execution.
/*
The order of execution here is:
FROM
GROUP
SELECT
ALIASING "AS"
sorting the results "Order by"
limiting them to the desired number "LIMIT"
*/


SELECT 
    release_year, COUNT(*) AS film_count
FROM
    films
GROUP BY release_year;
-- count(*) counts all the records for all fields unlike count(field_name) that only counts the records in the specified(field_name)

-- Find the release_year and average duration of films for each year
SELECT 
    release_year, AVG(duration) avg_duration
FROM
    films
GROUP BY release_year;

-- Find the release_year, country, and max_budget, then group and order by release_year and country
SELECT 
    release_year, country, MAX(budget) AS max_budget
FROM
    films
GROUP BY release_year , country
ORDER BY release_year , country;

-- Which release_year had the most language diversity
SELECT 
    release_year, COUNT(DISTINCT language) lang_count
FROM
    films
GROUP BY release_year
ORDER BY lang_count DESC;

-- HAVING --
# In SQL, we can't filter aggregate functions with WHERE clauses.
# For example, this query attempting to filter the title count is invalid:

SELECT 
    release_year, COUNT(DISTINCT language) lang_count
FROM
    films
GROUP BY release_year
WHERE lang_count > 10;

-- Instead of using where after grouping, we'll use having:
SELECT 
    release_year, COUNT(DISTINCT language) lang_count
FROM
    films
GROUP BY release_year
HAVING lang_count > 10;

/*. Order of execution
The reason why groups have their own keyword for filtering comes down to the order of execution.
The order of execution is:
FROM
WHERE
GROUP BY
HAVING
SELECT
ORDER BY
LIMIT.
By reviewing this order, we can see WHERE is executed before GROUP BY and before any aggregation occurs. 
This order is also why we cannot use the alias with HAVING, but we can with ORDER BY.
*/