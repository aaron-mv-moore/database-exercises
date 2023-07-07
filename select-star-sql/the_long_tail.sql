/* pull execution count by county */

SELECT
  county,
  COUNT(*) AS county_executions
FROM executions
GROUP BY county;

/*This query counts the executions with and without last statements. Modify it to further break it down by county*/

SELECT
  last_statement IS NOT NULL AS has_last_statement,
  COUNT(*)
FROM executions
GROUP BY has_last_statement;

/*Count the number of inmates aged 50 or older that were executed in each county. */
SELECT 
  county,
  COUNT(*) AS num_executed_50_plus
FROM executions
WHERE ex_age >= 50
GROUP BY county;

/* List the counties in which more than 2 inmates aged 50 or older have been executed. */
SELECT 
  county
FROM executions
WHERE ex_age >= 50
GROUP BY county
  HAVING COUNT(*) > 2;

/*List all the distinct counties in the dataset.
We did this in the previous chapter using the SELECT DISTINCT command. This time, stick with vanilla SELECT and use GROUP BY.*/
SELECT 
  county
FROM executions
GROUP BY county;

/*Find the first and last name of the inmate with the longest last statement (by character count).*/
SELECT first_name, last_name
FROM executions
WHERE LENGTH(last_statement) =
    (SELECT MAX(
	  LENGTH(last_statement)
	  )
	 FROM executions);

/* query to find the percentage of executions from each county. */
SELECT
  county,
  100.0 * COUNT(*) / (SELECT COUNT(*) FROM executions)
    AS percentage
FROM executions
GROUP BY county
ORDER BY percentage DESC;
