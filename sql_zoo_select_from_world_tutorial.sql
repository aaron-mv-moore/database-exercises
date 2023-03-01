
-- Observe the result of running this SQL command TO SHOW the NAME, continent AND population of ALL countries.
SELECT world.name, continent, population FROM world;

-- Show the name for the countries that have a population of at least 200 million. 200 million is 200000000, there are eight zeros.
SELECT world.name FROM world
WHERE population = 64105700;

-- Give the name and the per capita GDP for those countries with a population of at least 200 million.
-- HELP:How TO calculate per capita GDP per capita GDP IS the GDP divided BY the population GDP/population
SELECT NAME, gdp/population AS per_capita_gdp
FROM world
WHERE population >= 200000000;

-- Show the name and population in millions for the countries of the continent 'South America'. Divide the population by 1000000 to get population in millions.
SELECT NAME, population / 1000000
FROM world
WHERE continent = 'South America';

-- SHOW the NAME AND population FOR France, Germany, Italy
SELECT NAME, population
FROM world
WHERE NAME IN ('France', 'Germany', 'Italy');

-- Show the countries which have a name that includes the word 'United'
SELECT NAME
FROM world
WHERE NAME LIKE '%United%';

-- Two ways to be big: A country is big if it has an area of more than 3 million sq km or it has a population of more than 250 million.
-- SHOW the countries that are big BY area OR big BY population. SHOW NAME, population AND area.
SELECT NAME, population, area
FROM world
WHERE population > 250000000
OR area > 3000000;

-- Exclusive OR (XOR). Show the countries that are big by area (more than 3 million) or big by population (more than 250 million) but not both. Show name, population and area.
SELECT NAME, population, area
FROM world
WHERE (population > 250000000 AND area <= 3000000) OR   (population <= 250000000 AND area > 3000000);

-- Show the name and population in millions and the GDP in billions for the countries of the continent 'South America'. Use the ROUND function to show the values to two decimal places.
-- FOR South America SHOW population IN millions AND GDP IN billions BOTH TO 2 DECIMAL places.
SELECT NAME, ROUND(population / 1000000, 2), ROUND(gdp/1000000000, 2)
FROM world
WHERE continent = 'South America';

-- Show the name and per-capita GDP for those countries with a GDP of at least one trillion (1000000000000; that is 12 zeros). Round this value to the nearest 1000.
-- SHOW per-capita GDP FOR the trillion dollar countries TO the nearest $1000.
SELECT NAME, round(gdp/population, -3)
FROM world
WHERE gdp >= 1000000000000;

-- SHOW the NAME AND capital WHERE the NAME AND the capital have the same number of characters.
-- FOR Microsoft SQL SERVER the FUNCTION LENGTH IS LEN
SELECT NAME, capital
  FROM world
 WHERE LEN(NAME) = LEN(capital);

-- Show the name and the capital where the first letters of each match. Don't include countries where the name and the capital are the same word.
SELECT NAME, capital
FROM world
WHERE LEFT(NAME, 1) = LEFT(capital, 1) AND NAME <> capital;

-- Equatorial Guinea and Dominican Republic have all of the vowels (a e i o u) in the name. They don't count because they have more than one word in the name. Find the country that has all the vowels and no spaces in its name
SELECT NAME
   FROM world
WHERE (NAME LIKE '%a%' AND NAME LIKE '%e%' AND NAME LIKE '%i%' AND NAME LIKE '%o%'  AND NAME LIKE '%u%')
  AND NAME NOT LIKE '% %';