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

SELECT 
    *
FROM
    employee_id
ORDER BY gender, age DESC;
-- arranges the table in Ascending order of gender and descending order of age

SELECT 
    *
FROM
    employee_id
ORDER BY  age, gender DESC;
-- arranges the table in Ascending order of age and descending order of gender
-- (however, the age querry takes prescedence here making the gender useless)

SELECT 
    *
FROM
    employee_demographics
ORDER BY gender DESC , age DESC;

SELECT 
    *
FROM
    employee_id
ORDER BY 4 DESC;
-- here, the column name is replaced with number (columns are numbered based on their position)
-- id | firstname | lastname | age | gender
-- id=1, firstname=2, lastname=3, ...

-- GROUP BY -- 
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
