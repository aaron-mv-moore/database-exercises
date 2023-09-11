/*
Ollivander's Inventory
Harry Potter and his friends are at Ollivander's with Ron, finally replacing Charlie's old broken wand.
Hermione decides the best way to choose is by determining the minimum number of gold galleons needed to buy each non-evil wand of high power and age. Write a query to print the id, age, coins_needed, and power of the wands that Ron's interested in, sorted in order of descending power. If more than one wand has same power, sort the result in order of descending age.
*/
-- the wanted columns
SELECT 
  a.id,
  b.age,
  a.coins_needed,
  a.power
FROM wands a
JOIN wands_property b ON a.code = b.code
WHERE is_evil = 0
  AND (a.coins_needed) IN

-- the minimum coins needed for power and age
(SELECT 
  MIN(c.coins_needed)
FROM wands c
JOIN wands_property d ON c.code = d.code
WHERE a.power = c.power AND b.age = d.age)

-- order by power first then age
ORDER BY a.power DESC,
  b.age DESC
;

/*
Weather Observation Station 5
Query the two cities in STATION with the shortest and longest CITY names, as well as their respective lengths (i.e.: number of characters in the name). If there is more than one smallest or largest city, choose the one that comes first when ordered alphabetically. 
*/
SELECT
  city,
  LENGTH(city)
FROM station
ORDER BY LENGTH(city), city
LIMIT 1;
SELECT
  city,
  LENGTH(city)
FROM station
ORDER BY LENGTH(city) DESC, city
LIMIT 1;

/*
Binary Tree Nodes
You are given a table, BST, containing two columns: N and P, where N represents the value of a node in Binary Tree, and P is the parent of N.

Write a query to find the node type of Binary Tree ordered by the value of the node. Output one of the following for each node:
Root: If node is root node.
Leaf: If node is leaf node.
Inner: If node is neither root nor leaf node.
*/
-- -- BROKEN DOWN
-- -- Root - n is in p and the p of n is null
-- SELECT
--   n
-- FROM bst
-- WHERE n IN (SELECT p from bst) 
--   AND p IS NULL;
-- -- Inner - N is in p and the p of n is not null
-- SELECT
--  n
-- FROM bst
-- WHERE n IN (SELECT p from bst) 
--   AND p IS NOT NULL;
-- -- Leaf - n is not in p and p of n is not null
-- SELECT
--  n
-- FROM bst
-- WHERE n NOT IN (SELECT p from bst) 
--   AND p IS NOT NULL;
  
-- ALL TOGETHER
SELECT 
  n,
  CASE 
   WHEN p IS NULL THEN 'Root'
   WHEN n IN (SELECT p FROM bst) THEN 'Inner'
   ELSE'Leaf' 
  END AS node_type
FROM bst
ORDER BY n ASC;

/*
New Companies
Amber's conglomerate corporation just acquired some new companies. Each of the companies follows this hierarchy: 
Founder > Lead Manager > Senior Manager > Manager > EMployee
Given the table schemas below, write a query to print the company_code, founder name, total number of lead managers, total number of senior managers, total number of managers, and total number of employees. Order your output by ascending company_code.
Note:
The tables may contain duplicate records.
The company_code is string, so the sorting should not be numeric. For example, if the company_codes are C_1, C_2, and C_10, then the ascending company_codes will be C_1, C_10, and C_2.
*/

SELECT
  b.company_code,
  b.founder,
  COUNT(DISTINCT(a.lead_manager_code)),
  COUNT(DISTINCT(a.senior_manager_code)),
  COUNT(DISTINCT(a.manager_code)),
  COUNT(DISTINCT(a.employee_code))
FROM employee a
  LEFT JOIN company b ON a.company_code = b.company_code
GROUP BY b.company_code, b.founder
ORDER BY b.company_code ASC;

/*
Weather Observation Station 20
A median is defined as a number separating the higher half of a data set from the lower half. Query the median of the Northern Latitudes (LAT_N) from STATION and round your answer to 4 decimal places.
*/
-- setting row number
SET @row_number = -1;
-- get lat_n ordered
WITH cte1 AS(
    SELECT 
      (@row_number := @row_number + 1) as num,
      lat_n
    FROM station
    ORDER BY lat_n)

