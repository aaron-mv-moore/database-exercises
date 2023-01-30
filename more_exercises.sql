-- More Drills With The Sakila Database
USE sakila;
DESCRIBE film;
DESCRIBE payment; 
SELECT * FROM payment LIMIT 1;
SELECT * FROM staff;

-- 1.a Select all columns from the actor table.
SELECT * 
FROM sakila.`actor`;
-- 1.b Select only the last_name column from the actor table
SELECT last_name 
FROM actor;
-- 1.c Select only the film_id, title, and release_year columns from the film table.
SELECT film_id, title, release_year 
FROM film;

-- 2.a Select all distinct (different) last names from the actor table.
SELECT DISTINCT last_name 
FROM actor;
-- 2.b Select all distinct (different) postal codes from the address table.
SELECT DISTINCT postal_code 
FROM address;
-- 2.c Select all distinct (different) ratings from the film table.
SELECT DISTINCT rating 
FROM film;

-- 3.a Select the title, description, rating, movie length columns from the films table that last 3 hours or longer.
SELECT title, description, rating, length 
FROM film 
WHERE length >= 180;
-- 3.b Select the payment id, amount, and payment date columns from the payments table for payments made on or after 05/27/2005.
SELECT payment_id, amount, payment_date 
FROM payment 
WHERE payment_date >= '2005-05-27 00:00:00'; /* Is there a way to make this simpler with a wildcard?*/
-- 3.c Select the primary key, amount, and payment date columns from the payment table for payments made on 05/27/2005.
SELECT payment_id, amount, payment_date 
FROM payment 
WHERE payment_date LIKE "2005-05-27%";
-- 3.d Select all columns from the customer table for rows that have a last names beginning with S and a first names ending with N.
SELECT * 
FROM customer 
WHERE last_name LIKE "S%" 
	AND first_name LIKE "%n";
-- 3.e Select all columns from the customer table for rows where the customer is inactive or has a last name beginning with "M".
SELECT * 
FROM customer 
WHERE last_name LIKE "M%" 
	AND active = 0;
-- 3.f Select all columns from the category table for rows where the primary key is greater than 4 and the name field begins with either C, S or T.
SELECT * 
FROM category 
WHERE category_id > 4 
	AND (name LIKE "C%" OR name LIKE "S%" OR name LIKE "T%");
-- 3.g Select all columns minus the password column from the staff table for rows that contain a password.
SELECT staff_id, `first_name`, `last_name`, `address_id`, `picture`, email, store_id, active, username, last_update 
FROM staff 
WHERE password IS NOT  NULL;
-- 3.h Select all columns minus the password column from the staff table for rows that do not contain a password. 
SELECT staff_id, `first_name`, `last_name`, `address_id`, `picture`, email, store_id, active, username, last_update 
FROM staff 
WHERE password IS NULL;

-- 4.a [IN] Select the phone and district columns from the address table for addresses in California, England, Taipei, or West Java.
SELECT phone, district 
FROM address 
WHERE district IN ('California', 'Taipei', 'England', 'West Java');
-- 4.b Select the payment id, amount, and payment date columns from the payment table for payments made on 05/25/2005, 05/27/2005, and 05/29/2005. (Use the IN operator and the DATE function, instead of the AND operator as in previous exercises.)
SELECT payment_id, amount, payment_date 
FROM payment 
WHERE DATE(payment_date) IN ('2005-05-25', '2005-05-27', '2005-05-29');
-- 4.c Select all columns from the film table for films rated G, PG-13 or NC-17.
SELECT * 
FROM film 
WHERE rating IN ('G', 'PG-13', 'NC-17');

-- 5.a Select all columns from the payment table for payments made between midnight 05/25/2005 and 1 second before midnight 05/26/2005.
SELECT * 
FROM `payment` 
WHERE payment_date BETWEEN '2005-05-25 00:00:00' AND '2005-05-25 23:59:59';
-- 5.b Select the film_id, title, and descrition columns from the film table for films where the length of the description is between 100 and 120.
SELECT film_id, title, description 
FROM film 
WHERE LENGTH(description) BETWEEN 100 AND 120;

-- 6.a Select the following columns from the film table for rows where the description begins with "A Thoughtful".
SELECT *
FROM film
WHERE description LIKE "A Thoughtful%";
-- 6.b Select the following columns from the film table for rows where the description ends with the word "Boat".
SELECT *
FROM film
WHERE description LIKE '%boat';
-- 6.c Select the following columns from the film table where the description contains the word "Database" and the length of the film is greater than 3 hours.
SELECT *
FROM film
WHERE description LIKE '%database%' 
	AND length > 180;

-- 7.a Select all columns from the payment table and only include the first 20 rows.
SELECT *
FROM payment
	LIMIT 20;
-- 7.b Select the payment date and amount columns from the payment table for rows where the payment amount is greater than 5, and only select rows whose zero-based index in the result set is between 1000-2000
SELECT payment_date, amount
FROM payment
WHERE amount > 5
LIMIT 1001 OFFSET 999;
-- 7.c Select all columns from the customer table, limiting results to those where the zero-based index is between 101-200.
SELECT *
FROM `customer`
LIMIT 100 OFFSET 100;
