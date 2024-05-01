SELECT * FROM employee_id
WHERE firstname = 'Chris'
--selcts only rows with 'Chris' as first name

SELECT * FROM station_data
WHERE year = 2010;
--selects only records with year = 2010

SELECT * FROM employee_id
WHERE age <> 26
--selcts only rows where age is not equal to 26

SELECT * FROM employee_id
WHERE age > 26
-- selects rows with age greater than 26 (i.e 27 and above)

SELECT * FROM employee_id
WHERE age >= 30
--here, age 30 is inclusive

SELECT * FROM employee_id
WHERE age < 30 OR gender = 'male'
--return data for all age less than 30 as well as all male genders irrespective of the age

SELECT * FROM employee_id
WHERE id > 20240304 AND age >= 30
--this wil return data for all employees from 30 and above with employee ID greater than the specified

SELECT * FROM employee_id
WHERE lastname LIKE 'M%'
-- wildcard M% returns data for all lastnames starting with M

SELECT * FROM employee_id
WHERE lastname LIKE '%M%'
--returns data for all lastnames with M in it(start, middle or end)

SELECT * FROM employee_id
WHERE lastname LIKE '%e'
--returns lastnames ending with e

SELECT * FROM employee_id
WHERE lastname LIKE 'M%e' 
--returns lastname starting with M and ending with e

SELECT * FROM employee_id
WHERE lastname LIKE 'M%e%'
--returns data for lastnames starting with M and has e anywhere

SELECT * FROM employee_id
WHERE lastname IS NOT NULL
--returns all lastnames that has data in their cells

SELECT * FROM employee_id
WHERE lastname IS NULL
--returns empty lastnames

SELECT * FROM employee_id
WHERE lastname IN ('Nzoka-okoye', 'Scott')
--returns data for only the specified lastnames(alternative to using = multiple times)