-- checking the number of rows
-- SELECT CASE
--     WHEN MAX(num) % 2 = 1 THEN 'odd'
--     WHEN MAX(num) % 2 = 0 THEN 'even'
--     END AS odd_even
-- FROM cte1

SELECT ROUND(AVG(lat_n), 4)
FROM cte1
WHERE num IN (CEIL(@row_number/2), FLOOR(@row_number/2)) ;

/*
The Report
You are given two tables: Students and Grades. Students contains three columns ID, Name and Marks.
Grades contains the following data: grade,min_mark, max_mark
Ketty gives Eve a task to generate a report containing three columns: Name, Grade and Mark. Ketty doesn't want the NAMES of those students who received a grade lower than 8. The report must be in descending order by grade -- i.e. higher grades are entered first. If there is more than one student with the same grade (8-10) assigned to them, order those particular students by their name alphabetically. Finally, if the grade is lower than 8, use "NULL" as their name and list them by their grades in descending order. If there is more than one student with the same grade (1-7) assigned to them, order those particular students by their marks in ascending order.
Write a query to help Eve.
*/

SELECT
  IF(b.grade >= 8, a.name, NULL) as name,
  b.grade,
  a.marks
FROM students a
JOIN grades b ON a.marks >= b.min_mark
  AND a.marks <= b.max_mark
ORDER BY b.grade DESC, a.name ASC, a.marks ASC
;

/*
Top Competitors
Julia just finished conducting a coding contest, and she needs your help assembling the leaderboard! Write a query to print the respective hacker_id and name of hackers who achieved full scores for more than one challenge. Order your output in descending order by the total number of challenges in which the hacker earned a full score. If more than one hacker received full scores in same number of challenges, then sort them by ascending hacker_id.
*/

SELECT 
  a.hacker_id,
  MAX(d.name)
FROM submissions a
JOIN challenges b ON a.challenge_id = b.challenge_id
JOIN difficulty c ON b.difficulty_level = c.difficulty_level
  AND a.score = c.score
JOIN hackers d ON a.hacker_id = d.hacker_id
GROUP BY a.hacker_id
  HAVING COUNT(a.submission_id) > 1
ORDER BY COUNT(a.submission_id) DESC, a.hacker_id ASC;

/*
Challenges
Julia asked her students to create some coding challenges. Write a query to print the hacker_id, name, and the total number of challenges created by each student. Sort your results by the total number of challenges in descending order. If more than one student created the same number of challenges, then sort the result by hacker_id. If more than one student created the same number of challenges and the count is less than the maximum number of challenges created, then exclude those students from the result.
-- */
-- Conditions for inclusion
-- - is the maximum/highest challenge_count 
-- with cte1 as (SELECT hacker_id,
--   COUNT(challenge_id) as challenge_count
-- FROM challenges 
-- GROUP BY hacker_id)

-- SELECT  
--   hacker_id,
--   challenge_count
-- FROM cte1
-- WHERE challenge_count = (SELECT MAX(challenge_count)
-- FROM cte1);

-- - there is only one challenge count
-- with cte1 as (SELECT hacker_id,
--   COUNT(challenge_id) as challenge_count
-- FROM challenges 
-- GROUP BY hacker_id)

-- SELECT
--   challenge_count
-- FROM cte1
-- GROUP BY challenge_count
--     HAVING COUNT(hacker_id) = 1;
    
-- combine

with cte1 as (SELECT hacker_id,
  COUNT(challenge_id) as challenge_count
FROM challenges 
GROUP BY hacker_id)

SELECT  
  cte1.hacker_id,
  b.name,
  challenge_count
FROM cte1
JOIN hackers b on cte1.hacker_id = b.hacker_id
WHERE challenge_count = (SELECT MAX(challenge_count)
FROM cte1) 
  OR challenge_count IN (SELECT
  challenge_count
FROM cte1
GROUP BY challenge_count
    HAVING COUNT(hacker_id) = 1)
ORDER BY challenge_count DESC, hacker_id ASC;
/*
Contest Leaderboard
You did such a great job helping Julia with her last coding contest challenge that she wants you to work on this one, too!
The total score of a hacker is the sum of their maximum scores for all of the challenges. Write a query to print the hacker_id, name, and total score of the hackers ordered by the descending score. If more than one hacker achieved the same total score, then sort the result by ascending hacker_id. Exclude all hackers with a total score of 0 from your result.
*/

