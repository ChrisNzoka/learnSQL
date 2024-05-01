CREATE DATABASE Parks_and_Recreation;

CREATE TABLE employee_demographics (
    employee_id INT NOT NULL,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    age INT,
    gender VARCHAR(50),
    birth_date DATE,
    PRIMARY KEY (employee_id)
);

CREATE TABLE employee_salary (
	employee_id INT NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    occupation VARCHAR(50),
    salary INT,
    dept_id INT
);

