--1. List all customers who live in Texas (use JOINs)
    --customer id's= 305, 118, 6, 400, & 561
SELECT * FROM address; --district is state
SELECT * FROM customer; --need customer_id from here

SELECT district, customer_id 
FROM address
FULL JOIN customer
ON customer.address_id = address.address_id
ORDER BY district;

--2. Get all payments above $6.99 with the Customer's Full Name
    --Alfredo Mcadams, Alvin Dloach, Douglas Graf, Harold Martino, Mary Smith, & Peter Menard
--payment -> amount & customer_id; customer -> customer_id & first name, last name

SELECT amount, first_name, last_name
FROM payment
INNER JOIN customer
ON payment.customer_id = customer.customer_id
WHERE amount > 6.99
ORDER BY first_name;

--3. Show all customers names who have made payments over $175(use subqueries)
        --mary smith & douglas graf
--need customer names from customer; amount from payment
SELECT * FROM customer;
SELECT * FROM payment;

SELECT first_name, last_name
FROM customer
WHERE customer_id IN ( 
    SELECT customer_id
    FROM payment
    WHERE amount > 175 
    GROUP BY customer_id
);

--4. List all customers that live in Nepal (use the city table)
    --Kevin Schuler
SELECT * FROM customer WHERE address_id = '326'; --address_id (step 4- answer)
SELECT * from address WHERE city_id = '81';-- address_id = 326 & city_id (step 3)
select * FROM city WHERE country_id = '66'; -- city_id = 81 (step 2)
SELECT * FROM country WHERE country = 'Nepal'; --country_id = 66 (step1)


--5. Which staff member had the most transactions?
    --MIKE
--staff table(first name / last name), rental table (count(rental_id)) have staff_id in common

SELECT first_name, COUNT(first_name) AS name
FROM staff 
FULL JOIN rental
ON staff.staff_id = rental.staff_id
GROUP BY first_name;


--6. How many movies of each rating are there?
    --THERE ARE 209 MOVIES RATED NC-17, 178 MOVIES RATED G, 224 MOVIES RATED PG-13, 194 MOVIES RATED PG, AND 196 MOVIES RATED R.
--rating from film table; 
SELECT COUNT(title), rating 
FROM film
GROUP BY rating;

--7.Show all customers who have made a single payment above $6.99 (Use Subqueries)
    --MARY, PETER, HAROLD, DOUGLAS, ALVIN, & ALFREDO

SELECT customer_id, amount
FROM payment
WHERE amount > 6.99;

SELECT first_name
FROM customer
WHERE customer_id IN (
    SELECT  customer_id
    FROM payment
    WHERE amount > 6.99
    GROUP BY customer_id
);
--8. How many free rentals did our stores give away?
     --we gave none away but 14,564 rentals had negative amounts paid
SELECT COUNT(rental_id)
FROM payment
WHERE amount = '0';

SELECT COUNT(rental_id)
FROM payment
WHERE amount <= '0';
   