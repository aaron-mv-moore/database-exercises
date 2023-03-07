-- SQL PRACTICE MEDIUM HOSPITAL DB

-- Show unique birth years from patients and order them by ascending.
SELECT
	DISTINCT YEAR(birth_date) AS birth_year
FROM patients
ORDER BY birth_year;

-- *** Show unique first names from the patients table which only occurs once in the list.
-- For example, if two or more people are named 'John' in the first_name column then don't include their name in the output list. If only 1 person is named 'Leo' then include them in the output.
SELECT first_name
FROM patients
GROUP BY first_name
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
WHERE first_name LIKE 's____%s';

-- Show patient_id, first_name, last_name from patients whos diagnosis is 'Dementia'. Primary diagnosis is stored in the admissions table.
SELECT 
	patient_id,
    first_name,
    last_name
FROM patients
	INNER JOIN admissions USING (patient_id)
WHERE diagnosis = 'Dementia'
;

-- Display every patient's first_name. Order the list by the length of each name and then by alphbetically
SELECT
	first_name
FROM patients
ORDER BY len(first_name), first_name;

-- Show the total amount of male patients and the total amount of female patients in the patients table. Display the two results in the same row.
SELECT 
	(SELECT count(*) FROM patients WHERE gender = 'F'), 
	(SELECT COUNT(*) FROM patients WHERE gender = 'M');

-- Show first and last name, allergies from patients which have allergies to either 'Penicillin' or 'Morphine'. Show results ordered ascending by allergies then by first_name then by last_name.
SELECT 
	first_name,
    last_name,
    allergies
FROM patients
WHERE 
	allergies = 'Penicillin'
    OR allergies = 'Morphine'
ORDER BY 
	allergies, 
    first_name, 
    last_name
;

-- Show patient_id, diagnosis from admissions. Find patients admitted multiple times for the same diagnosis.

SELECT
	patient_id,
    diagnosis
FROM admissions
GROUP BY patient_id, diagnosis
	HAVING count(*) > 1;

-- Show the city and the total number of patients in the city. Order from most to least patients and then by city name ascending.

SELECT
	city,
    count(*) AS cnt
FROM patients
GROUP BY
	city
ORDER BY
	cnt DESC,
    city ASC;

-- Show first name, last name and role of every person that is either patient or doctor. The roles are either "Patient" or "Doctor"
SELECT 
	first_name,
    last_name,
    'Patient' AS role
FROM patients
UNION ALL
SELECT 
	first_name,
    last_name,
    'Doctor'
FROM doctors;

-- Show all allergies ordered by popularity. Remove NULL values from query.
SELECT allergies, count(*) AS cnt
FROM patients
WHERE allergies IS NOT NULL
GROUP BY allergies
ORDER BY cnt DESC;

-- Show all patient's first_name, last_name, and birth_date who were born in the 1970s decade. Sort the list starting from the earliest birth_date.
SELECT
	first_name,
    last_name,
    birth_date
FROM patients
WHERE birth_date LIKE '%197%'
ORDER BY birth_date ASC;

-- We want to display each patient's full name in a single column. Their last_name in all upper letters must appear first, then first_name in all lower case letters. Separate the last_name and first_name with a comma. Order the list by the first_name in decending order EX: SMITH,jane
SELECT 
	Concat(
      UPPER(last_name),
      ',',
      LOWER(first_name)) AS full_name
FROM patients
ORDER BY first_name DESC;

-- Show the province_id(s), sum of height; where the total sum of its patient's height is greater than or equal to 7,000.
SELECT
	province_id,
    SUM(height) AS tot_height
FROM patients
GROUP BY province_id
	HAVING tot_height >= 7000;

-- Show the difference between the largest weight and smallest weight for patients with the last name 'Maroni'
SELECT
	MAX(weight)
     -
     Min(weight)
FROM patients
WHERE last_name = 'Maroni';

-- Show all of the days of the month (1-31) and how many admission_dates occurred on that day. Sort by the day with most admissions to least admissions
SELECT
	DAY(admission_date),
    count(*) AS cnt
FROM admissions
GROUP BY DAY(admission_date)
ORDER BY cnt DESC;

-- Show all columns for patient_id 542's most recent admission_date.
SELECT *
FROM admissions
WHERE patient_id = 542
GROUP BY patient_id
HAVING
  admission_date = MAX(admission_date);

