# Subqueries

#Subqueries are queries within queries.
-- Note: subqueries in a 'SELECT' statement are seen as a column thus require an Alias
-- Also, subqueries in 'FROM' statements are seen as table and must be named using alias.
-- Subqueries in WHERE statements ---------------------------------------------------
-- Here, we can have SEMI JOIN (USES "IN") and ANTI JOIN (USES "NOT IN")

#Now let's say we wanted to look at employees who actually work in the Parks and Rec Department, we could join tables together or we could use a subquery

SELECT 
    *
FROM
    employee_demographics
WHERE
    employee_id IN (SELECT 
            employee_id
        FROM
            employee_salary
        WHERE
            dept_id = 1);

#So we are using that subquery in the where statement and if we just highlight the subquery and run it, it's basically a list we are selecting from in the outer query

SELECT *
FROM employee_demographics
WHERE employee_id IN
                        (SELECT employee_id, salary
                                FROM employee_salary
                WHERE dept_id = 1);

# now if we try to have more than 1 column in the subquery like above, we get an error saying the operand should contain 1 column only

/*
Let's say we are interested in identifying languages spoken in the Middle East.
The "languages" table contains information about languages and countries, but it does not tell us what region the countries belong to.
Thus, we can build up a semi join (subquery) by filtering the countries table by a particular region, and then using this to further filter the languages table.
*/

SELECT DISTINCT
    `name`
FROM
    languages
WHERE
    `code` IN (SELECT 
            `code`
        FROM
            countries
        WHERE
            region = 'Middle East')
ORDER BY `name`;


/*
Say we are interested in identifying currencies of Oceanian countries.
We have written the following INNER JOIN, which returns 15 records.
Now, we want to ensure that all Oceanian countries from the countries table are included in this result.
We'll do this in the first step.
*/

SELECT 
    c1.code, name, basic_unit AS currency
FROM
    countries AS c1
        INNER JOIN
    currencies AS c2 ON c1.code = c2.code
WHERE
    c1.continent = 'Oceania';
    
    
/*
NOTE: If there are any Oceanian countries excluded in this INNER JOIN,
we want to return the names of these countries.
Let's write an anti join to this!
*/

SELECT 
    code, name
FROM
    countries
WHERE
    (continent = 'Oceania')
        AND code NOT IN (SELECT 
            code
        FROM
            currencies);
            
-- Suppose we want records from 2015 with 'life_expectancy' above '1.15 * avg_life_expectancy'.
-- We could use the following SQL query.

SELECT 
    *
FROM
    populations
WHERE
    life_expectancy > 1.15 * avg_life_expectancy
        AND year = 2015;

-- But we need to write a query to calculate a value for avg_life_expectancy.
-- So, let's write a query to calculate a value for avg_life_expectancy.
-- Then, nest the avg_life_expectancy into another query.

SELECT 
    *
FROM
    populations
WHERE
    life_expectancy > 1.15 * (
    SELECT 
            AVG(life_expectancy)
        FROM
            populations
        WHERE
            year = 2015
            )
	AND year = 2015;        


-- Select relevant fields from cities table
-- Filter using a subquery on the countries table
SELECT 
    name, country_code, urbanarea_pop
FROM
    cities
WHERE
    name IN (SELECT 
            capital
        FROM
            countries)
ORDER BY urbanarea_pop DESC;
-- This gives us the urban area population for capital cities only
-- --------------------------------------------------------------------------------
# We can also use subqueries in the SELECT statement
-- Let's say we want to look at the salaries and compare them to the average salary

SELECT first_name, salary, AVG(salary)
FROM employee_salary;

-- if we run the query above, it's not going to work. Why?
-- We are using columns with an aggregate function so we need to use 'GROUP BY'
-- if we do that anyway, we won't exactly get what we want!!!

SELECT first_name, salary, AVG(salary)
FROM employee_salary
GROUP BY first_name, salary;

-- it gave us the average PER GROUP which we don't want
-- here's a good use for a subquery

SELECT first_name,
salary,
(SELECT AVG(salary)
        FROM employee_salary) AS avg_sal
FROM employee_salary;


# Consider the following Join.

-- Find top nine countries with the most cities
SELECT countries.name AS country, count(*) AS cities_num
FROM countries
LEFT JOIN cities
ON countries.code = cities.country_code
-- Order by count of cities as cities_num
GROUP BY country
ORDER BY cities_num DESC, country ASC
LIMIT 9;

