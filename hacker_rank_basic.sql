/*Revising the Select Query I:
Query all columns for all American cities in the CITY table with populations larger than 100000. The CountryCode for America is USA.*/
SELECT *
FROM city
WHERE 
  countrycode = 'USA' 
  AND
  population > 100000;

/* Revising the Select Query II
Query the NAME field for all American cities in the CITY table with populations larger than 120000. The CountryCode for America is USA.
*/
SELECT name
FROM city
WHERE 
  population > 120000
  AND
  countrycode = 'USA';

/*Select All
Query all columns (attributes) for every row in the CITY table.*/
SELECT *
FROM city;

/*Select By ID
Query all columns for a city in CITY with the ID 1661.*/
SELECT *
FROM city
WHERE id = 1661;

/*Japanese Cities' Attributes
Query all attributes of every Japanese city in the CITY table. The COUNTRYCODE for Japan is JPN.*/
SELECT *
FROM city
WHERE countrycode = 'JPN';

/*Japanese Cities' Names
Query the names of all the Japanese cities in the CITY table. The COUNTRYCODE for Japan is JPN. */
SELECT name
FROM city
WHERE countrycode = 'JPN';

/*
Weather Observation Station 1
Query a list of CITY and STATE from the STATION table. 
*/
SELECT
  city,
  state
FROM station;

/*
Weather Observation Station 3
Query a list of CITY names from STATION for cities that have an even ID number. Print the results in any order, but exclude duplicates from the answer. 
*/
SELECT
  DISTINCT(city)
FROM station
WHERE id % 2 = 0;

/*
Weather Observation Station 4
Find the difference between the total number of CITY entries in the table and the number of distinct CITY entries in the table. 
*/

SELECT
  COUNT(city) - COUNT(DISTINCT(city))
FROM station;

/*
Weather Observation Station 6
Query the list of CITY names starting with vowels (i.e., a, e, i, o, or u) from STATION. Your result cannot contain duplicates.
*/

SELECT city
FROM station
WHERE 
  LEFT(city, 1) IN ('a', 'e', 'i', 'o', 'u');

/*
Weather Observation Station 7
Query the list of CITY names ending with vowels (a, e, i, o, u) from STATION. Your result cannot contain duplicates.
*/
SELECT DISTINCT(city)
FROM station
WHERE 
  RIGHT(city, 1) in ('a','e','i','o','u');

/*
Weather Observation Station 8
Query the list of CITY names from STATION which have vowels (i.e., a, e, i, o, and u) as both their first and last characters. Your result cannot contain duplicates.
*/
SELECT DISTINCT(city)
FROM station
WHERE 
  RIGHT(city, 1) in ('a','e','i','o','u')
  AND
  LEFT(city, 1) in ('a','e','i','o','u');


/*
Weather Observation Station 9
Query the list of CITY names from STATION that do not start with vowels. Your result cannot contain duplicates.
*/
SELECT DISTINCT(city)
FROM station
WHERE 
  LEFT(city, 1) NOT IN('a','e','i','o','u');

/*
Weather Observation Station 10
Query the list of CITY names from STATION that do not end with vowels. Your result cannot contain duplicates.
*/
SELECT DISTINCT(city)
FROM station
WHERE 
  RIGHT(city, 1) NOT IN('a','e','i','o','u');


/*
Weather Observation Station 11
Query the list of CITY names from STATION that either do not start with vowels or do not end with vowels. Your result cannot contain duplicates.
*/
SELECT DISTINCT(city)
FROM station
WHERE 
  RIGHT(city, 1) NOT IN('a','e','i','o','u')
  OR
  LEFT(city, 1) NOT IN('a','e','i','o','u');

/*
Weather Observation Station 12
Query the list of CITY names from STATION that do not start with vowels and do not end with vowels. Your result cannot contain duplicates.
*/
SELECT DISTINCT(city)
FROM station
WHERE 
  RIGHT(city, 1) NOT IN('a','e','i','o','u')
  AND
  LEFT(city, 1) NOT IN('a','e','i','o','u');

/*
Higher Than 75 Marks
Query the Name of any student in STUDENTS who scored higher than  75 Marks. Order your output by the last three characters of each name. If two or more students both have names ending in the same last three characters (i.e.: Bobby, Robby, etc.), secondary sort them by ascending ID.
*/
SELECT name
FROM students
WHERE marks > 75
ORDER BY RIGHT(name, 3), id ASC; 

/*
Employee Names
Write a query that prints a list of employee names (i.e.: the name attribute) from the Employee table in alphabetical order.
*/
SELECT name
FROM employee
ORDER BY name;

/*
Employee Salaries
Write a query that prints a list of employee names (i.e.: the name attribute) for employees in Employee having a salary greater than $2000 per month who have been employees for less than 10 months. Sort your result by ascending employee_id.
*/
SELECT name
FROM employee
WHERE 
  salary > 2000
  AND
  months < 10
ORDER BY employee_id ASC;

/*
Type of Triangle
Write a query identifying the type of each record in the TRIANGLES table using its three side lengths. Output one of the following statements for each record in the table:
    Equilateral: It's a triangle with  sides of equal length.
    Isosceles: It's a triangle with  sides of equal length.
    Scalene: It's a triangle with  sides of differing lengths.
    Not A Triangle: The given values of A, B, and C don't form a triangle.

ORDER OF CASE WHEN MATTERS
*/
SELECT
  CASE
    WHEN (A+B<=C) OR (B+C<=A) OR (A+C<=B) THEN 'Not A Triangle'
    WHEN (a = b) AND (a = c) THEN 'Equilateral'
    WHEN (a = b) OR (a = c) OR (b = c) THEN 'Isosceles'
    WHEN A!=B AND B!=C AND C!=A THEN 'Scalene'
    ELSE 'ERROR'
