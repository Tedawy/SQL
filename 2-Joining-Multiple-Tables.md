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
    SELECT 
        f.title,
        c.name AS category_name,
        f.rental_rate
    FROM film AS f
    JOIN film_category AS fc ON f.film_id = fc.film_id
    JOIN category AS c ON fc.category_id = c.category_id;
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



# Advanced SQL Questions

- **Question: 1** List all customers and their rental history, including customers who have never rented a film. Display customer name, film title, and rental date.

- **ANSWER:**
    ```sql
    SELECT 
        CONCAT(c.first_name, ' ', c.last_name) AS customer_name, 
        f.title, 
        r.rental_date
    FROM 
        customer AS c
    LEFT JOIN 
        rental AS r ON c.customer_id = r.customer_id
    LEFT JOIN 
        inventory AS inv ON r.inventory_id = inv.inventory_id
    LEFT JOIN 
        film AS f ON f.film_id = inv.film_id
    ORDER BY 
        c.last_name, c.first_name, r.rental_date;
    ```

- **Question: 2**  Find all films that have never been rented. Show the film title and category name.

- **ANSWER:**
    ```sql
    SELECT 
        f.title,
        c.name AS category_name
    FROM 
        film AS f
    JOIN 
        film_category AS fc ON f.film_id = fc.film_id
    JOIN 
        category AS c ON c.category_id = fc.category_id
    LEFT JOIN 
        inventory AS inv ON f.film_id = inv.film_id 
    LEFT JOIN 
        rental AS r ON r.inventory_id = inv.inventory_id 
    WHERE 
        r.rental_id IS NULL;
    ```

- **Question: 3** Display a list of all actors and the films they've appeared in, including actors who haven't been cast in any film. Show actor name, film title, and release year.

- **ANSWER:**
    ```sql
    SELECT 
        CONCAT(a.first_name, ' ', a.last_name) AS actor_name, 
        f.title, 
        f.release_year
    FROM 
        actor AS a
    LEFT JOIN 
        film_actor AS fa ON a.actor_id = fa.actor_id
    LEFT JOIN 
        film AS f ON f.film_id = fa.film_id;
    ```

- **Question: 4** Create a report showing each store's revenue, along with the store manager's name and the number of rentals. Include stores even if they haven't processed any payments.

- **ANSWER:**
    ```sql
    SELECT 
        s.store_id,
        CONCAT(m.first_name, ' ', m.last_name) AS manager_name,
        COALESCE(SUM(p.amount), 0) AS revenue,
        COUNT(DISTINCT r.rental_id) AS rental_count
    FROM 
        store AS s
    LEFT JOIN 
        staff AS m ON s.manager_staff_id = m.staff_id
    LEFT JOIN 
        inventory AS i ON s.store_id = i.store_id
    LEFT JOIN 
        rental AS r ON i.inventory_id = r.inventory_id
    LEFT JOIN 
        payment AS p ON r.rental_id = p.rental_id
    GROUP BY 
        s.store_id, m.staff_id;
    ```

- **Question: 5** List all film categories along with the number of films in each category and the average rental rate. Include categories even if they have no films.

- **ANSWER:**
    ```sql
    SELECT 
        c.name AS category_name,
        COUNT(f.film_id) AS number_of_films,
        ROUND(AVG(f.rental_rate), 2) AS avg_rate
    FROM 
        category AS c 
    LEFT JOIN 
        film_category AS fc ON c.category_id = fc.category_id 
    LEFT JOIN 
        film AS f ON fc.film_id = f.film_id
    GROUP BY 
        c.category_id, c.name
    ORDER BY 
        number_of_films;
    ```


- **Question: 6** Find customers who have rented films from all categories. Display customer name and the number of distinct categories they've rented from.

- **ANSWER:**
    ```sql
    SELECT 
        CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
        COUNT(DISTINCT ca.category_id) AS number_of_categories
    FROM 
        customer AS c 
    JOIN 
        rental AS r ON c.customer_id = r.customer_id 
    JOIN 
        inventory AS inv ON r.inventory_id = inv.inventory_id 
    JOIN 
        film AS f ON inv.film_id = f.film_id 
    JOIN 
        film_category AS fc ON f.film_id = fc.film_id 
    JOIN 
        category AS ca ON fc.category_id = ca.category_id 
    GROUP BY 
        c.customer_id 
    HAVING 
        COUNT(DISTINCT ca.category_id) = (SELECT COUNT(*) FROM category);
    ```


- **Question: 7** Identify films that are in inventory but have never been rented. Show film title, store ID, and the time since the film was added to inventory.

- **ANSWER:**
    ```sql
    SELECT 
        f.title,
        inv.store_id,
        CURRENT_DATE - inv.last_update AS days_in_inventory
    FROM 
        film AS f
    JOIN 
        inventory AS inv ON f.film_id = inv.film_id 
    LEFT JOIN 
        rental AS r ON inv.inventory_id = r.inventory_id
    WHERE 
        r.rental_id IS NULL;
    ```

- **Question: 8** Create a report of staff members and their total sales, including the number of customers they've served. Include staff members even if they haven't made any sales.

- **ANSWER:**
    ```sql
    SELECT 
        concat(s.first_name, ' ', s.last_name) AS staff_member,
        sum(p.amount) AS total_sales,
        count(distinct(c.customer_id)) AS num_clients
    FROM 
        staff AS s 
    LEFT JOIN 
        payment AS p ON s.staff_id = p.staff_id
    LEFT JOIN 
        customer AS c ON p.customer_id = c.customer_id 
    GROUP BY 
        s.staff_id;
    ```

- **Question: 9** List all cities where the company has stores, along with the number of customers and total revenue from each city. Include cities even if they have no customers or revenue.

- **ANSWER:**
    ```sql
    SELECT 
        c.city,
        COUNT(DISTINCT cu.customer_id) AS customer_number,
        ROUND(SUM(p.amount), 2) AS revenue
    FROM 
        city AS c
    JOIN 
        address AS ad ON c.city_id = ad.city_id
    JOIN 
        store AS s ON ad.address_id = s.address_id
    LEFT JOIN 
        customer AS cu ON s.store_id = cu.store_id
    LEFT JOIN 
        payment AS p ON cu.customer_id = p.customer_id
    GROUP BY 
        c.city_id, c.city
    ORDER BY 
        revenue DESC;
    ```

- **Question: 10** Find pairs of actors who have never appeared in a film together. Display both actors' names and the number of films each has appeared in individually.

- **ANSWER:**
   ```sql
    SELECT 
        a1.actor_id AS actor1_id,
        CONCAT(a1.first_name, ' ', a1.last_name) AS actor1_name,
        a2.actor_id AS actor2_id,
        CONCAT(a2.first_name, ' ', a2.last_name) AS actor2_name,
        (SELECT COUNT(*) 
        FROM film_actor AS fa1 
        WHERE fa1.actor_id = a1.actor_id) AS actor1_film_count,
        (SELECT COUNT(*) 
    FROM film_actor AS fa2 
    WHERE fa2.actor_id = a2.actor_id) AS actor2_film_count
    FROM 
        actor AS a1
    JOIN 
        actor AS a2 ON a1.actor_id < a2.actor_id
    WHERE 
        NOT EXISTS (
            SELECT 1 
            FROM film_actor AS fa1
            JOIN film_actor AS fa2 ON fa1.film_id = fa2.film_id
            WHERE fa1.actor_id = a1.actor_id
            AND fa2.actor_id = a2.actor_id
        );
    ```