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

-- 8.a Select all columns from the film table and order rows by the length field in ascending order.
SELECT *
FROM film 
ORDER BY length ASC;
-- 8.b Select all distinct ratings from the film table ordered by rating in descending order.
SELECT DISTINCT rating
FROM film
ORDER BY rating DESC;
-- 8.c Select the payment date and amount columns from the payment table for the first 20 payments ordered by payment amount in descending order.
SELECT payment_date, amount 
FROM payment
ORDER BY amount DESC
LIMIT 20;
-- 8.d Select the title, description, special features, length, and rental duration columns from the film table for the first 10 films with behind the scenes footage under 2 hours in length and a rental duration between 5 and 7 days, ordered by length in descending order.
SELECT title, description, special_features, length, rental_duration
FROM film
WHERE (special_features LIKE '%behind%') 
	AND (length < 120)
	AND (rental_duration BETWEEN 5 AND 7)
ORDER BY length DESC
LIMIT 10;

-- 9.a Select customer first_name/last_name and actor first_name/last_name columns from performing a left join between the customer and actor column on the last_name column in each table. (i.e. customer.last_name = actor.last_name)
SELECT 
	c.first_name AS customer_first_name, 
	c.last_name AS customer_last_name, 
	a.first_name AS actor_first_name, 
	a.last_name AS actor_last_name
FROM customer c
LEFT JOIN actor a
	ON c.last_name = a.last_name;
-- 9.b Select the customer first_name/last_name and actor first_name/last_name columns from performing a /right join between the customer and actor column on the last_name column in each table. (i.e. customer.last_name = actor.last_name)
SELECT 
	c.first_name AS customer_first_name, 
	c.last_name AS customer_last_name, 
	a.first_name AS actor_first_name, 
	a.last_name AS actor_last_name
FROM customer c
RIGHT JOIN actor a
	ON c.last_name = a.last_name;
-- 9.c Select the customer first_name/last_name and actor first_name/last_name columns from performing an inner join between the customer and actor column on the last_name column in each table. (i.e. customer.last_name = actor.last_name)
SELECT 
	c.first_name AS customer_first_name, 
	c.last_name AS customer_last_name, 
	a.first_name AS actor_first_name, 
	a.last_name AS actor_last_name
FROM customer c
JOIN actor a
	ON c.last_name = a.last_name;
-- 9.d Select the city name and country name columns from the city table, performing a left join with the country table to get the country name column.
SELECT city,
	country
FROM city LEFT JOIN country 
	ON city.country_id = country.country_id;
-- 9.e Select the title, description, release year, and language name columns from the film table, performing a left join with the language table to get the "language" column.
DESC film;
DESC language;
SELECT title,
	description,
	release_year,
	l.name	AS language
FROM film f LEFT JOIN language l
	ON f.language_id = l.language_id;
-- 9.f Select the first_name, last_name, address, address2, city name, district, and postal code columns from the staff table, performing 2 left joins with the address table then the city table to get the address and city related columns.
DESC staff; -- join on address_id
DESC address; -- join on city_id
DESC city;
SELECT s.first_name, 
	s.last_name,
	a.address,
	a.address2,
	c.city,
	a.district,
	a.postal_code
FROM staff s LEFT JOIN address a
	ON s.address_id = a.address_id
LEFT JOIN city c
	ON a.city_id = c.city_id;
	

-- More Exercises Part 2: 1 - 19 --
-- 1. Display the first and last names in all lowercase of all the actors.
desc actor;
SELECT lower(first_name),
	lower(last_name)
FROM actor;	
		
-- 2. You need to find the ID number, first name, and last name of an actor, of whom you know only the first name, "Joe." What is one query would you could use to obtain this information?
SELECT *
FROM actor
WHERE first_name = 'Joe';

-- 3. Find all actors whose last name contain the letters "gen":
SELECT *
FROM actor
WHERE last_name LIKE '%gen%';

-- 4. Find all actors whose last names contain the letters "li". This time, order the rows by last name and first name, in that order.
SELECT *
FROM actor
WHERE last_name LIKE '%li%'
ORDER BY last_name, first_name;

