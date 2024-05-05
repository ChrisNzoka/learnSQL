SELECT 
    first_name, last_name
FROM
    employee_demographics 
UNION SELECT 
    occupation, salary
FROM
    employee_salary;

SELECT 
    first_name, last_name
FROM
    employee_demographics 
UNION SELECT 
    first_name, last_name
FROM
    employee_salary;

-- notice it gets rid of duplicates? Union is actually shorthand for Union Distinct

SELECT 
    first_name, last_name
FROM
    employee_demographics 
UNION DISTINCT SELECT 
    first_name, last_name
FROM
    employee_salary;

-- we can use UNION ALL to show all values

SELECT 
    first_name, last_name
FROM
    employee_demographics 
UNION ALL SELECT 
    first_name, last_name
FROM
    employee_salary;



SELECT 
    first_name, last_name, 'Old Lady' Label
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
