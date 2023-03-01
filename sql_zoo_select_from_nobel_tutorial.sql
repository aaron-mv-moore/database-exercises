-- SELECT FROM nobel tutorial from sqlzoo.net
-- Show who won the 1962 prize for literature.
SELECT winner
  FROM nobel
 WHERE yr = 1962
   AND SUBJECT = 'Literature';

-- Show the year and subject that won 'Albert Einstein' his prize.
SELECT yr, SUBJECT
FROM nobel
WHERE winner = 'Albert Einstein';

-- Give the name of the 'peace' winners since the year 2000, including 2000.
SELECT winner
FROM nobel
WHERE SUBJECT = 'peace' AND yr >= 2000;

-- Show all details (yr, subject, winner) of the literature prize winners for 1980 to 1989 inclusive.
SELECT *
FROM nobel
WHERE SUBJECT = 'Literature' 
AND yr BETWEEN 1980 AND 1989;

-- Show all details of the presidential winners:
-- Theodore Roosevelt
-- Thomas Woodrow Wilson
-- Jimmy Carter
-- Barack Obama

SELECT * 
FROM nobel
WHERE winner IN ('Theodore Roosevelt', 'Woodrow Wilson', 'Jimmy Carter', 'Barack Obama');

-- Show the winners with first name John
SELECT winner
FROM nobel
WHERE winner LIKE 'John %';

-- Show the year, subject, and name of physics winners for 1980 together with the chemistry winners for 1984.
SELECT yr, SUBJECT, winner
FROM nobel
WHERE (SUBJECT = 'Chemistry' AND yr = 1984) OR (SUBJECT = 'Physics' AND yr = 1980);

-- Show the year, subject, and name of winners for 1980 excluding chemistry and medicine
SELECT yr, SUBJECT, winner
FROM nobel
WHERE yr = 1980 AND NOT SUBJECT IN ('Chemistry', 'Medicine');

-- Show year, subject, and name of people who won a 'Medicine' prize in an early year (before 1910, not including 1910) together with winners of a 'Literature' prize in a later year (after 2004, including 2004)
SELECT yr, SUBJECT, winner
FROM nobel
WHERE (SUBJECT = 'Medicine' AND yr < 1910) 
              OR (SUBJECT = 'Literature' AND yr >= 2004);

-- Find all details of the prize won by PETER GRÜNBERG
SELECT *
FROM nobel
WHERE winner LIKE '%Gr_nberg';

-- Find all details of the prize won by EUGENE O'NEILL
SELECT *
FROM nobel
WHERE winner = 'Eugene O''Neill';

-- Knights in order
-- LIST the winners, YEAR AND SUBJECT WHERE the winner STARTS WITH Sir. SHOW the the most recent FIRST, THEN BY NAME order.
SELECT winner, yr, SUBJECT
FROM nobel
WHERE winner LIKE 'Sir %'
ORDER BY yr DESC, winner;

-- The expression subject IN ('chemistry','physics') can be used as a value - it will be 0 or 1.
-- SHOW the 1984 winners AND SUBJECT ordered BY SUBJECT AND winner NAME; but LIST chemistry AND physics last.
SELECT winner, SUBJECT
FROM nobel
WHERE yr=1984
ORDER BY
CASE WHEN SUBJECT IN ('Chemistry', 'Physics') THEN 1 ELSE 0 END, SUBJECT , winner;