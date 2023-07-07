/*Edit the query to find how many inmates provided last statements.
We can use COUNT here because NULLs are used when there are no statements. */

SELECT COUNT(last_statement) FROM executions;

/*Verify that 0 and the empty string are not considered NULL.
Recall that this is a compound clause. Both of the two IS NOT NULL clauses have to be true for the query to return true.*/

SELECT (0 IS NOT NULL) AND ('' IS NOT NULL);

/*Find the total number of executions in the dataset.
The idea here is to pick one of the columns that you're confident has no NULLs and count it.*/

SELECT COUNT(first_name) 
FROM executions;

/*This query counts the number of Harris and Bexar county executions. Replace SUMs with COUNTs and edit the CASE WHEN blocks so the query still works.
Switching SUM for COUNT alone isn't enough because COUNT still counts the 0 since 0 is non-null.*/

SELECT
    COUNT(CASE WHEN county='Harris' THEN 1
        ELSE NULL END),
    COUNT(CASE WHEN county='Bexar' THEN 1
        ELSE NULL END)
FROM executions;

/*Find how many inmates were over the age of 50 at execution time.
This illustrates that the WHERE block filters before aggregation occurs.*/

SELECT COUNT(*)
FROM executions
WHERE ex_age > 50;

/*Find the number of inmates who have declined to give a last statement.
For bonus points, try to do it in 3 ways:
1) With a WHERE block,
2) With a COUNT and CASE WHEN block,
3) With two COUNT functions.*/

SELECT COUNT(*)
FROM executions
WHERE last_statement IS NULL 
	OR last_statement = ''
	OR last_statement = 0;
	
SELECT 
	COUNT(CASE WHEN last_statement IS NULL THEN 0 
		  ELSE NULL END)
FROM executions;

SELECT COUNT(*) - COUNT(last_statement)
FROM executions;


/*Find the minimum, maximum and average age of inmates at the time of execution.
Use the MIN, MAX, and AVG aggregate functions.*/

SELECT MIN(ex_age), MAX(ex_age), AVG(ex_age) FROM executions;

/*Find the average length (based on character count) of last statements in the dataset.
This exercise illustrates that you can compose functions. Look up the documentation to figure out which function which returns the number of characters in a string.*/

SELECT AVG(LENGTH(last_statement)) FROM executions;

/*List all the counties in the dataset without duplication.
We can get unique entries by using SELECT DISTINCT. See documentation.*/

SELECT DISTINCT county
FROM executions;

/*Find the proportion of inmates with claims of innocence in their last statements.
To do decimal division, ensure that one of the numbers is a decimal by multiplying it by 1.0. Use LIKE '%innocent%' to find claims of innocence.*/

SELECT COUNT(
  CASE WHEN last_statement LIKE '%innocent%' THEN 1 ELSE NULL END) * 1.0 / COUNT(*)
FROM executions;
