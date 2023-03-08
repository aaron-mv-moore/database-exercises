-- HACKER RANK SQL MEDIUM

/* Ketty gives Eve a task to generate a report containing three columns: Name, Grade and Mark. Ketty doesn't want the NAMES of those students who received a grade lower than 8. The report must be in descending order by grade -- i.e. higher grades are entered first. If there is more than one student with the same grade (8-10) assigned to them, order those particular students by their name alphabetically. Finally, if the grade is lower than 8, use "NULL" as their name and list them by their grades in descending order. If there is more than one student with the same grade (1-7) assigned to them, order those particular students by their marks in ascending order.
Write a query to help Eve. */

(SELECT 
    NAME, 
    grade, 
    marks
FROM students
JOIN grades ON marks BETWEEN min_mark AND max_mark
WHERE grade > 7)
UNION
SELECT 
    NULL NAME,
    grade,
    marks
FROM students
JOIN grades ON marks BETWEEN min_mark AND max_mark
WHERE grade < 8
ORDER BY grade DESC, CASE WHEN grade > 7 THEN NAME ELSE marks END ;

-- Julia just finished conducting a coding contest, and she needs your help assembling the leaderboard! Write a query to print the respective hacker_id and name of hackers who achieved full scores for more than one challenge. Order your output in descending order by the total number of challenges in which the hacker earned a full score. If more than one hacker received full scores in same number of challenges, then sort them by ascending hacker_id.
SELECT 
    h.hacker_id,
    name
FROM submissions s
    JOIN challenges c USING (challenge_id)
    JOIN difficulty d USING (difficulty_level)
    JOIN hackers h on s.hacker_id = h.hacker_id
WHERE s.score = d.score and c.difficulty_level = d.difficulty_level
GROUP BY h.hacker_id, name
    HAVING count(s.hacker_id) > 1
ORDER BY count(s.hacker_id) DESC, s.hacker_id;