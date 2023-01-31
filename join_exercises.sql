-- JOIN exercises -- 
-- Join Example Database
USE join_example_db;

/* Use the join_example_db. Select all the records from both the users and roles tables. */
	SELECT *
	FROM users;
	
	SELECT *
	FROM roles;
	
/* Use join, left join, and right join to combine results from the users and roles tables as we did in the lesson. Before you run each query, guess the expected number of results. */
	SELECT *
	FROM users
	JOIN roles ON roles.id = users.role_id
	;
	
	SELECT *
	FROM users
	LEFT JOIN roles ON roles.id = users.role_id
	;
	
	SELECT * 
	FROM users
	RIGHT JOIN roles ON roles.id = users.role_id
	;

/* Although not explicitly covered in the lesson, aggregate functions like count can be used with join queries. Use count and the appropriate join type to get a list of roles along with the number of users that has the role. Hint: You will also need to use group by in the query. */
	SELECT roles.name, 
	count(users.role_id) AS users_in_role
	FROM users
	RIGHT JOIN roles ON roles.id = users.role_id
	GROUP BY roles.name
	;
	

-- Employees Database
USE employees;
SHOW TABLES;

/* Using the example in the Associative Table Joins section as a guide, write a query that shows each department along with the name of the current manager for that department. */
	DESC departments; -- dept_no 
	DESC dept_manager; -- dept_no and emp_no
	DESC employees; -- emp_no, first_name, last_name
	
	SELECT 
		departments.dept_name,
		concat(
			employees.first_name,
			 ' ', 
			 employees.last_name) 
		 AS cur_manager
	FROM departments
	JOIN dept_manager 
		ON departments.dept_no = dept_manager.dept_no
	JOIN employees 
		ON dept_manager.emp_no = employees.emp_no
	WHERE to_date > now()
	;
	
/* Find the name of all departments currently managed by women. */
	SELECT 
		departments.dept_name,
		concat(
			employees.first_name,
			 ' ', 
			 employees.last_name) 
		 AS cur_manager
	FROM departments
	JOIN dept_manager 
		ON departments.dept_no = dept_manager.dept_no
	JOIN employees 
		ON dept_manager.emp_no = employees.emp_no
	WHERE to_date > now() 
		AND employees.gender = 'F'
	;
	
/* Find the current titles of employees currently working in the Customer Service department. */
	DESC titles; -- emp_no, title, to_date
	DESC employees; -- emp_no, first_name, last_name
	DESC dept_emp; -- emp_no, dept_no
	DESC departments; -- dept_no, dept_name
	
	SELECT
		titles.title,
		COUNT(*)
	FROM departments
	JOIN dept_emp 
		ON departments.dept_no = dept_emp.dept_no
	JOIN employees
		ON dept_emp.emp_no = employees.emp_no
	JOIN titles
		ON employees.emp_no = titles.emp_no
	WHERE (titles.to_date > now())
		AND (departments.dept_name = 'Customer Service')
	GROUP BY titles.title
	;

/* Find the current salary of all current managers. */
	DESC salaries; 
		
	SELECT
		departments.dept_name,
		concat(
			employees.first_name,
			 ' ', 
			employees.last_name) 
		AS cur_manager, 
		salaries.salary
	FROM departments
	JOIN dept_manager 
		ON departments.dept_no = dept_manager.dept_no
	JOIN employees 
		ON dept_manager.emp_no = employees.emp_no
	JOIN salaries
		on employees.emp_no = salaries.emp_no
	WHERE salaries.to_date > now() 
		AND dept_manager.to_date > now()
	;
	
/* Find the number of current employees in each department. */
	DESC departments; -- select dept_name, join dept_no
	DESC dept_emp; -- join dept_no -  emp_no, where to_date
	DESC employees; -- count emp_no
	
	SELECT 
		departments.dept_no,
		departments.dept_name,
		COUNT(dept_emp.emp_no)
	AS num_employees
	FROM departments
	JOIN dept_emp
		ON departments.dept_no = dept_emp.dept_no
	WHERE to_date > now()
	GROUP BY departments.dept_name
	;

