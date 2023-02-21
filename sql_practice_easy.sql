-- Show first name and last name of patients who does not have allergies. (null)
SELECT 
    first_name, 
    last_name 
FROM patients 
WHERE allergies IS NULL;

-- Show first name of patients that start with the letter 'C'
Select 
	first_name
FROM patients 
WHERE first_name LIKE 'C%';

-- Show first name and last name of patients that weight within the range of 100 to 120 (inclusive)
Select 
	first_name,
    last_name
FROM patients 
WHERE weight between 100 AND 120;

-- Update allergies to NKA where allergies is NULL
update patients
SET allergies = 'NKA'
WHERE allergies IS NULL;

-- Show first name and last name concatinated into one column to show their full name.
SELECT 
	CONCAT(first_name, ' ', last_name) AS full_name
FROM patients;

-- Show first name, last name, and the full province name of each patient.
-- Example: 'Ontario' instead of 'ON
SELECT
	first_name, 
    last_name, 
    province_name
FROM patients 
	INNER JOIN province_names USING (province_id);

-- Show how many patients have a birth_date with 2010 as the birth year.
SELECT
	count(*) AS total_patients
FROM patients
WHERE year(birth_date) = 2010;

-- Show the first_name, last_name, and height of the patient with the greatest height.
SELECT 
	first_name,
    last_name,
    max(height)
FROM patients;

-- Show all columns for patients who have one of the following patient_ids: 1,45,534,879,1000
SELECT *
FROM patients
WHERe patient_id in (1, 45, 534, 879, 1000);

-- Show the total amount of admissions
SELECT count(*)
FROM admissions;

-- Show all the columns from admissions where the patient was admitted and discharged on the same day.
SELECT *
FROM admissions
WHERE admission_date = discharge_date;

-- Show the patient id and the total number of admissions for patient_id 579.
SELECT patient_id, count(admission_date)
FROM admissions
WHERE patient_id = 579;

-- Based on the cities that our patients live in, show unique cities that are in province_id 'NS'?
SELECT 
	DISTINCT city
FROM patients
where province_id = 'NS';

-- Write a query to find the first_name, last name and birth date of patients who have height more than 160 and weight more than 70
SELECT 
	first_name,
    last_name,
    birth_date
FROM patients
WHERE 
	height > 160 AND weight > 70;

-- Write a query to find list of patients first_name, last_name, and allergies from Hamilton where allergies are not null
SELECT
	first_name,
    last_name,
    allergies
FROM patients
WHERE 
	city = 'Hamilton' 
    and allergies is NOT NULL;

 -- Based on cities where our patient lives in, write a query to display the list of unique city starting with a vowel (a, e, i, o, u). Show the result order in ascending by city.
SELECT distinct city
FROM patients
WHERE 
	city like 'A%'
    OR city like 'E%'
    OR city like 'I%'
    OR city like 'O%'
    OR city like 'U%'
ORDER BY city;   