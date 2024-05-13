SELECT 
    *
FROM
    employee_id
WHERE
    firstname = 'Chris';
-- selcts only rows with 'Chris' as first name

SELECT 
    *
FROM
    station_data
WHERE
    year = 2010;
-- selects only records with year = 2010

SELECT 
    *
FROM
    employee_id
WHERE
    age <> 26;
-- selcts only rows where age is not equal to 26

SELECT 
    *
FROM
    employee_id
WHERE
    age > 26;
-- selects rows with age greater than 26 (i.e 27 and above)

SELECT 
    *
FROM
    employee_id
WHERE
    age >= 30;
-- here, age 30 is inclusive

SELECT 
    *
FROM
    employee_id
WHERE
    age < 30 OR gender = 'male';
-- return data for all age less than 30 as well as all male genders irrespective of the age

SELECT 
    *
FROM
    employee_id
WHERE
    id > 20240304 AND age >= 30;
-- this wil return data for all employees from 30 and above with employee ID greater than the specified

SELECT 
    *
FROM
    employee_id
WHERE
    lastname LIKE 'M%';
-- wildcard M% returns data for all lastnames starting with M

SELECT 
    *
FROM
    employee_id
WHERE
    lastname LIKE '%M%';
-- returns data for all lastnames with M in it(start, middle or end)

SELECT 
    *
FROM
    employee_id
WHERE
    lastname LIKE '%e';
-- returns lastnames ending with e

SELECT 
    *
FROM
    employee_id
WHERE
    lastname NOT LIKE 'M%e';
-- returns lastname that does not start with M and not ending with e

SELECT 
    *
FROM
    employee_id
WHERE
    lastname LIKE 'M%e%';
-- returns data for lastnames starting with M and has e anywhere

SELECT 
*
FROM
 employe_id
 WHERE first_name LIKE 'T_';
 -- here, the underscore character specifies that only one character will come after the letter T
 
 SELECT 
*
FROM
 employe_id
 WHERE first_name LIKE 'R___';
 -- here, the 3 underscore characters specifies that only 3 characters should come after the letter R e.g Rose
 
 SELECT 
*
FROM
 employe_id
 WHERE first_name LIKE 'T___%';
 -- here, the 3 underscore character specifies that three characters should come after the letter T, then (with the %) any other thing can follow

-- The percent wildcard will match zero, one, or many characters in the text.
-- The underscore wildcard will match a single character. 

SELECT 
    *
FROM
    employee_id
WHERE
    lastname IS NOT NULL;
-- returns all lastnames that has data in their cells

SELECT 
    *
FROM
    employee_id
WHERE
    lastname IS NULL;
-- returns empty lastnames

SELECT 
    *
FROM
    employee_id
WHERE
    lastname IN ('Nzoka-okoye' , 'Scott');
-- returns data for only the specified lastnames(alternative to using = multiple times)

-- the IN keyword
SELECT 
    title
FROM
    films
WHERE
    release_year = 1904
        OR release_year = 1925
        OR release_year = 1934;

-- we can rewrite the query abouve usin IN
SELECT 
    title
FROM
    films
WHERE
    release_year IN (1904, 1925, 1934);
    
-- Count the unique titles
SELECT 
    COUNT(DISTINCT title) AS nineties_english_films_for_teens
FROM
    films
WHERE
    (release_year BETWEEN 1990 AND 1999)
        AND (language = 'English')
        AND certification IN ('G' , 'PG', 'PG-13');

-- NULL
SELECT 
    COUNT(*) AS no_deathdates
FROM
    people
WHERE
    deathdate IS NULL;


SELECT 
    COUNT(*) AS no_birthdates
FROM
    people
WHERE
    birthday IS NOT NULL;