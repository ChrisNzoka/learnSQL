-- Having vs Where

SELECT 
    gender, AVG(age)
FROM
    employee_demographics
GROUP BY gender
;

-- let's try to filter on the avg age using where
SELECT 
    gender, AVG(age)
FROM
    employee_demographics
WHERE
    AVG(age) > 40
GROUP BY gender
;
-- this doesn't work because of order of operations.
-- On the backend Where comes before the group by.
-- So you can't filter on data that hasn't been aggregated yet
-- this is why Having was created

SELECT 
    gender, AVG(age)
FROM
    employee_demographics
GROUP BY gender
HAVING AVG(age) > 40
;

SELECT 
    gender, AVG(age) AS AVG_age
FROM
    employee_demographics
GROUP BY gender
HAVING AVG_age > 40
;

SELECT 
    occupation, AVG(salary) AS avg_sal
FROM
    employee_salary
WHERE
    occupation LIKE '%Director%'
GROUP BY occupation
HAVING avg_sal > 50000;
-- This works as the "Where" targets the occupation column
-- while the "Having" targets the aggregated column

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
*/

/*
4. HAVING vs WHERE
WHERE filters individual records while HAVING filters grouped records. We'll walk through two business questions here to show how to translate them into the correct filter. The first question is
"What films were released in the year 2000?".
This question does not indicate any sort of grouping. It asks to see only the titles from a specific year and can therefore be written as
*/
SELECT 
    title
FROM
    films
WHERE
    release_year = 2000;
/* The second question is, 
"In what years was the average film duration over two hours?"
Straight away, we can see this question has a few more layers. Let's break down the question and query into smaller, easier-to-understand steps.
This question requires us to return information about years, so we select the release year from the films table.
Next, it asks for the average film duration, which tells us we need to place AVG(duration) somewhere.
Since we do not need to provide any additional information around the duration on its own, it is unlikely we need to perform the aggregation within the SELECT clause, so we'll try the HAVING clause instead.
The last part of the question indicates we need to filter on the duration. Since we can't filter aggregates with WHERE, this supports our theory about using HAVING!
Finally, we need to add a GROUP BY into our query since we have selected a column that has not been aggregated. Recall the aggregate function will convert the duration values into one average value. Going back to the start of our question, we're interested in knowing the average duration per year, so we group it by release year.
*/

SELECT 
    release_year
FROM
    films
GROUP BY release_year
HAVING avg(duration) > 10;

/*
HAVING and sorting
Filtering and sorting go hand in hand and gives you greater interpretability by ordering our results.

Let's see this magic at work by writing a query showing what countries have the highest average film budgets.
*/

-- Select the country and average_budget from films
SELECT 
    country, ROUND(AVG(budget), 2) average_budget
FROM
    films
GROUP BY country
-- Filter to countries with an average_budget of more than one billion
HAVING AVG(budget) > 1000000000
ORDER BY average_budget DESC;

