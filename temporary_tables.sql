-- Temporary Tables --
USE employees;
-- Using the example from the lesson, create a temporary table called employees_with_departments that contains first_name, last_name, and dept_name for employees currently with that department. 

CREATE TEMPORARY TABLE oneil_2092.employees AS
	SELECT 
		first_name, 
		last_name, 
		dept_name
	FROM employees
		JOIN dept_emp
			USING (emp_no)
		JOIN departments
			USING (dept_no)
	WHERE dept_emp.to_date > now();
-- a. Add a column named full_name to this table. It should be a VARCHAR whose length is the sum of the lengths of the first name and last name columns.
USE oneil_2092;
DESC oneil_2092.employees;
SELECT MAX(LENGTH(CONCAT(first_name, ' ', last_name))) FROM employees; -- EDIT: had 
ALTER TABLE oneil_2092.employees ADD full_name VARCHAR(30);

-- b. Update the table so that full name column contains the correct data.
UPDATE employees
SET full_name = CONCAT(first_name, ' ', last_name);

-- .c Remove the first_name and last_name columns from the table.
ALTER TABLE employees DROP COLUMN first_name;
ALTER TABLE employees DROP COLUMN last_name;
		-- Another way:
ALTER TABLE employees
	DROP COLUMN first_name,
	DROP COLUMN last_name;

-- d. What is another way you could have ended up with this same table?
USE employees;
CREATE TEMPORARY TABLE oneil_2092.employees_other AS
SELECT 
	CONCAT(first_name, ' ', last_name) AS full_name,
	dept_name
FROM employees
	JOIN dept_emp
		USING (emp_no)
	JOIN departments
		USING (dept_no)
WHERE dept_emp.to_date > now();

USE oneil_2092;
SELECT *
FROM employees_other;

-- 2. Create a temporary table based on the payment table from the sakila database.
USE sakila;
CREATE TEMPORARY TABLE oneil_2092.payment AS
SELECT *
FROM payment;

-- Write the SQL necessary to transform the amount column such that it is stored as an integer representing the number of cents of the payment. For example, 1.99 should become 199.
USE oneil_2092;
DESC payment;

ALTER TABLE payment 
	MODIFY amount DECIMAL(10,2);
DESC payment;

UPDATE payment
	SET amount = amount * 100;
ALTER TABLE payment 
	MODIFY amount INT(10);
DESC payment;

SELECT 
	amount
FROM payment;

-- 3. Find out how the current average pay in each department compares to the overall current pay for everyone at the company. For this comparison, you will calculate the z-score for each salary. In terms of salary, what is the best department right now to work for? The worst?

-- The best department is sales and the worst seems to be human resources

-- Create temp table with usable info
USE employees;
CREATE TEMPORARY TABLE oneil_2092.employees AS
SELECT 
	dept_name,
	AVG(salary) AS davg,  --  THIS IS THE AVERAGE SALARY FOR EACH INDIVIDUAL DEPARTMENT, OUR X
	(
		SELECT 		-- THIS SALARY AVERAGE IS FOR ALL CURRENT SALARIES IN THE COMPANY
		AVG(salary)
		FROM salaries
		WHERE to_date > now()
	) AS cavg, 
	(
		SELECT 		-- THIS STDDEV IS FROM THE SAMPLE, THE ENTIRE COMPANY
		STDDEV(salary)
		FROM salaries
		WHERE to_date > now()
	) AS cstddev
FROM departments
	JOIN dept_emp de
		USING (dept_no)
	JOIN salaries s
		USING (emp_no)
WHERE s.to_date > now()
	AND de.to_date > now()
GROUP BY dept_name; 

USE oneil_2092;
SELECT * 
FROM employees;

ALTER TABLE employees ADD z_score DECIMAL(4,4); -- Z-SCORE TABLES USUALLY ONLY GO 4 DECIMAL POINTS

UPDATE employees
SET z_score = (davg - cavg) / cstddev ; -- USING THE INFORMATION IN THE TEMPORARY TABLE SO THE WORK IS DONE FOR ME 

SELECT * 
FROM employees;
		

-- current average pay per department = X
USE employees;
SELECT 
	dept_name,
	AVG(salary)
FROM departments
	JOIN dept_emp de
		USING (dept_no)
	JOIN salaries s
		USING (emp_no)
WHERE s.to_date > now()
	AND de.to_date > now()
GROUP BY dept_name;

-- Current average of the company = 
SELECT 
	AVG(salary)
FROM salaries
WHERE to_date > now();

-- Standard deviation of enitre company
SELECT 
	STDDEV(salary)
FROM salaries
WHERE to_date > now();
	
-- CURRENT Z-SCORE FOR EACH DEPARTMENT FROM ORIGINAL DATABASE
USE employees;
SELECT 
	dept_name,
		(
			AVG(salary) 
				- 
			(
			SELECT 
				AVG(salary)
			FROM salaries
			WHERE to_date > now()
			)
		)	
			/
		(
		SELECT 
		STDDEV(salary)
		FROM salaries
		WHERE to_date > now()
		) 
	AS z_scores
FROM departments
	JOIN dept_emp de
		USING (dept_no)
	JOIN salaries s
		USING (emp_no)
WHERE s.to_date > now()
	AND de.to_date > now()
GROUP BY dept_name;