-- 5. Using IN, display the country_id and country columns for the following countries: Afghanistan, Bangladesh, and China:
SELECT country_id,
	country
FROM country
WHERE country IN ('Afghanistan', 'Bangladesh', 'China');

-- 6. List the last names of all the actors, as well as how many actors have that last name.
SELECT last_name,
	COUNT(*)
FROM actor
GROUP BY last_name;

-- 7. List last names of actors and the number of actors who have that last name, but only for names that are shared by at least two actors
SELECT last_name,
	COUNT(*) as count
FROM actor
GROUP BY last_name
HAVING count > 1;

-- ?? 8. You cannot locate the schema of the address table. Which query would you use to re-create it?
SHOW CREATE TABLE address;

-- 9. Use JOIN to display the first and last names, as well as the address, of each staff member.
SELECT s.first_name, 
    s.last_name,
	a.address
FROM staff s LEFT JOIN address a
	ON s.address_id = a.address_id;
	
-- 10.Use JOIN to display the total amount rung up by each staff member in August of 2005.
DESC staff;
DESC payment;
SELECT s.staff_id,
	s.first_name,
	s.last_name,
	SUM(p.amount) AS total_amount
FROM staff s JOIN payment p
	ON s.staff_id = p.staff_id
WHERE DATE(payment_date) >= '2005-08-01'
GROUP BY staff_id;

-- 11. List each film and the number of actors who are listed for that film.
DESC film; -- title, film_id
DESC film_actor; -- sum(actor_id)
SELECT f.title,
	COUNT(fa.actor_id)
FROM film f JOIN film_actor fa
	ON f.film_id = fa.film_id
GROUP BY f.title; 

-- 12. How many copies of the film Hunchback Impossible exist in the inventory system?
DESC film;
DESC inventory;
SELECT title,
count(i.film_id)
FROM inventory i JOIN film f
	ON i.film_id = f.film_id
WHERE title LIKE 'Hunchback%'
GROUP BY f.title;

-- 13. The music of Queen and Kris Kristofferson have seen an unlikely resurgence. As an unintended consequence, films starting with the letters K and Q have also soared in popularity. Use subqueries to display the titles of movies starting with the letters K and Q whose language is English.
DESC language;
SELECT * 
FROM film 
WHERE (title LIKE 'K%' 
	OR title LIKE 'R%')
	AND language_id IN
			(SELECT language_id
			FROM language 
			WHERE name = 'english');

-- 14. Use subqueries to display all actors who appear in the film Alone Trip.
DESC actor;
DESC film;
DESC film_actor;

SELECT film_id
FROM film
WHERE title = 'Alone Trip';

SELECT actor_id
FROM film_actor
WHERE film_id = (SELECT film_id
FROM film
WHERE title = 'Alone Trip');

SELECT first_name, last_name
FROM actor
WHERE actor_id IN (
	SELECT actor_id
	FROM film_actor
	WHERE film_id = (
		SELECT film_id
		FROM film
		WHERE title = 'Alone Trip'));
		
SELECT first_name, last_name
FROM (
	SELECT *
	FROM film_actor
	WHERE film_id = (
		SELECT film_id
		FROM film
		WHERE title = 'Alone Trip')) as fa
JOIN actor
	USING (actor_id);
	
-- 15. You want to run an email marketing campaign in Canada, for which you will need the names and email addresses of all Canadian customers.
DESC country;
DESC city;
DESC customer;
DESC address;

SELECT CONCAT(first_name, ' ', last_name) as name,
	email
FROM customer
JOIN address
	USING (address_id)
JOIN city
	USING (city_id)
WHERE country_id = (SELECT `country_id`	
					FROM country 
						WHERE country = 'Canada');

-- 16. Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies categorized as famiy films.
DESC film;
DESC film_category;
DESC category;

SELECT title 
FROM film 
WHERE film_id IN 
		(
		SELECT film_id
		FROM film_category
		WHERE category_id = 
				(
				SELECT category_id
				FROM category 
				WHERE name = 'family'
				)
			)
;

