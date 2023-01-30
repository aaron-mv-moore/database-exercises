-- LIMIT EXERCISES
	USE employees;

-- List the first 10 distinct last name sorted in descending order.
	SELECT DISTINCT last_name
	FROM employees
	ORDER BY last_name DESC
	LIMIT 10;

-- Find all previous or current employees hired in the 90s and born on Christmas
	SELECT *
	FROM employees
	WHERE hire_date LIKE '199%'
	AND birth_date LIKE '%12-25';
	
-- Find the first 5 employees hired in the 90's by sorting by hire date and limiting your results to the first 5 records.
	-- A: Alselm Cappello, Utz Mandell, Bouchung Schreiter, Baocai Kushner, Petter Stroustrup 
	SELECT first_name, last_name
	FROM employees
	WHERE hire_date LIKE '199%'
	AND birth_date LIKE '%12-25'
	ORDER BY hire_date
	LIMIT 5;

-- Update the query to find the tenth page (1 page = 5 results) of results.
	SELECT *
	FROM employees
	WHERE hire_date LIKE '199%'
	AND birth_date LIKE '%12-25'
	ORDER BY hire_date
	LIMIT 5 OFFSET 45;

-- OFFSET allows us to skip to the page number we would like to begin on. The LIMIT will begin its count on the item directly after the OFFSET.
