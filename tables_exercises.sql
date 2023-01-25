USE employees;
SHOW TABLES;
DESCRIBE salaries;
DESCRIBE employees;
DESCRIBE dept_emp;
DESCRIBE dept_manager;
DESCRIBE titles;
DESCRIBE departments; /* No dates present*/

-- 6
/* Which table(s) do you think contain a numeric type column?*/
/* The emp_no variable is a numeric type column as well as salary column. These columns are present in the tables: salary, employees, dept_emp, titles, dept_manager*/ 
SELECT * FROM salaries;


-- 7. 
/* Which table(s) do you think contain a string type column?*/
/* All but "salaries" contain string columns, but the following are my favorite: 
departments.dept_name, employees.first_name, employees.last_name, titles.title */
SELECT dept_name FROM departments;
SELECT first_name, last_name FROM employees;
SELECT title FROM titles;

-- 8
/*Which table(s) do you think contain a date type column?*/
/*All tables except departments contain dates*/

-- 9
/*What is the relationship between the employees and the departments tables? The employees belong to certain departments which is represented in the dept_emp table*/
SELECT emp_no, dept_no FROM dept_emp;

-- 10
SHOW CREATE TABLE dept_manager;






