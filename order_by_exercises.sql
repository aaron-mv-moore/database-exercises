-- ORDER BY exercises
USE employees;

-- 2 Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by first name. 
-- What was the first and last name in the first row of the results? 
	-- A: Irena Reutenauer
-- What was the first and last name of the last person in the table.
	-- A: Vidya Simmen
SELECT *
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY `first_name`;

-- 3
-- A: Irena Acton, Vidya Zweizig
SELECT *
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY `first_name`, last_name;

-- 4
	-- A: Irena Acton, Maya Zyda
SELECT *
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY last_name, first_name;

-- 5
	-- A: 899. 10021	Ramzi	Erde; 499648	Tadahiro	Erde
SELECT emp_no, first_name, last_name
FROM employees
WHERE last_name LIKE 'E%e' 
ORDER BY emp_no;

-- 6
	-- A: 899, NEWEST: 67892	Teiji	Eldridge	1999-11-27; OLDEST: 233488	Sergi	Erde	1985-02-02
SELECT emp_no, first_name, last_name, hire_date
FROM employees
WHERE last_name LIKE 'E%e' 
ORDER BY hire_date DESC;

-- 7
	-- A: 33936	1952-12-25	Khun	Bernini	M	1999-08-31
SELECT *
FROM employees
WHERE birth_date LIKE '%12-25'
AND hire_date LIKE '199%'
ORDER BY hire_date DESC, birth_date DESC;