-- OR

SELECT *
FROM admissions
WHERE patient_id = 542
ORDER BY admission_date DESC
LIMIT 1;

-- Show patient_id, attending_doctor_id, and diagnosis for admissions that match one of the two criteria:
-- 1. patient_id IS an odd number AND attending_doctor_id IS either 1, 5, OR 19.
-- 2. attending_doctor_id CONTAINS a 2 AND the length of patient_id IS 3 characters.
SELECT
	patient_id,
    attending_doctor_id,
    diagnosis
FROM admissions
WHERE 
	((patient_id % 2 = 1) AND (attending_doctor_id IN (1, 5, 19)))
    OR
    ((attending_doctor_id LIKE '%2%') AND (LEN(patient_id) = 3));

-- Show first_name, last_name, and the total number of admissions attended for each doctor. Every admission has been attended by a doctor.
SELECT
	d.first_name,
    d.last_name,
    count(admission_date)
FROM admissions a
	INNER JOIN doctors d ON a.attending_doctor_id = d.doctor_id
GROUP BY doctor_id;

-- For each doctor, display their id, full name, and the first and last admission date they attended.
SELECT
	doctor_id,
    concat(
      first_name,
      ' ',
      last_name) AS full_name,
      min(admission_date) AS first_admission,
      Max(admission_date) AS last_admission
FROM doctors d
	INNER JOIN admissions a ON d.doctor_id = a.attending_doctor_id
GROUP BY doctor_id
;

-- OR

SELECT
  doctor_id,
  first_name || ' ' || last_name AS full_name,
  min(admission_date) AS first_admission_date,
  max(admission_date) AS last_admission_date
FROM admissions a
  JOIN doctors ph ON a.attending_doctor_id = ph.doctor_id
GROUP BY doctor_id;

-- Display the total amount of patients for each province. Order by descending.
SELECT
	province_name,
    COUNT(patient_id) AS cnt
FROM patients p
	INNER JOIN province_names pn ON p.province_id = pn.province_id
GROUP BY province_name
ORDER BY cnt DESC
;

-- For every admission, display the patient's full name, their admission diagnosis, and their doctor's full name who diagnosed their problem.
SELECT 
	concat(
      p.first_name,
      ' ',
      p.last_name) AS patient_name,
      a.diagnosis,
      concat(
        d.first_name,
        ' ',
        d.last_name) AS doctor_name
FROM patients p 
	JOIN admissions a USING (patient_id)
    JOIN doctors d ON a.attending_doctor_id = d.doctor_id
;

-- display the number of duplicate patients based on their first_name and last_name.
SELECT 
	first_name,
    last_name,
    count(*)
FROM patients
GROUP BY first_name, last_name
	HAVING count(*) > 1;

-- Display patient's full name, height IN the units feet rounded TO 1 DECIMAL, weight IN the unit pounds rounded TO 0 decimals, birth_date, gender non abbreviated.
SELECT 
	CONCAT(
      first_name,
      ' ',
      last_name) AS FULL_NAME,
      round(height/30.48, 1) AS height_feet,
      round(weight*2.205, 0) AS weight_cm,
      birth_date,
      CASE
      	WHEN gender = 'F' THEN 'Female'
        WHEN gender = 'M' THEN 'Male'
        ELSE gender
      END AS gender
FROM patients;


-- SQL PRACTICE MEDOOUM NORTHWIND DB

-- Show the ProductName, CompanyName, CategoryName from the products, suppliers, and categories table
SELECT
  p.product_name,
  s.company_name,
  c.category_name
FROM products p
  JOIN suppliers s ON p.supplier_id = s.supplier_id
  JOIN categories c ON p.category_id = c.category_id;

-- Show the category_name and the average product unit price for each category rounded to 2 decimal places.
SELECT
  category_name,
  Round(AVG(unit_price), 2) AS avg_unit_price
FROM categories c 
  JOIN products p ON c.category_id = p.category_id
GROUP BY c.category_name;

-- Show the city, company_name, contact_name from the customers and suppliers table merged together.
-- CREATE a COLUMN which CONTAINS 'customers' OR 'suppliers' depending ON the TABLE it came from.

SELECT
  city,
  company_name,
  contact_name, 
  'customers' table_origin
FROM customers
UNION
SELECT
  city,
  company_name,
  contact_name, 
  'suppliers' table_origin
FROM suppliers;

