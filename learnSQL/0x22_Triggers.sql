-- Triggers

SELECT 
    *
FROM
    employee_salary;

SELECT 
    *
FROM
    employee_demographics;

-- when we get a new row or data inserted into the salary table we want a trigger to update the employee demographics
-- so let's write this out
USE parks_and_recreation;
DELIMITER $$

CREATE TRIGGER employee_insert2
    -- we can also do BEFORE (when data is deleted from the employee_salary table), but for this case we have to do after
	AFTER INSERT ON employee_salary
    FOR EACH ROW
	-- now this means this trigger gets activated for each row that is inserted. Some sql databses like Microsoft SQLserver have batch triggers or
    -- table level triggers that only trigger once, but MySQL doesn't have this functionality yet
    -- now we can write our block of code that we want to run when this is triggered
BEGIN
-- we want to update our client invoices table
-- NEW says only from the new rows that were inserted. There is also OLD which is rows that were deleted or updated, but for this lesson, we want NEW
    INSERT INTO employee_demographics (employee_id, first_name, last_name) VALUES (NEW.employee_id,NEW.first_name,NEW.last_name);
END $$

DELIMITER ; 

-- Now let's run it and create it

-- Now that it's created let's test it out.
-- Let's insert a record into the salary table and see if it updates in the demographics table.

-- so let's put the values that we want to insert
INSERT INTO employee_salary (employee_id, first_name, last_name, occupation, salary, dept_id)
VALUES(13, 'Jean-Ralphio', 'Saperstein', 'Entertainment 720 CEO', 1000000, NULL);
-- now it was updated in the salary table and the trigger was triggered and update the corresponding values in the demographics table