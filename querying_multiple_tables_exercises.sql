-- Chapter 5
USE oneil_2092;

SELECT e.fname, e.lname, e_mgr.fname mgr_fname, e_mgr.lname mgr_lname
FROM employee e INNER JOIN employee e_mgr
	ON e.superior_emp_id = e_mgr.emp_id;

-- Query the employee id, first name, last name, and start date for all employees who worked for the bank while the No Fee Checking product was being offered using a non-equi-join.

-- Query for a emplyees first name, last name, a 'vs', and the employee they will be competing against. The employees cannot compete with themselves and all employees must be tellers. Use a self-non-equi-join.

-- Query for a emplyees first name, last name, a 'vs', and the employee they will be competing against. Join emplyees only with people who have a higher employees than them. use a self-non-equi-join

-- Query for account_id, product_cd, and the fed_id for only customer type B

-- Exercises 
-- 5 - 1
SELECT e.emp_id, e.fname, e.lname, b.name
FROM employee e INNER JOIN branch b
	ON e.assigned_branch_id = b.branch_id;

-- 5 - 2 Write a query that returns the account ID for each nonbusiness customer (customer.cust_type_cd = 'I') with the customer’s federal ID (customer.fed_id) and the name of the product on which the account is based (product.name).
SELECT a.account_id, c.fed_id, p.name
FROM customer c INNER JOIN account a
	ON c.cust_id = a.cust_id
INNER JOIN product p
	ON  a.product_cd = p.product_cd
WHERE cust_type_cd = 'I';

SELECT * 
FROM account;

SELECT *
FROM product;

-- 5 - 3 Construct a query that finds all employees whose supervisor is assigned to a different department. Retrieve the employees’ ID, first name, and last name.
SELECT e.emp_id, e.fname, e.lname
FROM employee e INNER JOIN employee e_mgr
	ON e.superior_emp_id = e_mgr.emp_id
WHERE e.dept_id != e_mgr.dept_id;



