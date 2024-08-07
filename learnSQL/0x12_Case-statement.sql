-- Case Statements
-- Case statements works the same way as "WHERE" and "HAVING". However, it allows for multiple filtering
-- Also, case statements comes immediatelt after the select statement
/*
CASE statements can be used to create columns for categorizing data "IN SELECT STATEMENT",
and to filter data in the WHERE clause.
We can also use CASE statements to aggregate data based on the result of a logical test.
*/
SELECT 
    first_name,
    last_name,
    CASE
        WHEN age <= 30 THEN 'Young'
    END AS age_description	
FROM
    employee_demographics;

SELECT 
    first_name,
    last_name,
    CASE
        WHEN age <= 30 THEN 'Young'
        WHEN age BETWEEN 31 AND 50 THEN 'Old'
        WHEN age >= 50 THEN 'On Death\'s Door'
    END AS age_description
FROM
    employee_demographics;
-- Poor Jerry
-- the backward slash here: 'On Death\'s Door' helps to escape the apostrophe
-- Thus, SQL won't throw an error 


/*
Pawnee Council sent out a memo of their bonus and pay increase structure so we need to follow it
Basically, if they make less than 45k then they get a 5% raise - very generous
if they make more than 45k they get a 7% raise
then, they get a bonus of 10% if they work for the Finance Department
*/
SELECT 
    dept_id,
    first_name,
    last_name,
    salary AS current_salary,
    CASE
        WHEN salary < 45000 THEN salary * 1.05
        WHEN salary > 45000 THEN salary * 1.07
    END raise
FROM
    employee_salary;

-- Now we need to also account for Bonuses, let's make a new column
SELECT 
    dept_id,
    first_name,
    last_name,
    salary current_salary,
    CASE
        WHEN salary < 45000 THEN salary * 1.05
        WHEN salary > 45000 THEN salary * 1.07
    END Raise,
    CASE
        WHEN dept_id = 6 THEN salary * 0.1
    END Bonus
FROM
    employee_salary;
-- as you can see Ben is the only one who get's a bonus

-- Identify the home team as Bayern Munich, Schalke 04, or neither
SELECT 
    CASE
        WHEN hometeam_id = 10189 THEN 'FC Schalke 04'
        WHEN hometeam_id = 9823 THEN 'FC Bayern Munich'
        ELSE 'Other'
    END AS home_team,
    COUNT(id) AS total_matches
FROM
    matches_germany
    -- Group by the CASE statement alias
GROUP BY home_team;

/*
In this exercise, we'll be creating a list of matches in the 2011/2012 season where Barcelona was the home team.
We'll do this using a CASE statement that compares the values of two columns to create a new group -- wins, losses, and ties.

In 3 steps, we'll build a query that
	identifies a match's winner
	identifies the identity of the opponent
	finally filters for Barcelona as the home team. 
Completing a query in this order will allow us to watch our results take shape with each new piece of information.

The matches_spain table currently contain Barcelona's matches from the 2011/2012 season,
and has two key columns, hometeam_id and awayteam_id, that can be joined with the teams_spain table. 
However, we can only join teams_spain to one column at a time.
*/

-- STep 1
SELECT 
    -- Select the date of the match
	date,
	-- Identify home wins, losses, or ties
    CASE
        WHEN home_goal > away_goal THEN 'Home win!'
        WHEN home_goal < away_goal THEN 'Home loss :('
        ELSE 'Tie'
    END AS outcome
FROM
    matches_spain;
    
-- Now, step 2    
SELECT 
	m.date,
	-- Select the team long name column and call it 'opponent'
	t.team_long_name AS opponent, 
	-- Complete the CASE statement with an alias
	CASE
		WHEN m.home_goal > m.away_goal THEN 'Home win!'
        WHEN m.home_goal < m.away_goal THEN 'Home loss :('
        ELSE 'Tie' 
	END AS outcome
FROM matches_spain AS m
-- Left join teams_spain onto matches_spain
LEFT JOIN teams_spain AS t
ON m.awayteam_id = t.team_api_id;

-- Final step
SELECT 
	m.date,
	t.team_long_name AS opponent, 
	-- Complete the CASE statement with an alias
	CASE
		WHEN m.home_goal > m.away_goal THEN 'Barcelona win!'
        WHEN m.home_goal < m.away_goal THEN 'Barcelona loss :('
        ELSE 'Tie' 
	END AS outcome
FROM matches_spain AS m
-- Left join teams_spain onto matches_spain
LEFT JOIN teams_spain AS t
ON m.awayteam_id = t.team_api_id
-- Filter for Barcelona as the home team
WHERE m.hometeam_id = 8634;

