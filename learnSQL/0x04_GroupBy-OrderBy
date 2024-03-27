SELECT *
FROM employee_id
ORDER BY age DESC
--arranges the table in descending order of age

SELECT *
FROM employee_id
ORDER BY age, gender 
-- arranges the table in order of age and gender (the default order in SQL is ascending)

SELECT *
FROM employee_id
ORDER BY age, gender DESC
--arranges the table in descending order of gender (age takes the default ascending order)

SELECT *
FROM employee_id
ORDER BY 4 desc
--here, the column name is replaced with number (columns are numbered based on their position)
id | firstname | lastname | age | gender
id=1, firstname=2, lastname=3, ...

SELECT Gender, COUNT(gender) AS genderCount
FROM employee_id
GROUP BY gender
--groups the whole date based on gender and gives the total number of each gender as gnder count column

SELECT age, count(age) AS ageCount
FROM employee_id
GROUP BY age
--groups the data by age giving the total number of people with each age as ageCount column

