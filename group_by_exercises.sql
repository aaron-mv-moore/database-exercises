-- GROUP BY Exercises --
USE employees
;
SELECT *
FROM employees
LIMIT 10
;

-- In your script, use DISTINCT to find the unique titles in the titles table. How many unique titles have there ever been?
	-- A: 7
	SELECT DISTINCT title 
	FROM titles
	;

-- Write a query to to find a list of all unique last names of all employees that start and end with 'E' using GROUP BY.
	SELECT last_name
	FROM employees
	WHERE last_name LIKE 'e%e'
	GROUP BY last_name
	;

-- Write a query to to find all unique combinations of first and last names of all employees whose last names start and end with 'E'.
	SELECT first_name, last_name, COUNT(*)
	FROM employees
	WHERE last_name LIKE 'e%e'
	GROUP BY last_name, first_name
	ORDER BY first_name
	;

-- Write a query to find the unique last names with a 'q' but not 'qu'. Include those names in a comment in your sql code.
	-- A: Chleq, Lindqvist, Qiwen
	SELECT last_name
	FROM employees
	WHERE last_name LIKE '%q%' 
		AND last_name NOT LIKE '%qu%'
	GROUP BY last_name
	;

-- Add a COUNT() to your results (the query above) to find the number of employees with the same last name.
	SELECT last_name, COUNT(*)
	FROM employees
	WHERE last_name LIKE '%q%' 
		AND last_name NOT LIKE '%qu%'
	GROUP BY last_name
	;
	
-- Find all employees with first names 'Irena', 'Vidya', or 'Maya'. Use COUNT(*) and GROUP BY to find the number of employees for each gender with those names.
	SELECT first_name, gender, COUNT(*)
	FROM employees
	WHERE first_name IN ('Irena', 'Vidya', 'Maya')
	GROUP BY first_name, gender
	ORDER BY first_name
	;
	
-- Using your query that generates a username for all of the employees, generate a count employees for each unique username.
	SELECT 
		lower(
		concat(
		substr(first_name, 1, 1), 
		substr(last_name, 1, 4), '_',
		lpad(MONTH(birth_date), 2, 0),  
		substr(YEAR(birth_date), -2))) AS username, 
		COUNT(*)
	FROM employees
	GROUP BY username
	;
	
-- From your previous query, are there any duplicate usernames? What is the higest number of times a username shows up? 
	-- A: There are many duplicate usernames. 6 Is the highest number of times a username shows up.
	SELECT 
		lower(
		concat(
		substr(first_name, 1, 1), 
		substr(last_name, 1, 4), '_',
		lpad(MONTH(birth_date), 2, 0),  
		substr(YEAR(birth_date), -2))) AS username, COUNT(*)
	FROM employees
	GROUP BY username
	ORDER BY COUNT(*) DESC
	;

-- Bonus: How many duplicate usernames are there from your previous query?
	-- 13251
 	SELECT COUNT(d.username)
 	FROM (SELECT 
		lower(
		concat(
		substr(first_name, 1, 1), 
		substr(last_name, 1, 4), '_',
		lpad(MONTH(birth_date), 2, 0),  
		substr(YEAR(birth_date), -2))) AS username, COUNT(*) as count
	FROM employees
	GROUP BY username
	HAVING count > 1) AS d
	;	


-- Bonus: More practice with aggregate functions --

-- Determine the historic average salary for each employee. When you hear, read, or think "for each" with regard to SQL, you'll probably be grouping by that exact column.
	SELECT emp_no, round(avg(salary), 2)
	FROM salaries
	WHERE to_date < now()
	GROUP BY emp_no
	;

-- Using the dept_emp table, count how many current employees work in each department. The query result should show 9 rows, one for each department and the employee count.
	DESCRIBE dept_emp;
	SELECT dept_no, SUM(emp_no)
	FROM dept_emp
	WHERE to_date > now()
	GROUP BY dept_no
	;

-- Determine how many different salaries each employee has had. This includes both historic and current.
	SELECT emp_no, COUNT(salary)
	FROM salaries
	GROUP BY emp_no
	;

-- Find the maximum salary for each employee.
	SELECT emp_no, max(salary)
	FROM salaries
	GROUP BY emp_no
	;
	
-- Find the minimum salary for each employee.
	SELECT emp_no, min(salary)
	FROM salaries
	GROUP BY emp_no
	;
	
-- Find the standard deviation of salaries for each employee.
	SELECT emp_no, STDDEV(salary)
	FROM salaries
	GROUP BY emp_no
	;

-- Now find the max salary for each employee where that max salary is greater than $150,000.
	SELECT emp_no, max(salary)
	FROM salaries
	GROUP BY emp_no
	HAVING max(salary) > 150000
	;
	
-- Find the average salary for each employee where that average salary is between $80k and $90k.
	SELECT emp_no, round(avg(salary), 2)
	FROM salaries
	GROUP BY emp_no
	HAVING avg(salary) BETWEEN 80000 AND 90000
	;