/*
Similar to the previous exercise, you will construct a query to determine the outcome of
Barcelona's matches where they played as the away team. You will learn how to combine these two
queries in chapters 2 and 3.
*/
-- Select matches where Barcelona was the away team
SELECT  
	m.date,
	t.team_long_name AS opponent,
	CASE
		WHEN m.home_goal < m.away_goal THEN 'Barcelona win!'
        WHEN m.home_goal > m.away_goal THEN 'Barcelona loss :('
        ELSE 'Tie' 
	END AS outcome
FROM matches_spain AS m
-- Join teams_spain to matches_spain
LEFT JOIN teams_spain AS t 
ON m.hometeam_id = t.team_api_id
WHERE m.awayteam_id = 8634;

/*
In CASE of rivalry.

Barcelona and Real Madrid have been rival teams for more than 80 years.
Matches between these two teams are given the name El Clásico (The Classic).
In this exercise, we'll query a list of matches played between these two rivals.

We will notice in Step 2 that when we have multiple logical conditions in a CASE statement,
we may quickly end up with a large number of WHEN clauses to logically test every outcome we are interested in.
It's important to make sure we don't accidentally exclude key information in our ELSE clause.

In this exercise, we'll retrieve information about matches played between Barcelona (id = 8634) and Real Madrid (id = 8633).
Note that the query you are provided with already identifies the Clásico matches using a filter in the WHERE clause.
*/

-- Step 1
SELECT 
	date,
	-- Identify the home team as Barcelona or Real Madrid
	CASE
        WHEN hometeam_id = 8634 THEN 'FC Barcelona' 
        ELSE 'Real Madrid CF'
        END AS home,
    -- Identify the away team as Barcelona or Real Madrid
	CASE
        WHEN awayteam_id = 8634 THEN 'FC Barcelona' 
        ELSE 'Real Madrid CF'
        END AS away
FROM matches_spain
WHERE (awayteam_id = 8634 OR hometeam_id = 8634)
      AND (awayteam_id = 8633 OR hometeam_id = 8633);

-- Step 2: 	-- Identify all possible match outcomes
SELECT 
	date,
	CASE WHEN hometeam_id = 8634 THEN 'FC Barcelona' 
         ELSE 'Real Madrid CF' END AS home,
	CASE WHEN awayteam_id = 8634 THEN 'FC Barcelona' 
         ELSE 'Real Madrid CF' END AS away,
	-- Identify all possible match outcomes
	CASE WHEN home_goal > away_goal AND hometeam_id = 8634 THEN 'Barcelona win!'
        WHEN home_goal < away_goal AND hometeam_id = 8633 THEN 'Real Madrid win!'
        WHEN home_goal < away_goal AND awayteam_id = 8634 THEN 'Barcelona win!'
        WHEN home_goal > away_goal AND awayteam_id = 8633 THEN 'Real Madrid win!'
        ELSE 'Tie!' END AS outcome
FROM matches_spain
WHERE (awayteam_id = 8634 OR hometeam_id = 8634)
      AND (awayteam_id = 8633 OR hometeam_id = 8633);
      
/*
Filtering your CASE statement

Let's generate a list of matches won by Italy's Bologna team!
There are quite a few additional teams in the two tables,
so a key part of generating a usable query will be using the CASE statement as a filter in the WHERE clause.

CASE statements allow us to categorize data that we're interested in;
and exclude data we're not interested in.
In order to do this, we can use a CASE statement as a filter in the WHERE statement to remove output we don't want to see.

Here is how we might set that up:
*/
SELECT 
    *
FROM
    our_table
WHERE
    CASE
        WHEN a > 5 THEN 'Keep'
        WHEN a <= 5 THEN 'Exclude'
    END = 'Keep';

-- In essence, we can use the CASE statement as a filtering column like any other column in our database.
-- The only difference is that you don't alias the statement in WHERE.

-- Example; let's identify Bologna's team ID listed in the teams_italy table by selecting the team_long_name and team_api_id:
-- Select team_long_name and team_api_id from team
SELECT
	team_long_name,
	team_api_id
FROM teams_italy
-- Filter for team long name
WHERE team_long_name = 'Bologna';

-- Now, let's Identify when Bologna won a match

-- Select the season and date columns
SELECT 
    season,
    date,
-- Identify when Bologna won a match
    CASE
        WHEN
            hometeam_id = 9857
                AND home_goal > away_goal
        THEN
            'Bologna Win'
        WHEN
            awayteam_id = 9857
                AND away_goal > home_goal
        THEN
            'Bologna Win'
    END AS outcome
FROM
    matches_italy;

