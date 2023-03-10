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

-- More Exercises Part 4: Employees Database -- 
-- 1. How much do the current managers of each department get paid, relative to the average salary for the department? Is there any department where the department manager gets paid less than the average salary?
USE employees;

-- Each manager's current salary
SELECT emp_no, salary, dept_no
FROM dept_manager dm
JOIN salaries s
	USING (emp_no)
WHERE dm.to_date > now()
	AND s.to_date > now();

-- avg salary for each department
SELECT dept_no, AVG(salary)
FROM dept_emp de
JOIN salaries s
	ON de.emp_no = s.emp_no
GROUP BY dept_no;

-- Combining the two
SELECT emp_no, salary, dept_no, da.avg
FROM (
		SELECT dept_no, AVG(salary) as avg
		FROM dept_emp de
		JOIN salaries s
				ON de.emp_no = s.emp_no
		WHERE s.to_date > now()
		GROUP BY dept_no) as da -- dept avg sal
JOIN dept_manager dm
	USING (dept_no)
JOIN salaries ss
	USING (emp_no)
WHERE dm.to_date > now()
	AND ss.to_date > now();
	
-- FINDING WHO GETS PAID LESS THAN THE AVERAGE
	-- Production, Research
desc departments;


SELECT dept_name, emp_no, salary - da.avg
FROM departments
JOIN (
		SELECT dept_no, AVG(salary) as avg
		FROM dept_emp de
		JOIN salaries s
				ON de.emp_no = s.emp_no
		WHERE s.to_date > now()
		GROUP BY dept_no) 
		as da -- dept avg sal
	USING (dept_no)
JOIN dept_manager dm
	USING (dept_no)
JOIN salaries ss
	USING (emp_no)
WHERE dm.to_date > now()
	AND ss.to_date > now();
 
-- More Exercises Part 5: World Database --
USE world;
SHOW TABLES;
DESC city;
	SELECT * FROM city;
DESC country;
	SELECT * FROM country;
DESC countrylanguage;
	SELECT * FROM countrylanguage;
	
-- 1. What languages are spoken in Santa Monica?
SELECT 
	language, 
	percentage
FROM city 
	JOIN countrylanguage
		USING (countrycode)
WHERE NAME LIKE '%Monica';

-- 2. How many different countries are in each region?
SELECT
	Region, 
	count(NAME) AS cnt
FROM country
GROUP BY region
ORDER BY cnt;

-- 3. What is the population for each region?
SELECT
	region,
	SUM(population) AS pop
FROM country
GROUP BY region
ORDER BY pop DESC;

-- 4. What is the population for each continent?
SELECT
	Continent,
	SUM(population) AS pop
FROM country
GROUP BY continent
ORDER BY pop DESC;

-- 5. What is the average life expectancy globally?
SELECT 
	AVG(`LifeExpectancy`)
FROM country;

-- 6. What is the average life expectancy for each region, each continent? Sort the results from shortest to longest
SELECT 
	region,
	AVG(`LifeExpectancy`)
FROM country
GROUP BY region;


SELECT 
	continent,
	AVG(`LifeExpectancy`)
FROM country
GROUP BY continent;

-- Part 5: Bonus exercises --

-- 1. Find all the countries whose local name is different from the official name
SELECT 
	NAME
	localname
FROM country
WHERE NAME != localname;

-- 2. How many countries have a life expectancy less than Luxembourg?
SELECT
	count(*)
FROM country
WHERE lifeexpectancy < 
	(
	SELECT 
		LifeExpectancy
	FROM country
	WHERE NAME = 'Luxembourg'
	);
	
-- 3. What state is Votorantim located in?
SELECT 
	district
FROM city
WHERE NAME = 'Votorantim';

-- 4. What region of the world is Votorantim located in?
SELECT 
	region
FROM country
	JOIN city
		ON countrycode = CODE
WHERE city.name = 'Votorantim';

-- 5. What country (use the human readable name) city x located in?
SELECT 
	country.name
FROM country
	JOIN city
		ON CODE = countrycode
WHERE city.name = 'Votorantim';

-- 6. What is the life expectancy in city x?
SELECT 
	lifeexpectancy
FROM country
	JOIN city
		ON CODE = countrycode
WHERE city.name = 'Votorantim'; 

-- More Exercises Part 6: Advanced Pizza Database
USE pizza;
SHOW TABLES;
-- 1. What information is stored in the toppings table? How does this table relate to the pizzas table?
	-- A: The topping id, topping name, and topping price are all stored in this table. The toppings are paired with the pizzas using their 'id' on the pizza_toppings table;
DESC toppings;
DESC pizzas;
DESC pizza_toppings;

-- 2. What information is stored in the modifiers table? How does this table relate to the pizzas table?
	-- A: The modifier id, modifier name (different things to change about a pizza), and the price of the modification is stored in the modofier table. The pizza_modifier table attaches these modifications and the prices of the modifications to the pizza id via their respective id's
