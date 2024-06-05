-- Case Statements

SELECT 
    *
FROM
    employee_demographics;

-- Case statements works the same way as "WHERE" and "HAVING". However, it allows for multiple filtering
-- Also, case statements comes immediatelt after the select statement
SELECT 
    first_name,
    last_name,
    CASE
        WHEN age <= 30 THEN 'Young'
    END
FROM
    employee_demographics;

SELECT 
    first_name,
    last_name,
    CASE
        WHEN age <= 30 THEN 'Young'
        WHEN age BETWEEN 31 AND 50 THEN 'Old'
        WHEN age >= 50 THEN 'On Death\'s Door'
    END age_description
FROM
    employee_demographics;

-- Poor Jerry

SELECT 
    *
FROM
    employee_salary;

-- Pawnee Council sent out a memo of their bonus and pay increase structure so we need to follow it
-- Basically if they make less than 45k then they get a 5% raise - very generous
-- if they make more than 45k they get a 7% raise
-- they get a bonus of 10% if they work for the Finance Department

SELECT 
    dept_id,
    first_name,
    last_name,
    salary current_salary,
    CASE
        WHEN salary < 50000 THEN salary * 1.05
        WHEN salary > 55000 THEN salary * 1.07
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