-- Select the season, date, home_goal, and away_goal columns
SELECT 
	season,
    date,
	home_goal,
	away_goal
FROM matches_italy
WHERE 
-- Exclude games not won by Bologna
	CASE WHEN hometeam_id = 9857 AND home_goal > away_goal THEN 'Bologna Win'
		WHEN awayteam_id = 9857 AND away_goal < home_goal THEN 'Bologna Win' 
		END IS NOT NULL;
        
/*
Do the number of soccer matches played in a given European country differ across seasons? We will use the European Soccer Database to answer this question.

Let's examine the number of matches played in 3 seasons within each country listed in the database. This is much easier to explore with each season's matches in separate columns. Using the country and unfiltered match table, you will count the number of matches played in each country during the 2012/2013, 2013/2014, and 2014/2015 match seasons.
*/
SELECT 
	c.name AS country,
    -- Count games from the 2012/2013 season
	COUNT(CASE WHEN m.season = '2012/2013' 
        THEN m.id ELSE NULL END) AS matches_2012_2013
FROM country AS c
LEFT JOIN match AS m
ON c.id = m.country_id
-- Group by country name alias
GROUP BY country;

SELECT 
	c.name AS country,
    -- Count matches in each of the 3 seasons
	Count(CASE WHEN m.season = '2012/2013' THEN m.id END) AS matches_2012_2013,
	Count(CASE WHEN m.season = '2013/2014' THEN m.id END) AS matches_2013_2014,
	Count(CASE WHEN m.season = '2014/2015' THEN m.id END) AS matches_2014_2015
FROM country AS c
LEFT JOIN match AS m
ON c.id = m.country_id
-- Group by country name alias
GROUP BY country;


/*
Calculating percent with CASE and AVG
CASE statements will return any value you specify in your THEN clause. This is an incredibly powerful tool for robust calculations and data manipulation when used in conjunction with an aggregate statement. One key task you can perform is using CASE inside an AVG function to calculate a percentage of information in your database.

Here's an example of how you set that up:
*/
AVG(CASE WHEN condition_is_met THEN 1
         WHEN condition_is_not_met THEN 0 END)
/*
With this approach, it's important to accurately specify which records count as 0, otherwise your calculations may not be correct!

Your task is to examine the number of wins, losses, and ties in each country. The matches table is filtered to include all matches from the 2013/2014 and 2014/2015 seasons.
*/
SELECT 
    c.name AS country,
    -- Count the home wins, away wins, and ties in each country
	COUNT(case when m.home_goal > m.away_goal THEN m.id 
        END) AS home_wins,
	COUNT(case when m.home_goal < m.away_goal THEN m.id 
        END) AS away_wins,
	COUNT(case when m.home_goal = m.away_goal THEN m.id 
        END) AS ties
FROM country AS c
LEFT JOIN matches AS m
ON c.id = m.country_id
GROUP BY country;

-- next
-- Calculate the percentage of matches tied using a CASE statement inside AVG.
-- Fill in the logical operators for each statement.
-- Alias your columns as ties_2013_2014 and ties_2014_2015, respectively.
SELECT 
	c.name AS country,
    -- Calculate the percentage of tied games in each season
	AVG(CASE WHEN m.season='2013/2014' AND m.home_goal = m.away_goal THEN 1
			WHEN m.season='2013/2014' AND m.home_goal <> m.away_goal THEN 0
			END) AS ties_2013_2014,
	AVG(CASE WHEN m.season='2014/2015' AND m.home_goal = m.away_goal THEN 1
			WHEN m.season='2014/2015' AND m.home_goal != m.away_goal THEN 0
			END) AS ties_2014_2015
FROM country AS c
LEFT JOIN matches AS m
ON c.id = m.country_id
GROUP BY country;

-- Notice that the previous "ties" columns returned values with 14 decimal points, which is not easy to interpret. 
-- Use the ROUND function to round to 2 decimal points.
SELECT 
	c.name AS country,
    -- Round the percentage of tied games to 2 decimal points
	ROUND(AVG(CASE WHEN m.season='2013/2014' AND m.home_goal = m.away_goal THEN 1
			 WHEN m.season='2013/2014' AND m.home_goal != m.away_goal THEN 0
			 END),2) AS pct_ties_2013_2014,
	ROUND(AVG(CASE WHEN m.season='2014/2015' AND m.home_goal = m.away_goal THEN 1
			 WHEN m.season='2014/2015' AND m.home_goal != m.away_goal THEN 0
			 END),2) AS pct_ties_2014_2015
FROM country AS c
LEFT JOIN matches AS m
ON c.id = m.country_id
GROUP BY country;