END as triangle_type
FROM triangles;

/*
The PADS
Generate the following two result sets:
Query an alphabetically ordered list of all names in OCCUPATIONS, immediately followed by the first letter of each profession as a parenthetical (i.e.: enclosed in parentheses). For example: AnActorName(A), ADoctorName(D), AProfessorName(P), and ASingerName(S).
Query the number of ocurrences of each occupation in OCCUPATIONS. Sort the occurrences in ascending order, and output them in the following format: 
There are a total of [occupation_count] [occupation]s.
where [occupation_count] is the number of occurrences of an occupation in OCCUPATIONS and [occupation] is the lowercase occupation name. If more than one Occupation has the same [occupation_count], they should be ordered alphabetically.
Note: There will be at least two entries in the table for each type of occupation.
*/

SELECT 
    CONCAT( 
    name, '(' , LEFT(occupation, 1), ')'
    )
FROM occupations
ORDER BY name;

SELECT
  CONCAT('There are a total of ', COUNT(occupation), ' ' , lower(occupation), 's.')
FROM occupations
GROUP BY occupation
ORDER BY COUNT(occupation);

/*
Revising Aggregations - The Count Function
Query a count of the number of cities in CITY having a Population larger than 100,000 .
*/
SELECT COUNT(name)
FROM city
WHERE population > 100000; 

/*
Revising Aggregations  - The Sum Function
Query the total population of all cities in CITY where District is California.
*/
SELECT SUM(population)
FROM city
WHERE district = 'California'; 

/*
Revising Aggregations  -  Averages
Query the average population of all cities in CITY where District is California.
*/
SELECT AVG(population)
FROM city
WHERE district = 'California';

/*
Average Population
Query the average population for all cities in CITY, rounded down to the nearest integer.
*/
SELECT FLOOR(AVG(population))
FROM city;

/*
Japan Population
Query the sum of the populations for all Japanese cities in CITY. The COUNTRYCODE for Japan is JPN.
*/
SELECT SUM(population)
FROM city
WHERE countrycode = 'JPN';

/*
Population Density Difference
Query the difference between the maximum and minimum populations in CITY.
*/
SELECT MAX(population) - MIN(population)
FROM city;

/*
The Blunder - Not a fun question
Samantha was tasked with calculating the average monthly salaries for all employees in the EMPLOYEES table, but did not realize her keyboard's 0 key was broken until after completing the calculation. She wants your help finding the difference between her miscalculation (using salaries with any zeros removed), and the actual average salary.
Write a query calculating the amount of error (i.e.:  actual - miscalculated average monthly salaries), and round it up to the next integer.
*/
SELECT CEIL(AVG(salary) - AVG(REPLACE(salary, '0', '')))
FROM employees;


/*
Top Earners
We define an employee's total earnings to be their monthly salary x months worked, and the maximum total earnings to be the maximum total earnings for any employee in the Employee table. Write a query to find the maximum total earnings for all employees as well as the total number of employees who have maximum total earnings. Then print these values as  space-separated integers.
*/
SELECT
  (salary * months), count(employee_id)
FROM employee
GROUP BY (salary * months)
ORDER BY (salary * months) DESC
LIMIT 1
;

/*
Weather Observation Station 2
Query the following two values from the STATION table:
The sum of all values in LAT_N rounded to a scale of 2 decimal places.
The sum of all values in LONG_W rounded to a scale of 2 decimal places.
*/
SELECT
  ROUND(SUM(lat_n), 2),
  ROUND(SUM(long_w), 2)
FROM station;

/*
Weather Observation Station 13
Query the sum of Northern Latitudes (LAT_N) from STATION having values greater than 38.7880 and less than 137.2345. Truncate your answer to 4 decimal places.
*/
SELECT
  TRUNCATE(SUM(lat_n), 4)
FROM station
WHERE 
  lat_n BETWEEN 38.7880 AND 137.2345;

/*
Weather Observation Station 14
Query the greatest value of the Northern Latitudes (LAT_N) from STATION that is less than 137.2345 Truncate your answer to 4 decimal places.
*/
SELECT
  TRUNCATE(MAX(lat_n), 4)
FROM station
WHERE lat_n < 137.2345;

/*
Weather Observation Station 15
Query the Western Longitude (LONG_W) for the largest Northern Latitude (LAT_N) in STATION that is less than 137.2345. Round your answer to 4 decimal places.
*/
SELECT
  ROUND(long_w, 4)
FROM station
WHERE lat_n < 137.2345
ORDER BY lat_n DESC
LIMIT 1;

/*
Weather Observation Station 16
Query the smallest Northern Latitude (LAT_N) from STATION that is greater than 38.7780. Round your answer to 4 decimal places.
*/
SELECT
  ROUND(MIN(lat_n), 4)
FROM station
WHERE lat_n > 38.7880;

/*
Weather Observation Station 17
Query the Western Longitude (LONG_W)where the smallest Northern Latitude (LAT_N) in STATION is greater than . Round your answer to  decimal places.
*/
SELECT 
  ROUND(long_w, 4)
FROM station
WHERE lat_n  > 38.7880
ORDER BY lat_n
LIMIT 1; 




