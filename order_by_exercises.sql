-- ORDER BY exercises
USE employees;

-- 2 Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by first name. 
SELECT *
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY `first_name`;
	-- What was the first and last name in the first row of the results? 
		-- A: Irena Reutenauer
	SELECT *
	FROM employees
	WHERE first_name IN ('Irena', 'Vidya', 'Maya')
	ORDER BY `first_name`
	LIMIT 1;
	-- What was the first and last name of the last person in the table.
		-- A: Vidya Simmen
	SELECT *
	FROM employees
	WHERE first_name IN ('Irena', 'Vidya', 'Maya')
	ORDER BY `first_name`;

-- 3 Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by first name and then last name. In your comments, answer: 
	-- What was the first and last name in the first row of the results? 
	-- A: Irena Acton
	-- What was the first and last name of the last person in the table?
	-- A: Vidya Zweizig
	SELECT *
	FROM employees
	WHERE first_name IN ('Irena', 'Vidya', 'Maya')
	ORDER BY `first_name`, last_name;

-- 4 Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by last name and then first name. In your comments, answer: 
SELECT *
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY last_name, first_name;
	-- What was the first and last name in the first row of the results?
	-- A:  Irena Acton
	SELECT first_name, last_name
	FROM employees
	WHERE first_name IN ('Irena', 'Vidya', 'Maya')
	ORDER BY last_name, first_name
	LIMIT 1; 
	-- What was the first and last name of the last person in the table?
	-- A: Maya Zyda
	SELECT *
	FROM employees
	WHERE first_name IN ('Irena', 'Vidya', 'Maya')
	ORDER BY last_name, first_name;

-- 5 Write a query to to find all employees whose last name starts and ends with 'E'. Sort the results by their employee number. 
SELECT emp_no, first_name, last_name
FROM employees
WHERE last_name LIKE 'E%e' 
ORDER BY emp_no;
	-- the number of employees returned
		-- A: 899 
	SELECT COUNT(*)
	FROM employees
	WHERE last_name LIKE 'e%e'
	ORDER BY emp_no;
	-- the first employee number and their first and last name
		-- A: 10021 Ramzi Erde
	SELECT emp_no, first_name, last_name
	FROM employees
	WHERE last_name LIKE 'e%e'
	ORDER BY `emp_no`LIMIT 1;
	-- last employee number with their first and last name.
		-- A: 499648 Tadahiro Erde
	SELECT emp_no, first_name, last_name
	FROM employees
	WHERE last_name LIKE 'E%e' 
	ORDER BY emp_no DESC 
	LIMIT 1;

-- 6 Sort the results by their hire date, so that the newest employees are listed first.
SELECT emp_no, first_name, last_name, hire_date
FROM employees
WHERE last_name LIKE 'E%e' 
ORDER BY hire_date DESC;
	-- the number of employees returned
		-- A: 899
	SELECT COUNT(*)
	FROM employees
	WHERE last_name LIKE 'E%e' 
	ORDER BY hire_date DESC;
	-- the name of the newest employee
		-- A: Teiji Eldridge
	SELECT emp_no, first_name, last_name, hire_date
	FROM employees
	WHERE last_name LIKE 'E%e' 
	ORDER BY hire_date DESC, birth_date
	LIMIT 1;
	-- the name of the oldest employee.
		-- A: Sergi Erde
	SELECT emp_no, first_name, last_name, hire_date
	FROM employees
	WHERE last_name LIKE 'E%e' 
	ORDER BY hire_date
	LIMIT 1;

-- 7 Find all employees hired in the 90s and born on Christmas. Sort the results so that the oldest employee who was hired last is the first result. 
	-- the number of employees returned
		-- A:
	SELECT count(*)
	FROM employees
	WHERE birth_date LIKE '%12-25'
	AND hire_date LIKE '199%';
	-- the name of the oldest employee who was hired last
		-- A: Bernini Khun
	SELECT first_name, last_name
	FROM employees
	WHERE birth_date LIKE '%12-25'
	AND hire_date LIKE '199%'
	ORDER BY birth_date, hire_date DESC;
	-- the name of the youngest employee who was hired first
		-- A: Douadi	Pettis	
	SELECT first_name, last_name
	FROM employees
	WHERE birth_date LIKE '%12-25'
	AND hire_date LIKE '199%'
	ORDER BY birth_date DESC, hire_date;
	SELECT first_name, last_name, BIRTH_DATE