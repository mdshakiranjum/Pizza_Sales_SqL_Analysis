--Basic_1. Retrieve the total number of orders placed.
select count(order_id) as total_order from orders


--Basic_2. Calculate the total revenue generated from pizza sales.
select round(sum(order_details.quantity * pizzas.price),1) as total_revenue
       from order_details join pizzas
	   on order_details.pizza_id = pizzas.pizza_id


--Basic_3. Identify the highest-priced pizza.
select pizza_types.name, pizzas.price
from pizza_types join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id
order by price desc
limit 1;


--Basic_4. Identify the most common pizza size ordered.
select pizzas.size, count(order_details.order_details_id) as order_count 
from pizzas join order_details
on pizzas.pizza_id = order_details.pizza_id
group by size


--Basic_5. List the top 5 most ordered pizza types along with their quantities.
SELECT pt.name,
       SUM(od.quantity) AS quantity
FROM pizza_types AS pt
JOIN pizzas AS p
    ON pt.pizza_type_id = p.pizza_type_id
JOIN order_details AS od
    ON od.pizza_id = p.pizza_id
GROUP BY pt.name
ORDER BY quantity DESC
LIMIT 5;


--Intermediate_6. Join the necessary tables to find the total quantity of each pizza category ordered.
SELECT pizza_types.category,
       SUM(order_details.quantity) AS quantity
FROM pizza_types
JOIN pizzas
ON pizza_types.pizza_type_id = pizzas.pizza_type_id
JOIN order_details
ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.category
ORDER BY quantity DESC;


--Intermediate_7. Determine the distribution of orders by hour of the day.
select extract(hour from time) as hr,count(order_id) as order_count 
from orders
group by hr


--Interm_8. Join relevant tables to find thecategory-wise distribution of pizzas.
select category, count(name) from pizza_types
group by category


--Interm_9.  Group the orders by date and calculate the average number of pizzas ordered per day.
select extract (day from date) as days, round(avg(orders.order_id),2) as avg_pizza_order
from orders
group by days
order by avg_pizza_order

SELECT ROUND(AVG(quantity), 0)
FROM
(
    SELECT orders.date,
           SUM(order_details.quantity) AS quantity
    FROM orders
    JOIN order_details
        ON orders.order_id = order_details.order_id
    GROUP BY orders.date
) AS order_quantity;


--Basic_10. Determine the top 3 most ordered pizza types based on revenue.
SELECT pizza_types.name,
       SUM(order_details.quantity * pizzas.price) AS revenue
FROM pizza_types
JOIN pizzas
    ON pizzas.pizza_type_id = pizza_types.pizza_type_id
JOIN order_details
    ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.name
ORDER BY revenue DESC
LIMIT 3;


--Adv_11. Calculate the percentage contribution of each pizza type to total revenue.
SELECT pizza_types.category,
        ROUND(
           SUM(order_details.quantity * pizzas.price)
           / (
               SELECT ROUND(SUM(order_details.quantity * pizzas.price), 2)
               FROM order_details
               JOIN pizzas
                   ON pizzas.pizza_id = order_details.pizza_id
           ) * 100,
           2
       ) AS revenue
FROM pizza_types
JOIN pizzas
    ON pizza_types.pizza_type_id = pizzas.pizza_type_id
JOIN order_details
    ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.category
ORDER BY revenue DESC;


--Adv_12.  Analyze the cumulative revenue generated over time.
SELECT date,
       SUM(revenue) OVER (ORDER BY date) AS cum_revenue
FROM (
    SELECT orders.date,
           SUM(order_details.quantity * pizzas.price) AS revenue
    FROM order_details
    JOIN pizzas
        ON order_details.pizza_id = pizzas.pizza_id
    JOIN orders
        ON orders.order_id = order_details.order_id
    GROUP BY orders.date
) AS sales;


--Adv_13.  Determine the top 3 most ordered pizza types based on revenue for each pizza category.
SELECT name,
       revenue
FROM (
    SELECT category,
           name,
           revenue,
           RANK() OVER (
               PARTITION BY category
               ORDER BY revenue DESC
           ) AS rn
    FROM (
        SELECT pizza_types.category,
               pizza_types.name,
               SUM(order_details.quantity * pizzas.price) AS revenue
        FROM pizza_types
        JOIN pizzas
            ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN order_details
            ON order_details.pizza_id = pizzas.pizza_id
        GROUP BY pizza_types.category,
                 pizza_types.name
    ) AS a
) AS b
WHERE rn <= 3;





























