/* Which department has the highest average salary? Hint: Use current not historic information. */
	DESC departments; -- SELECT dept_name
	DESC dept_emp; -- join dept_no
	DESC salaries; -- select max(salary), join emp_no, where to_date 
	
	SELECT 
		dept_name,
		avg(salary) AS avg_salary
	FROM departments
	JOIN dept_emp
		ON departments.dept_no = dept_emp.dept_no
	JOIN salaries
		ON dept_emp.emp_no = salaries.emp_no
	WHERE salaries.to_date > now()
		AND dept_emp.to_date > now()
	GROUP BY dept_name
	ORDER BY avg_salary DESC
	LIMIT 1
	;

/* Who is the highest paid employee in the Marketing department? */
	DESC departments; -- where dept_name = marketing, join dept_no, select dept_name
	DESC dept_emp; -- join dept_no, emp_no, where to_date !< now()
	DESC employees; -- join emp_no, select first_name, last_name,
	DESC salaries; -- join emp_no, where to_date !< now(), select salary
	
	SELECT 
		first_name,
		last_name,
		dept_name, 
		salary
	FROM salaries
	JOIN employees
		ON salaries.emp_no = employees.emp_no
	JOIN dept_emp
		ON employees.emp_no = dept_emp.emp_no
	JOIN departments
		ON dept_emp.dept_no = departments.dept_no
	WHERE salaries.to_date > now()
		AND dept_emp.to_date > now()
		AND dept_name = 'Marketing'
	ORDER BY salary DESC
	LIMIT 1
	;
	
/* Which current department manager has the highest salary? */
	DESC departments;
	DESC dept_manager;
	DESC salaries;
	DESC employees;
	
	SELECT
		first_name,
		last_name,
		dept_name,
		salary
	FROM employees e
	JOIN salaries s
		ON e.emp_no = s.emp_no
	JOIN dept_manager dm
		ON s.emp_no = dm.emp_no
	JOIN departments d
		ON dm.dept_no = d.dept_no
	WHERE dm.to_date > now()
		AND s.to_date > now()
	ORDER BY salary DESC
	LIMIT 1
	;
	
/* Determine the average salary for each department. Use all salary information and round your results. */
	DESC departments;
	DESC dept_emp;
	DESC salaries;
	
	SELECT
		dept_name,
		round(avg(salary), 0) AS avg_salary
	FROM salaries s
	JOIN dept_emp de
		ON s.emp_no = de.emp_no
	JOIN departments d
		ON de.dept_no = d.dept_no
	GROUP BY dept_name
	ORDER BY avg_salary DESC
	;
	
/* Bonus Find the names of all current employees, their department name, and their current manager's name. */
	DESC employees;
	DESC dept_emp;
	DESC departments;
	DESC dept_manager;
	
	SELECT 
		concat(
			e.first_name, 
			' ',
			e.last_name) 
		AS employee_name,
		dept_name, 
		concat(em.first_name,
			' ',
			em.last_name)
		AS manager_name
	FROM employees e
	JOIN dept_emp de
		ON e.emp_no = de.emp_no
	JOIN departments d
		ON de.dept_no = d.dept_no
	JOIN dept_manager dm
		ON d.dept_no = dm.dept_no
	JOIN employees em
		ON dm.emp_no = em.emp_no
	WHERE de.to_date > now() 
		AND dm.to_date > now()
	; 
	
/* Bonus Who is the highest paid employee within each department. */

	/* SELECT first_name,
		max(salary)
	FROM salaries s
	Right JOIN employees e
		ON s.emp_no = e.emp_no
	JOIN dept_emp de
		ON e.emp_no = de.emp_no
	JOIN departments d
		ON de.dept_no = d.dept_no
	WHERE s.to_date > now()
		AND de.to_date > now()
		GROUP BY dept_name
		 */
