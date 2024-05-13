-- View

-- A view is a virtual table created from saved SQL SELECT statement
-- When accessed, views automtically run the saved select statement and populates the underlying data from the database
CREATE VIEW employee_retirement AS
    SELECT 
        dem.first_name, dem.last_name, age, salary
    FROM
        employee_demographics dem
            JOIN
        employee_salary sal ON dem.employee_id = sal.employee_id;
        
-- Once created, we can query the view like a normal table        
Select * from employee_retirement;