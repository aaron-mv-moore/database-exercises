-- Show unique birth years from patients and order them by ascending.
SELECT
	distinct YEAR(birth_date) as birth_year
FROM patients
ORDER BY birth_year;

-- *** Show unique first names from the patients table which only occurs once in the list.
-- For example, if two or more people are named 'John' in the first_name column then don't include their name in the output list. If only 1 person is named 'Leo' then include them in the output.
SELECT first_name
FROM patients
group by first_name
	HAVING count(*) = 1;

-- Show patient_id and first_name from patients where their first_name start and ends with 's' and is at least 6 characters long
SELECT 
	patient_id,
    first_name
FROM patients
WHERE (first_name LIKE 'S%s')
	AND (length(first_name) >= 6);

SELECT  -- ***
	patient_id,
    first_name
FROM patients
WHERE first_name LIKE 's____%s;