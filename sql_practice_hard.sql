-- SQL PRACTICE HARD HOSPITAL DB

-- Show all of the patients grouped into weight groups. Show the total amount of patients in each weight group. Order the LIST BY the weight group decending.
-- FOR example, IF they weight 100 TO 109 they are placed IN the 100 weight group, 110-119 = 110 weight group, etc.
SELECT 
	count(*),
    Floor(weight / 10) * 10 AS weight_group
FROM patients
GROUP BY weight_group
ORDER BY weight_group DESC;

-- Show patient_id, weight, height, isObese from the patients table. Display isObese AS a BOOLEAN 0 OR 1. Obese IS defined AS weight(kg)/(height(m)2) >= 30. weight IS IN units kg. height IS IN units cm.
SELECT
	patient_id,
    weight,
    height,
    CASE
    WHEN (weight/power((height/100.0), 2)) >= 30 THEN TRUE
    ELSE FALSE
    END AS isObese
FROM patients;

-- Show patient_id, first_name, last_name, and attending doctor's specialty. Show only the patients who has a diagnosis as 'Epilepsy' and the doctor's first name is 'Lisa'. CHECK patients, admissions, AND doctors TABLES FOR required information.
SELECT
	p.patient_id, p.first_name, p.last_name, d.specialty
FROM patients p
	JOIN admissions a USING (patient_id)
    JOIN doctors d ON a.attending_doctor_id = d.doctor_id
WHERE a.diagnosis = 'Epilepsy'
	AND d.first_name = 'Lisa'
;

-- All patients who have gone through admissions, can see their medical documents on our site. Those patients are given a temporary password after their first admission. Show the patient_id and temp_password. 
-- The PASSWORD must be the following, IN order:
-- 1. patient_id
-- 2. the numerical length of patient's last_name
-- 3. YEAR of patient's birth_date
SELECT 
	patient_id,
    CONCAT(
    	patient_id,
      len(last_name),
      YEAR(birth_date)
    ) AS temp_password
FROM patients p 
	JOIN admissions a USING(patient_id)
GROUP BY a.patient_id
	HAVING count(admission_date) >= 1;



-- Each admission costs $50 for patients without insurance, and $10 for patients with insurance. All patients with an even patient_id have insurance. Give each patient a 'Yes' if they have insurance, and a 'No' if they don't have insurance. Add up the admission_total cost for each has_insurance group.

SELECT
  (CASE
    WHEN patient_id % 2 = 0 THEN 
    'Yes'
    ELSE
    'No'
  END) AS has_insurance, 
  sum(sq.admission_total)
FROM (SELECT
	patient_id,
	(CASE
       WHEN patient_id % 2 = 0 THEN
       10
       ELSE
       50
     END) AS admission_total
FROM admissions) AS sq
GROUP BY has_insurance;
-- or 
SELECT
CASE
    WHEN patient_id % 2 = 0 THEN 
    'Yes'
    ELSE
    'No'
END AS has_insurance, 
sum(CASE
       WHEN patient_id % 2 = 0 THEN
       10
       ELSE
       50
     END) AS admission_total
FROM admissions
GROUP BY has_insurance;

-- Show the provinces that has more patients identified as 'M' than 'F'. Must only show full province_name

SELECT province_name
FROM patients
	JOIN province_names USING (province_id)
GROUP BY province_name
	HAVING count(CASE WHEN gender='M' THEN 1 END) > Count(CASE WHEN gender='F' THEN 1 END);

-- We are looking for a specific patient. Pull all columns for the patient who matches the following criteria:
-- First_name contains an 'r' after the first two letters.
-- Identifies their gender AS 'F'
-- Born IN February, May, OR December
-- Their weight would be BETWEEN 60kg AND 80kg
-- Their patient_id IS an odd number
-- They are FROM the city 'Kingston'
SELECT *
FROM patients
WHERE (first_name LIKE '__r%')
	AND (gender = 'F')
    AND (MONTH(birth_date) IN (2, 5, 12))
    AND (weight BETWEEN 60 AND 80)
    AND (patient_id % 2 != 0)
    AND (city = 'Kingston');

-- For each day display the total amount of admissions on that day. Display the amount changed from the previous date.
SELECT 
admission_date, count(admission_date), count(admission_date) - LAG(tm.cnt, 1) OVER() AS CHANGE
FROM admissions
JOIN (SELECT admission_date, count(admission_date) AS cnt FROM admissions GROUP BY admission_date) AS tm 
USING (admission_date)
GROUP BY admission_date;

-- Sort the province names in ascending order in such a way that the province 'Ontario' is always on top.
SELECT province_name
FROM province_names
GROUP BY province_name
ORDER BY (CASE WHEN province_name = 'Ontario' THEN 0 ELSE 1 END), province_name
;


-- SQL PRACTICE HARD NORTHWIND DB

-- Show the employee's first_name and last_name, a "num_orders" column with a count of the orders taken, and a column called "Shipped" that displays "On Time" if the order shipped on time and "Late" if the order shipped late. 
-- ORDER BY employee last_name, THEN BY first_name, AND THEN descending BY number of orders.

SELECT 
  first_name,
  last_name,
  count(order_id) as num_orders,
  CASE
    WHEN shipped_date < required_date THEN 'On Time'
    ELSE 'Late'
    END as shipped
FROM employees e 
  JOIN orders o ON e.employee_id = o.employee_id
GROUP BY
  e.employee_id,
  shipped
ORDER BY last_name, first_name, num_orders DESC;