-- WHERE exercises
	USE employees;
	DESCRIBE employees;
	SELECT * FROM employees LIMIT 10;

-- Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya' using IN. Enter a comment with the number of records returned.
	-- A: 709
	SELECT count(*) 
	FROM employees 
	WHERE first_name IN ('Irena', 'Vidya', 'Maya');

-- Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya', as in Q2, but use OR instead of IN. Enter a comment with the number of records returned. Does it match number of rows from Q2?
	-- A: 709
	SELECT count(*) 
	FROM employees 
	WHERE first_name = 'Irena' 
	OR first_name = 'Vidya' 
	OR first_name = 'Maya';

-- Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya', using OR, and who is male. Enter a comment with the number of records returned.
	-- A: 441
	SELECT count(*) 
	FROM employees 
	WHERE (first_name = 'Irena' OR first_name = 'Vidya' OR first_name = 'Maya') 
	AND gender = 'M';

-- Find all current or previous employees whose last name starts with 'E'. Enter a comment with the number of employees whose last name starts with E.
	-- A: 7330
	SELECT count(*) 
	FROM employees 
	WHERE last_name LIKE 'E%';

-- Find all current or previous employees whose last name starts or ends with 'E'. Enter a comment with the number of employees whose last name starts or ends with E. 
	-- A: 30723
	SELECT count(*) 
	FROM employees 
	WHERE last_name LIKE 'E%' 
	OR last_name LIKE '%e';

-- How many employees have a last name that ends with E, but does not start with E? 
	-- A: 23393
	SELECT count(*) 
	FROM employees 
	WHERE (last_name LIKE '%e') 
	AND (last_name NOT LIKE 'E%'); 

-- Find all current or previous employees employees whose last name starts and ends with 'E'. Enter a comment with the number of employees whose last name starts and ends with E. 
	-- A: 899
	SELECT count(*) 
	FROM employees 
	WHERE last_name LIKE 'E%' 
	AND last_name LIKE '%e';

	SELECT count(*)
	FROM employees
	WHERE last_name LIKE 'E%e';

-- How many employees' last names end with E, regardless of whether they start with E?
	-- A: 24292
	SELECT count(*) 
	FROM employees 
	WHERE last_name LIKE '%e';

-- Find all current or previous employees hired in the 90s. Enter a comment with the number of employees returned.
	-- A: 135214
	SELECT count(*) 
	FROM employees 
	WHERE hire_date LIKE '199%';

-- Find all current or previous employees born on Christmas. Enter a comment with the number of employees returned.
	-- A: 842
	SELECT count(*) 
	FROM employees 
	WHERE birth_date LIKE '%12-25';


-- Find all current or previous employees hired in the 90s and born on Christmas. Enter a comment with the number of employees returned.
	-- A: 362
	SELECT count(*) 
	FROM employees 
	WHERE hire_date LIKE '199%' 
	AND birth_date LIKE '%12-25';

-- Find all current or previous employees with a 'q' in their last name. Enter a comment with the number of records returned.
	-- A: 1873
	SELECT count(*) 
	FROM employees 
	WHERE last_name LIKE '%q%';

-- Find all current or previous employees with a 'q' in their last name but not 'qu'. How many employees are found?
	-- A: 547
	SELECT count(*) 
	FROM employees 
	WHERE last_name LIKE '%q%' 
	AND last_name NOT LIKE '%qu%';

