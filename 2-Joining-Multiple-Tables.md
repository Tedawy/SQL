# **Section 3. Joining Multiple Tables**
We have different ways to join tables in PostgreSQL

- Inner Join – select rows from one table that has the corresponding rows in other tables.
- Left Join – select rows from one table that may or may not have the corresponding rows in other tables.
- Self-join – join a table to itself by comparing a table to itself.
- Full Outer Join – use the full join to find a row in a table that does not have a matching row in another table.
- Cross Join – produce a Cartesian product of the rows in two or more tables.
- Natural Join – join two or more tables using implicit join conditions based on the common column names in the joined tables.

![PostgreSQL Join](/images/PostgreSQL-Joins.png)

# **SQL Assessment**

- **Question: 1**  Write a query to display the first name, last name, and email of customers along with the rental date and return date of the movies they've rented.

- **Answer:** 
    ```sql
    SELECT 
        c.first_name,
        c.last_name,
        c.email,
        r.rental_date,
        r.return_date
    FROM customer AS c 
    JOIN rental AS r 
    ON c.customer_id = r.customer_id; 
    ```

- **Question: 2** Create a query that shows the film title, category name, and rental rate for all movies.

- **Answer:**
    ```sql
    select 
        f.title,
        c.name as category_name,
        f.rental_rate
    from film as f
    join film_category as fc on f.film_id = fc.film_id
    join category as c on fc.category_id = c.category_id
    ``` 

- **Question: 3** Display the staff member's name, customer's name, and payment amount for each payment transaction.

- **Answer:** 
    ```sql
    SELECT 
        CONCAT(s.first_name, ' ', s.last_name) AS staff_name,
        CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
        p.amount
    FROM payment AS p
    JOIN customer AS c ON p.customer_id = c.customer_id
    JOIN staff AS s ON p.staff_id = s.staff_id;
    ```
- **Question: 4** List the actor's first name, last name, and the titles of the films they've appeared in.

- **Answer:** 
    ```sql
    SELECT 
        CONCAT(a.first_name, ' ', a.last_name) AS actor_name, 
        f.title 
    FROM actor AS a 
    JOIN film_actor AS fa ON a.actor_id = fa.actor_id 
    JOIN film AS f ON f.film_id = fa.film_id;
    ```

- **Question: 5** Show the store ID, city, and country for each store.

- **Answer:** 
    ```sql
    SELECT 
        s.store_id, 
        c.city, 
        co.country
    FROM store AS s 
    JOIN address AS ad ON s.address_id = ad.address_id
    JOIN city AS c ON ad.city_id = c.city_id
    JOIN country AS co ON c.country_id = co.country_id; 
    ```

- **Question: 6** Create a query that displays the film title, language name, and rental duration for all films.

- **Answer:** 
    ```sql
    SELECT  
        f.title, f.rental_duration, l.name 
    FROM film AS f 
    JOIN language aAS l ON f.language_id = l.language_id;
    ```

- **Question: 7** List customer names along with the total amount they've paid and the count of rentals they've made.

- **Answer:** 
    ```sql
    SELECT 
        CONCAT(c.first_name, ' ', c.last_name) AS customer_name, 
        SUM(p.amount) AS total, 
        COUNT(p.rental_id) AS rental_count 
    FROM customer AS c
    JOIN payment AS p ON c.customer_id = p.customer_id
    GROUP BY c.customer_id;
    ```

- **Question: 8** Display the film title, inventory ID, and store ID for all films that are in inventory.

- **Answer:** 
    ```sql
    SELECT 
        f.title, n.inventory_id, n.store_id 
    FROM film AS f
    JOIN inventory AS n ON f.film_id = n.film_id;
    ```

- **Question: 9** Show the film title, category name, and the number of times it has been rented.

- **Answer:** 
    ```sql
    SELECT 
        f.title, c.name as category_name, count(r.rental_id) as rental_count
    FROM film AS f
    JOIN film_category AS fc ON f.film_id = fc.film_id
    JOIN category AS c ON c.category_id = fc.category_id
    JOIN inventory AS i ON f.film_id = i.film_id
    JOIN rental AS r ON i.inventory_id = r.inventory_id
    GROUP BY f.title, c.name;
    ```

- **Question: 10** Create a query that displays the staff member's name, the customer's name, and the title of the film for each rental transaction.

- **Answer:** 
    ```sql
    SELECT 
        CONCAT(s.first_name, ' ', s.last_name) AS staff_name,
        CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
        f.title AS movie_name
    FROM rental AS r
    JOIN inventory AS inv ON r.inventory_id = inv.inventory_id
    JOIN film AS f ON inv.film_id = f.film_id
    JOIN customer AS c ON r.customer_id = c.customer_id
    JOIN staff AS s ON r.staff_id = s.staff_id;
    ```
