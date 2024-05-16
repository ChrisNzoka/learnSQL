-- Aliasing
-- Order of execution
/*
Step 1: FROM (aliases are defined here for JOIN)
Step 2: WHERE
Step 3: SELECT (aliases are defined here)
Step 4: LIMIT
*/
-- Aliases defined in the SELECT clause cannot be used in the WHERE clause
-- due to the order of execution

-- For example, the following statement will throw an error
SELECT 
    budget AS max_budget
FROM
    films
WHERE
    max_budget IS NOT NULL;
# error: column "max_budget" does not exist
# LINE %: WHERE max_budget IS NOT NUL;

-- 