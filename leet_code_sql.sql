-- Leet Code

-- Write an SQL query to calculate the bonus of each employee. The bonus of an employee is 100% of their salary if the ID of the employee is an odd number and the employee name does not start with the character 'M'. The bonus of an employee is 0 otherwise. Return the result table ordered by employee_id.
SELECT
  employee_id,
  (CASE WHEN (employee_id % 2 = 1 )AND (NAME NOT LIKE 'M%') THEN salary
  ELSE 0 
  END) AS bonus
FROM employees
ORDER BY employee_id;

-- Write an SQL query to swap all 'f' and 'm' values (i.e., change all 'f' values to 'm' and vice versa) with a single update statement and no intermediate temporary tables. Note that you must write a single update statement, do not write any select statement for this problem.
UPDATE salary
SET sex = CASE WHEN sex = 'f' THEN 'm' ELSE 'f' END;

-- Write an SQL query to delete all the duplicate emails, keeping only one unique email with the smallest id. Note that you are supposed to write a DELETE statement and not a SELECT one.
-- AFTER running your script, the answer shown IS the Person table. The driver will FIRST compile AND run your piece of CODE AND THEN SHOW the Person table. The final order of the Person TABLE does NOT matter.

DELETE t1 FROM person t1
INNER JOIN person t2
WHERE 
t2.id < t1.id
AND t2.email = t1.email;