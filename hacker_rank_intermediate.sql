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