-- 17. Write a query to display how much business, in dollars, each store brought in.
SELECT total_sales
FROM sales_by_store;

-- 18. Write a query to display for each store its store ID, city, and country.
DESC store;
DESC address;
DESC city;

SELECT s.store_id, ct.city, country
FROM store s
JOIN address
	USING (address_id)
JOIN city ct
	USING (city_id)
JOIN country
	USING (country_id);
	
-- 19. List the top five genres in gross revenue in descending order. (Hint: you may need to use the following tables: category, film_category, inventory, payment, and rental.)

SELECT * FROM payment LIMIT 10; -- sum amount, join rental_id
SELECT * FROM rental LIMIT 10; -- join inventory_id
SELECT * FROM inventory LIMIT 10; -- JOIN FILM_ID
SELECT * FROM film_category LIMIT 10; -- join category_id
SELECT * FROM category;

SELECT name, sum(amount)
FROM category
JOIN film_category
	USING (category_id)
JOIN inventory
	USING (film_id)
JOIN rental
	USING (inventory_id)
JOIN payment 
	USING (rental_id)
GROUP BY name
ORDER BY sum(amount) DESC
LIMIT 5;

-- More Exercises Part 3: 1 - 8 --
-- 1. What is the average replacement cost of a film? Does this change depending on the rating of the film?
SELECT AVG(replacement_cost)
FROM film;

SELECT rating, AVG(replacement_cost)
FROM film
GROUP BY rating;

-- 2. How many different films of each genre are in the database?
SELECT name, count(*)
FROM category
JOIN film_category
	USING (category_id)
GROUP BY name;

-- 3. What are the 5 frequently rented films?
select * from inventory;
SELECT title, count(r.inventory_id)
FROM rental r
JOIN inventory
	USING (inventory_id)
JOIN film
	USING (film_id)
GROUP BY title
ORDER BY count(*) DESC
LIMIT 5;

-- 4. What are the most most profitable films (in terms of gross revenue)?
DESC payment; -- rental_id
DESC rental; -- inventory_id

SELECT title, SUM(amount)
FROM film
JOIN inventory
	USING (film_id)
JOIN rental
	USING (inventory_id)
JOIN payment
	USING (rental_id)
GROUP BY title
ORDER BY SUM(amount) DESC
LIMIT 5;

-- 5. Who is the best customer?

SELECT first_name, `last_name`
FROM customer
WHERE customer_id = 
		(SELECT customer_id
		FROM payment
		GROUP BY `customer_id`
		ORDER BY sum(amount) DESC
		LIMIT 1) ;

-- 6. Who are the most popular actors (that have appeared in the most films)?
SELECT actor_id, count(*) 
FROM film_actor
GROUP BY `actor_id`
ORDER BY count(*) DESC;

SELECT first_name, last_name, cnt
FROM actor
JOIN 
	(
	SELECT actor_id, count(*) as cnt
	FROM film_actor
	GROUP BY `actor_id`
	) 
AS fa
	USING (actor_id)
ORDER BY cnt DESC;

SELECT first_name, count(fa.actor_id) 
FROM film_actor fa
JOIN `actor`
	USING(actor_id)
GROUP BY actor_id
ORDER BY count(fa.actor_id) DESC;

-- 7. What are the sales for each store for each month in 2005?
SELECT MONTH(payment_date), store_id, SUM(amount) 
FROM payment
JOIN rental
	USING (rental_id)
JOIN `inventory`
	USING (inventory_id)
WHERE YEAR(payment_date) = '2005'
GROUP BY MONTH(payment_date), store_id
ORDER BY MONTH(payment_date);

-- 8. Bonus: Find the film title, customer name, customer phone number, and customer address for all the outstanding DVDs
DESC customer;
DESC address;
SELECT title, CONCAT(last_name, ', ', first_name) as name, phone, address
FROM 
	(
	SELECT title, customer_id 
	FROM rental
	JOIN inventory
		USING (inventory_id)
	JOIN film
		USING (film_id) 
	WHERE return_date IS NULL)
AS rn
JOIN customer
	USING (customer_id)
JOIN address
	USING (address_id)
 ;