DESC modifiers;
SELECT *
FROM modifiers
LIMIT 5;

-- 3. How are the pizzas and sizes tables related?
	-- A: The size id for each size is attached to the pizza table as a foreign key to connect the size name and size price to the pizza ordered.
DESC pizzas;
DESC sizes;

-- 4. What other tables are in the database?
	-- A: crust_types is the last table that I have not discussed in my previous answers.
SHOW TABLES;

-- 5. How many unique toppings are there?
	-- A: 9
SELECT COUNT(DISTINCT topping_name)
FROM toppings;

 --  6. How many unique orders are in this dataset?
	-- A: 10000. I'm not sure of the author of this questions wants unique order id's or specifically unique order contents. If the author of this questions wanted unique order contents, the query will be more complex.
SELECT COUNT(DISTINCT order_id)
FROM pizzas;

-- 7. Which size of pizza is sold the most?
	-- A: Large is sold the most
SELECT size_name, count(size_id) AS cnt
FROM pizzas
	JOIN sizes
		USING(size_id)
GROUP BY size_id
ORDER BY cnt DESC;

-- 8. How many pizzas have been sold in total?
	-- A: 2001
SELECT * /* COUNT(DISTINCT pizza_id) */
FROM pizzas;

-- 9. What is the most common size of pizza ordered?
	-- I'm not sure how this is different from the questions from before so I'm skipping this one
	
-- 10. What is the average number of pizzas per order?
	-- 2.0001

	-- Number of pizas in each order
SELECT 
COUNT(pizza_id) AS cnt
FROM pizzas
GROUP BY order_ID;

	-- Finding the average of the pizzas per order using the above as a subquery
SELECT 
	AVG(cnt) avg_per_ord
FROM (SELECT 
	COUNT(pizza_id) AS cnt
FROM pizzas
GROUP BY order_ID) AS ppo;

-- 11. Find the total price for each order. 
	-- A: 
SELECT  
	order_id, 
	SUM(modifier_price) + SUM(size_price) + SUM(total_topping_price)
FROM pizzas
	JOIN pizza_modifiers
		USING (pizza_id)
	JOIN modifiers
		USING (modifier_id)
	JOIN (
			SELECT topping_id, pizza_id,
			CASE
				WHEN topping_amount = 'light' THEN topping_price * .5
				WHEN topping_amount = 'extra' THEN topping_price * 1.5
				WHEN topping_amount = 'double' THEN topping_price * 2
				ELSE topping_price
			END AS total_topping_price 
			 FROM toppings
			 	JOIN pizza_toppings
			 		USING (topping_id)
 		) toppings_price
		USING (pizza_id)
	JOIN sizes
		USING (size_id)
GROUP BY order_id
LIMIT 1;

-- More Exercises Part 7: Additional Questions --
USE pizza;

-- 1. What is the average price of pizzas that have no cheese?
	-- A: $36.13
	-- Find the price for each pizza with no cheese and use the created table as a subquery in the FROM clause to enable the average function to be able to pull the column/field/feature 'pizza_price'
SELECT 
	ROUND(AVG(pizza_price), 2) AS avg_no_cheese_price
FROM 
(
	SELECT
		pizza_id,
		(SUM(modifier_price) + SUM(total_topping_price) + SUM(size_price)) AS pizza_price
	FROM pizzas
		JOIN pizza_modifiers
			USING (pizza_id)
		JOIN modifiers 
			USING (modifier_id)
		JOIN 
			(
				SELECT 
					pizza_id,
					CASE 
						WHEN topping_amount = 'light' THEN topping_price * .5
						WHEN topping_amount = 'regular' THEN topping_price * 1
						WHEN topping_amount = 'extra' THEN topping_price *  1.5
						WHEN topping_amount = 'double' THEN topping_price* 2
						ELSE 'error'
					END AS total_topping_price
				FROM pizza_toppings
					JOIN toppings
						USING (topping_id)
			) AS toppings_price
			USING (pizza_id)
		JOIN sizes
			USING (size_id)
	WHERE modifier_name = 'no cheese'
	GROUP BY pizza_id
) AS no_cheese_prices;
	-- Created a sub query for the price of the toppings
/* SELECT 
	pizza_id,
	CASE 
		WHEN topping_amount = 'light' THEN topping_price * .5
		WHEN topping_amount = 'regular' THEN topping_price * 1
		WHEN topping_amount = 'extra' THEN topping_price *  1.5
		WHEN topping_amount = 'DOUBLE' THEN topping_price* 2
		ELSE 'error'
	END AS total_topping_price
FROM pizza_toppings
	JOIN toppings
		USING (topping_id); */
-- 2. What is the most common size for pizzas that have extra cheese?
	-- A: Medium
	-- PLAN: First I will filter the results to only get pizzas with extra cheese, I will then use the count function with the results grouped by size, lastly I will either use the ORDER BY clause or the MAX function to identify the most common size for pizzas tht have extra cheese. JOINS: pizzas - pizza_modifiers - sizes

