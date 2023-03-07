-- SQL PRACTICE EASY - HOSPITAL DB
-- Show first name and last name of patients who does not have allergies. (null)
SELECT 
    first_name, 
    last_name 
FROM patients 
WHERE allergies IS NULL;

-- Show first name of patients that start with the letter 'C'
SELECT 
	first_name
FROM patients 
WHERE first_name LIKE 'C%';

-- Show first name and last name of patients that weight within the range of 100 to 120 (inclusive)
SELECT 
	first_name,
    last_name
FROM patients 
WHERE weight BETWEEN 100 AND 120;

-- Update allergies to NKA where allergies is NULL
UPDATE patients
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
WHERE YEAR(birth_date) = 2010;

-- Show the first_name, last_name, and height of the patient with the greatest height.
SELECT 
	first_name,
    last_name,
    max(height)
FROM patients;

-- Show all columns for patients who have one of the following patient_ids: 1,45,534,879,1000
SELECT *
FROM patients
WHERE patient_id IN (1, 45, 534, 879, 1000);

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
WHERE province_id = 'NS';

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
    AND allergies IS NOT NULL;

 -- Based on cities where our patient lives in, write a query to display the list of unique city starting with a vowel (a, e, i, o, u). Show the result order in ascending by city.
SELECT DISTINCT city
FROM patients
WHERE 
	city LIKE 'A%'
    OR city LIKE 'E%'
    OR city LIKE 'I%'
    OR city LIKE 'O%'
    OR city LIKE 'U%'
ORDER BY city;   

-- SQL PRACTICE EASY - NORTHWIND DB

-- Show the category_name and description from the categories table sorted by category_name.
SELECT
  category_name,
  description
FROM categories
ORDER BY category_name;

-- Show all the contact_name, address, city of all customers which are not from 'Germany', 'Mexico', 'Spain'

SELECT
	contact_name,
    address,
    city
FROM customers
WHERE country NOT IN ('Germany', 'Mexico', 'Spain');

-- Show order_date, shipped_date, customer_id, Freight of all orders placed on 2018 Feb 26
SELECT
 order_date,
 shipped_date,
 customer_id,
 freight
FROM orders
WHERE 
 order_date = '2018-02-26';

-- Show the employee_id, order_id, customer_id, required_date, shipped_date from all orders shipped later than the required date

SELECT
  employee_id,
  order_id,
  customer_id,
  required_date,
  shipped_date
FROM orders
WHERE shipped_date > required_date;

-- Even order_ids

SELECT
  order_id
FROM orders
WHERE order_id % 2 = 0;

-- SHOW the city, company_name, contact_name of ALL customers FROM cities which CONTAINS the letter 'L' IN the city NAME, sorted BY contact_name

SELECT
  city,
  company_name,
  contact_name
FROM customers
WHERE city LIKE '%L%'
ORDER BY contact_name;

-- Show the company_name, contact_name, fax number of all customers that has a fax number. (not null)
SELECT 
  company_name,
  contact_name,
  fax
FROM customers
WHERE fax IS NOT NULL;

-- Show the first_name, last_name of the most recently hired employee.
SELECT 
  first_name,
  last_name,
  max(hire_date)
FROM employees;

-- Show the average unit price rounded to 2 decimal places, the total units in stock, total discontinued products from the products table.
SELECT
  round(avg(unit_price), 2) as avg_unit_price,
  sum(units_in_stock) as total_units_in_stock,
  sum(discontinued) as total_distcontinued
FROM products;