-- We can achieve similar result using a subquery in the select statement

SELECT countries.name AS country,
-- Subquery that provides the count of cities   
  (SELECT count(*)
   FROM cities
   -- link cities to countries table using code
   WHERE cities.country_code = countries.code) AS cities_num
FROM countries
ORDER BY cities_num DESC, country
LIMIT 9;
-- --------------------------------------------------------------------

-- Again, let's practice using subqueries in the FROM Statement
-- when we use it here it's almost like we are creating a small table we are querying off of
SELECT *
FROM (SELECT gender, MIN(age), MAX(age), COUNT(age),AVG(age)
FROM employee_demographics
GROUP BY gender) as tabletop
;
#Ex 2
SELECT gender, AVG(Min_age)
FROM (SELECT gender, MIN(age) Min_age, MAX(age) Max_age, COUNT(age) Count_age ,AVG(age) Avg_age
FROM employee_demographics
GROUP BY gender) AS Agg_Table
GROUP BY gender
;

/*
Say we are interested in determining the number of languages spoken for each country.
Also, we want to present this information alongside each country's local_name, \
which is a field only present in the countries table and not in the languages table.
Here, we'll use a subquery inside FROM to bring information from these two tables together!
*/

-- First, a query that groups by each country code from languages, and counts the languages spoken in each country as lang_num.
SELECT 
    code, COUNT(*) AS lang_num
FROM
    languages
GROUP BY code;

-- Now, let's create the subquery using the query above
-- Select local_name and lang_num from appropriate tables
SELECT local_name, lang_num
FROM countries,
  (SELECT code, COUNT(*) AS lang_num
  FROM languages
  GROUP BY code) AS sub
-- Where codes match
WHERE countries.code = sub.code
ORDER BY lang_num DESC;
-- Notice that we can select from two tables at the same time
-- Thus, our second table is the subquery aliased as sub
-- lang_num is a selection from the 2nd table, sub

/*
Suppose we're interested in analyzing inflation and unemployment rate for certain countries in 2015.
We are not interested in countries with "Republic" or "Monarchy" as their form of government, but are interested in all other forms of government, such as emirate federations, socialist states, and commonwealths.

We'll use the field `gov_form` to filter for these two conditions, which represents a country's form of government.
*/
-- Select relevant fields
SELECT code, inflation_rate, unemployment_rate
FROM economies
WHERE year = 2015 
  AND code NOT IN
-- Subquery returning country codes filtered on gov_form
	(SELECT code
  FROM countries
  WHERE gov_form LIKE '%Republic%' OR gov_form LIKE '%Monarchy%')
ORDER BY inflation_rate;

/*
Our final task is to determine the top 10 capital cities in Europe and the Americas by city_perc, a metric we'll calculate.
city_perc is a percentage that calculates the "proper" population in a city as a percentage of the total population in the wider metro area, as follows:
city_proper_pop / metroarea_pop * 100
*/
-- Select fields from cities
SELECT name, country_code, city_proper_pop, metroarea_pop, city_proper_pop / metroarea_pop * 100 AS city_perc
FROM cities
-- Use subquery to filter city name for capital cities
WHERE name IN (
    SELECT capital
    FROM countries
    WHERE continent = 'Europe' OR continent LIKE '%America'
)
-- Add filter condition such that metroarea_pop does not have null values
AND metroarea_pop IS NOT NULL
-- Sort by city_perc in descending order and limit the result
ORDER BY city_perc DESC
LIMIT 10;
-- We've identified the city with the highest percentage of people living in the city 'proper', relative to the wider metropolitan population!

# generate a list of matches where the total goals scored (for both teams in total) is more than 3 times the average for games in the matches_2013_2014 table, which includes all games played in the 2013/2014 season.
-- First, let's calculate triple the average home + away goals scored across all matches. This will become our subquery in the next step.
-- Note that this column does not have an alias, so it will be called ?column? in our results.
SELECT 
	3 * avg(home_goal + away_goal)
FROM matches_2013_2014;

-- Next;
SELECT 
	-- Select the date, home goals, and away goals scored
    date, home_goal, away_goal
FROM  matches_2013_2014
-- Filter for matches where total goals exceeds 3x the average
WHERE (home_goal + away_goal) > 
       (SELECT 3 * AVG(home_goal + away_goal)
        FROM matches_2013_2014); 