SELECT 
	size_name,
	COUNT(*) AS cnt
FROM pizzas
	JOIN pizza_modifiers
		USING (pizza_id)
	JOIN sizes 
		USING (size_id)
WHERE modifier_id = 1
GROUP BY size_name
ORDER BY cnt DESC
LIMIT 1;

-- 3. What is the most common topping for pizzas that are well done?
	-- A: Bacon is the most common. This makes sense becasue many people enjoy crisy bacon.
	-- PLAN: join pizzas - pizza_modifiers -- pizza_toppings -- toppings. Use the WHERE clause to get only poizzas that are well done. Use the GROUP BY clause to aggregate information based on the topping_name. The SELECT statement will have each topping and counts for each toppings based off the data from the resulting query.
SELECT 
	topping_name,
	count(*) AS cnt
FROM pizzas
	JOIN pizza_modifiers
		USING (pizza_id)
	JOIN pizza_toppings
		USING (pizza_id)
	JOIN toppings
		USING (topping_id)
WHERE modifier_id = 2 -- SELECT * FROM modifiers;
GROUP BY topping_name
ORDER BY cnt DESC;

/* -- 4. How many pizzas are only cheese (i.e. have no toppings)?
	-- A: The answer may be zero, but Im not sure
SELECT 
	topping_amount 
FROM pizza_toppings 
GROUP BY topping_amount;
SELECT * FROM toppings;
DESC pizza_toppings;
	-- Plan: Pizzas with no pizza_id on the pizza_topping table AND that do not have the 'no cheese' modifier are the pizzas i'm looking for. I think in the WHERE statement I can filter to get exactly what I want

SELECT 
	COUNT(CASE WHEN p.pizza_id IN (pt.pizza_id) THEN TRUE ELSE NULL END) AS not_only_cheese,
	COUNT(CASE WHEN p.pizza_id NOT IN (pt.pizza_id) THEN TRUE ELSE NULL END) AS only_cheese
FROM pizzas p
	JOIN pizza_toppings pt
			USING (pizza_id)
	JOIN pizza_modifiers
		USING (pizza_id)
WHERE modifier_id <> 3;
SELECT * FROM modifiers;

-- 5. How many orders consist of pizza(s) that are only cheese? What is the average price of these orders? The most common pizza size?
	-- A: ASK FOR HELP */

-- 6. How may large pizzas have olives on them?
	-- A: 1,326 
	-- Plan: Query for only large pizzas with olives using the where clause.
SELECT * FROM toppings; -- topping_id 7 for ol;ives
SELECT * FROM sizes; -- size_id 3 is for large pizzas
SELECT
	count(*)
FROM pizzas
	JOIN pizza_toppings
		USING (pizza_id)
WHERE size_id = 3
	AND topping_id = 7;
	
-- 7. What is the average number of toppings per pizza?
	-- A: 2.7 or 3 toppings if rounded
	-- PLAN: Use a subquery in the FROM clause based on pizza_toppings. In the subquery use the GROUP BY clause to aggregate the data by pizza_id with a count of the amount of times the pizza_id appears on the pizza_toppings table. This will be labeled as topping_cnt. In the main query, the avg function will be used with topping_cnt as the argument.
SELECT
	AVG(topping_cnt)
FROM 
(
	SELECT
		pizza_id,
		COUNT(*) AS topping_cnt
	FROM pizza_toppings
		JOIN pizzas
			USING (pizza_id)
	GROUP BY pizza_id
	ORDER BY topping_cnt
) AS tc;

-- 8. What is the average number of pizzas per order?
	-- A: 2
SELECT 
	AVG(pizza_cnt)
FROM 
(
SELECT
	order_id,
	count(*) AS pizza_cnt
FROM pizzas
GROUP BY order_id
) AS pc;

-- 9. What is the average pizza price?
	-- A: 37.47

SELECT 
	ROUND(AVG(pizza_price), 2) AS avg_price
FROM 
(
	SELECT
		pizza_id,
		(SUM(modifier_price) + SUM(total_topping_price) + SUM(size_price)) AS pizza_price
	FROM pizzas
		JOIN pizza_modifiers
			USING (pizza_id)
		JOIN modifiers 
			USING (modifier_id)
		JOIN 
			(
				SELECT 
					pizza_id,
					CASE 
						WHEN topping_amount = 'light' THEN topping_price * .5
						WHEN topping_amount = 'regular' THEN topping_price * 1
						WHEN topping_amount = 'extra' THEN topping_price *  1.5
						WHEN topping_amount = 'double' THEN topping_price* 2
						ELSE 'error'
					END AS total_topping_price
				FROM pizza_toppings
					JOIN toppings
						USING (topping_id)
			) AS toppings_price
			USING (pizza_id)
		JOIN sizes
			USING (size_id)
	GROUP BY pizza_id
) AS prices;


