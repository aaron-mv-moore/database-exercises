USE sakila;
DESCRIBE film;
DESCRIBE payment; 
SELECT * FROM payment LIMIT 1;
SELECT * FROM staff;

-- 1.a
SELECT * FROM sakila.`actor`;
-- 1.b
SELECT last_name FROM actor;
-- 1.c
SELECT film_id, title, release_year FROM film;

-- 2.a
SELECT DISTINCT last_name FROM actor;
-- 2.b
SELECT DISTINCT postal_code FROM address;
-- 2.c
SELECT DISTINCT rating FROM film;

-- 3.a
SELECT title, description, rating, length FROM film WHERE length >= 180;
-- 3.b
SELECT payment_id, amount, payment_date FROM payment WHERE payment_date >= '2005-05-27 00:00:00'; /* Is there a way to make this simpler with a wildcard?*/
-- 3.c
SELECT payment_id, amount, payment_date FROM payment WHERE payment_date LIKE "2005-05-27%";
-- 3.d
SELECT * FROM customer WHERE last_name LIKE "S%" AND first_name LIKE "%n";
-- 3.e
SELECT * FROM customer WHERE last_name LIKE "M%" AND active = 0;
-- 3.f
SELECT * FROM category WHERE category_id > 4 AND (name LIKE "C%" OR name LIKE "S%" OR name LIKE "T%");
-- 3.g
SELECT staff_id, `first_name`, `last_name`, `address_id`, `picture`, email, store_id, active, username, last_update FROM staff WHERE password IS NOT  NULL;
-- 3.H 
SELECT staff_id, `first_name`, `last_name`, `address_id`, `picture`, email, store_id, active, username, last_update FROM staff WHERE password IS NULL;

