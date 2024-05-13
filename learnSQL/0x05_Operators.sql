/* Mathematical operators you can use in SQL
Operator | Description | Example
+ | Adds two numbers | STOCK + NEW_SHIPMENT
- | Subtracts two numbers | STOCK - DEFECTS
* | Multiplies two numbers | PRICE * 1.07
/ | Divides two numbers | STOCK / PALLET_SIZE
% | Divides two numbers, but returns the remainder | STOCK % PALLET_SIZE

Comparison Operators
> | Greater than
< | Less than
= | Equal to
!= | not equal to
>= | Greater than or equal to
<= | Less than or equal to

Logical Operators
AND
OR
NOT
BETWEEN
*/
SELECT 
    *
FROM
    employee_demographics
WHERE
    birth_date > '1985-01-01'
        OR gender = 'female';

SELECT 
    *
FROM
    coats
WHERE
    color = 'yellow' OR length = 'short';

SELECT 
    *
FROM
    coats
WHERE
    color = 'yellow' AND length = 'long';

SELECT 
    *
FROM
    coats
WHERE
    buttons BETWEEN 2 AND 5;

SELECT 
    *
FROM
    coats
WHERE
    (color = 'yellow' OR length = 'short')
        AND (buttons BETWEEN 2 AND 5);

SELECT 
    *
FROM
    coats
WHERE
    buttons BETWEEN 2 AND 5
        AND length = 'long'