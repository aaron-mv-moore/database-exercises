/*In the code editor below, revise the query to select the last_statement column in addition to the existing columns.
Once you're done, you can hit Shift+Enter to run the query.*/

SELECT first_name, last_name, last_statement
FROM executions
LIMIT 3; 

/* Run the given query and observe the error it produces. Fix the query.
Make it a habit to examine error messages when something goes wrong. Avoid debugging by gut feel or trial and error.*/

SELECT first_name FROM executions LIMIT 3

/*Modify the query to divide 50 and 51 by 2.
SQL supports all the usual arithmetic operations.*/

SELECT 50 / 2, 51 / 2

/*Find the first and last names and ages (ex_age) of inmates 25 or younger at time of execution.
Because the average time inmates spend on death row prior to execution is 10.26 years, only 6 inmates this young have been executed in Texas since 1976.*/

SELECT first_name, last_name, ex_age
FROM executions
WHERE ex_age < 26

/* Modify the query to find the result for Raymond Landry.
You might think this would be easy since we already know his first and last name. But datasets are rarely so clean. Use the LIKE operator so you don't have to know his name perfectly to find the row.*/


SELECT first_name, last_name, ex_number
FROM executions
WHERE first_name LIKE 'Raymond'
   AND last_name LIKE 'Landry%'

/*Insert a pair of parenthesis so that this statement returns 0.
Here we're relying on the fact that 1 means true and 0 means false.*/

SELECT 0 AND (0 OR 1)

/*Find Napoleon Beazley's last statement.*/

SELECT last_statement
FROM executions
WHERE first_name LIKE 'Napoleon'
    AND last_name LIKE 'Beazley%'
