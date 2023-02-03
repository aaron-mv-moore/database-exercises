-- CASE Exercises --
USE employees;

-- 1. Write a query that returns all employees, their department number, their start date, their end date, and a new column 'is_current_employee' that is a 1 if the employee is still with the company and 0 if not.
DESC employees;
DESC dept_emp;

SELECT 
	CONCAT(last_name, ', ', first_name) AS emp_name,
	dept_no, from_date, to_date,
	IF(to_date > now(), TRUE, FALSE) AS is_current_employee
FROM dept_emp
	JOIN employees
		USING (emp_no);



-- 2. Write a query that returns all employee names (previous and current), and a new column 'alpha_group' that returns 'A-H', 'I-Q', or 'R-Z' depending on the first letter of their last name.

SELECT 
	CONCAT(last_name, ', ', first_name) AS emp_name,
	CASE
		WHEN last_name LIKE 'A%' THEN 'A-H'
		WHEN last_name LIKE 'B%' THEN 'A-H'
		WHEN last_name LIKE 'C%' THEN 'A-H'
		WHEN last_name LIKE 'D%' THEN 'A-H'
		WHEN last_name LIKE 'E%' THEN 'A-H'
		WHEN last_name LIKE 'F%' THEN 'A-H'
		WHEN last_name LIKE 'G%' THEN 'A-H'
		WHEN last_name LIKE 'H%' THEN 'A-H'
		WHEN last_name LIKE 'I%' THEN 'I-Q'
		WHEN last_name LIKE 'J%' THEN 'I-Q'
		WHEN last_name LIKE 'K%' THEN 'I-Q'
		WHEN last_name LIKE 'L%' THEN 'I-Q'
		WHEN last_name LIKE 'M%' THEN 'I-Q'
		WHEN last_name LIKE 'N%' THEN 'I-Q'
		WHEN last_name LIKE 'O%' THEN 'I-Q'
		WHEN last_name LIKE 'P%' THEN 'I-Q'
		WHEN last_name LIKE 'Q%' THEN 'I-Q'
		ELSE'R-Z'
	END AS alpha_group
FROM employees;

-- Other option
SELECT 
	CONCAT(last_name, ', ', first_name) AS emp_name,
	CASE
		WHEN LEFT(last_name, 1) <= 'H' THEN 'A-H'
		WHEN SUBSTR(last_name, 1, 1) <= 'Q' THEN 'I-Q'
		WHEN SUBSTR(last_name, 1, 1) <= 'Z' THEN 'R-Z'
	END AS alpha_group
FROM employees;


-- 3. How many employees (current or previous) were born in each decade?
DESC employees;

SELECT min(birth_date), max(birth_date)
FROM employees; -- Using this query to understand which decades need to be included in the next query

SELECT 
	CASE 
		WHEN YEAR(birth_date) LIKE '__6_' THEN '1960'
		WHEN YEAR(birth_date) LIKE '__5_' THEN '1950' 
	END AS birth_decade,
	COUNT(*)
FROM employees
GROUP BY birth_decade;

-- Beautfiul and succint!!!!!
SELECT 
	CONCAT(SUBSTR(birth_date, 1, 3), '0') as decade,
	COUNT(*)
FROM employees
GROUP BY decade;

-- 4. What is the current average salary for each of the following department groups: R&D, Sales & Marketing, Prod & QM, Finance & HR, Customer Service?

-- current salaries
SELECT 
	emp_no, 
	salary 
FROM salaries
WHERE to_date > now();

-- each department
SELECT dept_name
FROM departments;

-- combine the two and get average salary for each departments
SELECT 
	dept_name, 
	avg(salary)
FROM departments
	JOIN dept_emp AS de
		USING (dept_no)
	JOIN salaries AS s
		USING (emp_no)
WHERE s.to_date > now()
	AND de.to_date > now()
GROUP BY dept_name;

-- Creating a new column with consolidated names of departments

SELECT 
	CASE 
		WHEN dept_name IN ('research', 'development') THEN 'R&D'
		WHEN dept_name IN ('sales', 'marketing') THEN 'Sales & Marketing'
		WHEN dept_name IN ('production', 'quality management') THEN 'Prod & QM'
		WHEN dept_name IN ('finance', 'human resources') THEN 'Finance & HR'
		ELSE 'Customer Service'
	END AS dept_groups,
	COUNT(*)
FROM departments
GROUP BY dept_groups;


-- Putting it all together
SELECT 
	CASE 
		WHEN dept_name IN ('research', 'development') THEN 'R&D'
		WHEN dept_name IN ('sales', 'marketing') THEN 'Sales & Marketing'
		WHEN dept_name IN ('production', 'quality management') THEN 'Prod & QM'
		WHEN dept_name IN ('finance', 'human resources') THEN 'Finance & HR'
		ELSE 'Customer Service'
	END AS dept_group,
	AVG(salary) as avg_sal
FROM departments
	JOIN dept_emp AS de
		USING (dept_no)
	JOIN salaries AS s
		USING (emp_no)
WHERE s.to_date > now()
	AND de.to_date > now()
GROUP BY dept_group;
