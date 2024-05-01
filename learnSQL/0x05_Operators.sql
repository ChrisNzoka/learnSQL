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
*/
SELECT * FROM employee_demographics
WHERE birth_date > '1985-01-01'
OR gender = 'female';