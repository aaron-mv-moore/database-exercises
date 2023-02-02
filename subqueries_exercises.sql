-- Subqueries Exercises
USE employees;
SELECT * FROM employees LIMIT 10;

-- 1. Find all the current employees with the same hire date as employee 101010 using a subquery.
SELECT *
FROM employees
WHERE hire_date = 
	(SELECT `hire_date`
	FROM employees
	WHERE emp_no = 101010
);

-- 2. Find all the titles ever held by all current employees with the first name Aamod.

SELECT first_name, title
FROM (SELECT employees.emp_no, first_name
	FROM employees JOIN dept_emp
		USING (emp_no)
	WHERE first_name = 'AAMOD'
		AND to_date > now()) as aamod
JOIN titles
	USING (emp_no);
	
-- 3. How many people in the employees table are no longer working for the company? Give the answer in a comment in your code.
	-- 85108

SELECT COUNT(*)
FROM (
	SELECT DISTINCT employees.emp_no
	FROM employees
	JOIN dept_emp
		USING (emp_no)
	WHERE to_date < now()) as nh;

-- 4. Find all the current department managers that are female. List their names in a comment in your code.
	 -- Isamu, Karsten, Leon, Hilary

SELECT *
FROM (
	SELECT first_name, last_name, gender, to_date
	FROM employees JOIN dept_manager
		USING (emp_no)
		WHERE gender = 'F'
		) as fm
 WHERE to_date > now();
 
-- 5. Find all the employees who currently have a higher salary than the companies overall, historical average salary.

SELECT emp_no, first_name, last_name, salary, (SELECT avg(salary)
	FROM salaries)
FROM employees
JOIN salaries
	USING (emp_no)
WHERE salary > 
	(SELECT avg(salary)
	FROM salaries)
	AND salaries.to_date > now();
	
-- 6. How many current salaries are within 1 standard deviation of the current highest salary? 220
SELECT STDDEV(salary)
FROM salaries 
WHERE to_date > now();

SELECT count(*)
FROM salaries
WHERE salary BETWEEN (
			(SELECT max(salary) 
				FROM salaries 
				WHERE to_date > now()
				) - 
				(SELECT STDDEV(salary) 
				FROM salaries 
				WHERE to_date > now())
				) 
				AND (
				(SELECT max(salary) 
				FROM salaries 
				WHERE to_date > now()
				) + 
				(SELECT STDDEV(salary) 
				FROM salaries 
				WHERE to_date > now()
				));

--  What percentage of all salaries is this? 0.0077%
SELECT (count(*) / 
				(SELECT COUNT(*) 
					FROM salaries)
					) * 100
FROM salaries
WHERE salary BETWEEN (
			(SELECT max(salary) 
				FROM salaries 
				WHERE to_date > now()
				) - 
				(SELECT STDDEV(salary) 
				FROM salaries 
				WHERE to_date > now())
				) 
				AND (
				(SELECT max(salary) 
				FROM salaries 
				WHERE to_date > now()
				) + 
				(SELECT STDDEV(salary) 
				FROM salaries 
				WHERE to_date > now()
				));




-- BONUS --
-- 1. Find all the department names that currently have female managers.

SELECT * FROM departments;

SELECT dept_name
FROM departments
JOIN dept_manager
	USING (dept_no)
WHERE emp_no IN (SELECT emp_no
		FROM employees
		JOIN dept_manager
			USING (emp_no)
		JOIN departments
			USING (dept_no) 
		WHERE to_date > now()
			AND gender = 'F');
			
-- 2. Find the first and last name of the employee with the highest salary
SELECT first_name, last_name, salary
FROM employees
JOIN salaries
	USING (emp_no)
WHERE salary = (SELECT MAX(salary)
				FROM salaries);

-- 3. Find the department name that the employee with the highest salary works in.

SELECT dept_name
FROM departments
JOIN dept_emp
	USING (dept_no)
WHERE emp_no = (SELECT emp_no
				FROM employees
				JOIN salaries
					USING (emp_no)
				WHERE salary = (SELECT MAX(salary)
								FROM salaries));