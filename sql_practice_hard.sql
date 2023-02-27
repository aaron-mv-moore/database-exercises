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

