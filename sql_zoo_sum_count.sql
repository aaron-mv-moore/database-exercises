-- SUM and COUNT sqlzoo

-- Show the total population of the world
SELECT SUM(population)
FROM world;

-- List all the continents - just once each.
SELECT DISTINCT continent
FROM world;

-- Give the total GDP of Africa
SELECT sum(gdp)
FROM world
WHERE continent = 'Africa'
GROUP BY continent;

-- How many countries have an area of at least 1000000
SELECT count(*)
FROM world
WHERE area >= 1000000;

-- 5. What IS the total population of ('Estonia', 'Latvia', 'Lithuania')
SELECT sum(population)
FROM world
WHERE NAME IN ('Estonia', 'Latvia', 'Lithuania');

-- For each continent show the continent and number of countries.
SELECT continent, count(NAME)
FROM world
GROUP BY continent;

-- For each continent show the continent and number of countries with populations of at least 10 million.
SELECT continent, count(NAME)
FROM world
WHERE population >= 10000000
GROUP BY continent;

-- List the continents that have a total population of at least 100 million.
SELECT continent
FROM world
GROUP BY continent
HAVING sum(population) >= 100000000;