SELECT 
  t1.hacker_id,
  MAX(t2.name),
  SUM(max_challenge_score) as total_score
FROM 
    (SELECT
      hacker_id,
      challenge_id,
      MAX(score) as max_challenge_score
    FROM submissions
    WHERE score > 0
    GROUP BY hacker_id, challenge_id) t1
JOIN hackers t2 ON t1.hacker_id = t2.hacker_id
GROUP BY t1.hacker_id
ORDER BY total_score DESC, hacker_id ASC;


/*
SQL Project Planning
You are given a table, Projects, containing three columns: Task_ID, Start_Date and End_Date. It is guaranteed that the difference between the End_Date and the Start_Date is equal to 1 day for each row in the table.

If the End_Date of the tasks are consecutive, then they are part of the same project. Samantha is interested in finding the total number of different projects completed.

Write a query to output the start and end dates of projects listed by the number of days it took to complete the project in ascending order. If there is more than one project that have the same number of completion days, then order by the start date of the project.

Steps
    a. create a table with a project id attached to each task
        1. order by end date
        2. Take the difference of the date of interest with the date in front or behind it
        3. each time that does not equal 1, the counter goes up one
    b. group by project id 
    c. select the min date for the start_date
    d. select the max date for the end date
    e. find the difference for the two values (min start and max end)
    f. order the results
*/
SET @project_counter = 0;

WITH cte1 AS(
    SELECT
      task_id,
      start_date, '|',
      LAG(end_date, 1) OVER (ORDER BY end_date) as previous_date,
      end_date, '|' b,
      (start_date <> LAG(end_date, 1) OVER (ORDER BY end_date)) as is_new_project
    FROM projects), 

cte2 AS(
    SELECT 
      task_id,
      start_date,
      previous_date,
      end_date,
      is_new_project,
      CASE
        WHEN is_new_project = 1 THEN  (@project_counter :=  @project_counter + 1 )
        ELSE  @project_counter
      END project_id
    FROM cte1)
    
SELECT 
    MIN(start_date) project_start_date,
    MAX(end_date)
FROM cte2
GROUP BY project_id
ORDER BY DATEDIFF(MAX(end_date), MIN(start_date)) ASC, project_start_date ASC
;

/*
Placements
You are given three tables: Students, Friends and Packages. Students contains two columns: ID and Name. Friends contains two columns: ID and Friend_ID (ID of the ONLY best friend). Packages contains two columns: ID and Salary (offered salary in $ thousands per month).

Write a query to output the names of those students whose best friends got offered a higher salary than them. Names must be ordered by the salary amount offered to the best friends. It is guaranteed that no two students got same salary offer.

names of people who's best frineds fgot more than them

What we need to succeed:
    1. A column with the students of focus salaries
    1. a column with the salaries of the firend
    1. a column that is true or false is_friend_salary_larger (friend_salary > student_salary)
    1. if is_friend_salary_larger = 1, include the student name
*/
WITH cte1 AS (SELECT
    b.id,
    b.salary student_salary,
    c.salary friend_salary,
    c.salary > b.salary is_friend_salary_larger,
    d.name student_name
FROM friends a
JOIN packages b on a.id = b.id
JOIN packages c on a.friend_id = c.id
JOIN students d ON a.id = d.id
ORDER BY friend_salary)

SELECT
  student_name
FROM cte1
WHERE is_friend_salary_larger = 1;

/*
Symmetric Pairs
You are given a table, Functions, containing two columns: X and Y.
Two pairs (X1, Y1) and (X2, Y2) are said to be symmetric pairs if X1 = Y2 and X2 = Y1.
Write a query to output all such symmetric pairs in ascending order by the value of X. List the rows such that X1 <= Y1.
*/
WITH cte1 AS(SELECT *,
            ROW_NUMBER() OVER (ORDER BY X) as row_num 
            FROM functions)

SELECT t1.x, t1.y
FROM cte1 t1
CROSS JOIN cte1 t2 -- get cartesian product (all combinations) 
WHERE t1.row_num <> t2.row_num -- No matching with itself for doubles (10, 10)
  AND t1.x = t2.y 
  AND t1.y = t2.x 
  AND t1.x <= t1.y    
GROUP BY t1.x, t1.y -- reduce duplicates
ORDER BY t1.x;
