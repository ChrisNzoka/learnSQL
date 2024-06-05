-- before we create tables, we can create schemas that carry the tables as follows
CREATE SCHEMA `parks_and_recreation`;
-- notably, this is usually run at the begining of the script

-- Now, let's create our tables
CREATE TABLE employee_id
(ID int,
firstname varchar (50),
lastname varchar (50),
age int,
gender varchar (50)
);

CREATE TABLE employee_salary
(ID int,
job_title varchar (50),
salary int
)

/*
where data types include:
int for Integers (non-decimal numbers)
varchar for characters ()

N.B: row = records
     columns = fields
*/
