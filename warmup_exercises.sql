-- 2023-02-21
-- Using the customer, address, city, and country table in the sakila db
-- find all customers that live in Poland.
-- Output two columns titled: full_name, email

USE sakila;

SELECT *
FROM country;

SELECT *
FROM customer;

SELECT * 
FROM address;

SELECT *
FROM city;

SELECT 
	CONCAT(first_name, ' ', last_name) AS full_name,
	email
FROM city
	JOIN country USING (country_id)
	JOIN address USING (city_id)
	JOIN customer USING (address_id)
WHERE country = 'Poland';


-- Using the customer and payment table from sakila database,
-- find the first and last names of the top five
-- customers that spend the most money
-- ******in their lifetime 
USE sakila;

# messy round one
SELECT c2.first_name, c2.last_name, t.total
FROM (SELECT  customer_id, sum(amount) AS total
FROM payment p
GROUP BY customer_id
ORDER BY total DESC
LIMIT 5) AS t INNER JOIN customer c2
	USING (customer_id);

# more succint round two
SELECT first_name, last_name, sum(amount) AS total
FROM customer INNER JOIN payment
	USING (customer_id)
GROUP BY first_name, last_name 
ORDER BY total DESC
LIMIT 5;
