# Retrieve the total number of order placed--

SELECT 
    COUNT(order_id) AS Total_orders
FROM
    orders;
    
    
    
# Calculate the total revenue generated from pizza sales--

SELECT 
    round(sum(orders_details.quantity * pizzas.price),
			2) as total_revenue
FROM
    orders_details
        JOIN
    pizzas ON pizzas.pizza_id = orders_details.pizza_id;
    
    
    
# identify the highest price pizza--

SELECT 
    pizza_types.name, price
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
ORDER BY price DESC
LIMIT 1
;






# identify the most common pizza size ordered-- 

SELECT 
    pizzas.size, COUNT(orders_details.order_details_id) AS quant
FROM
    pizzas
        JOIN
    orders_details ON pizzas.pizza_id = orders_details.pizza_id
GROUP BY pizzas.size
ORDER BY quant DESC
LIMIT 1;






# List the top 5 most ordered pizzas types along with their quantities


SELECT 
    pizza_types.name, SUM(orders_details.quantity)
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    orders_details ON pizzas.pizza_id = orders_details.pizza_id
GROUP BY pizza_types.name
ORDER BY SUM(orders_details.quantity) DESC
LIMIT 5;






# Join the necessary tables to find total quantity of each pizza category---


SELECT 
    pizza_types.category,
    SUM(orders_details.quantity) AS quantity
FROM
    pizza_types
        JOIN
    pizzas ON pizzas.pizza_type_id = pizza_types.pizza_type_id
        JOIN
    orders_details ON orders_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.category
ORDER BY quantity desc;







# Determine the distribution of orders by thr hour of the day--

SELECT 
    HOUR(order_time) AS hour, COUNT(order_id) AS order_count
FROM
    orders
GROUP BY HOUR(order_time);









# Join relevant tables to find the category wise 
# distribution of pizzas--


SELECT 
    category, COUNT(name)
FROM
    pizza_types
GROUP BY category;








# Group the orders by date and calculate the average number of pizza ordered per day--

SELECT 
    ROUND(AVG(quantity), 0) AS avg_pizza_perday
FROM
    (SELECT 
        orders.order_date, SUM(orders_details.quantity) AS quantity
    FROM
        orders
    JOIN orders_details ON orders.order_id = orders_details.order_id
    GROUP BY orders.order_date) AS order_quantity;
    
    
    
    
    
    
# determine the top 3 most ordered pizza types based on revenue--

SELECT 
    pizza_types.name,
    SUM(orders_details.quantity * pizzas.price) AS revenue
FROM
    pizza_types
        JOIN
    pizzas ON pizzas.pizza_type_id = pizza_types.pizza_type_id
        JOIN
    orders_details ON orders_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.name
ORDER BY revenue DESC
LIMIT 3;






# Calculate the percentage contribution of each pizza type to total revenue


SELECT 
    pizza_types.category,
    ROUND(SUM(orders_details.quantity * pizzas.price) / (SELECT 
                    ROUND(SUM(orders_details.quantity * pizzas.price),
                                2) AS total_revenue
                FROM
                    orders_details
                        JOIN
                    pizzas ON pizzas.pizza_id = orders_details.pizza_id) * 100,
            2) AS revenue
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    orders_details ON pizzas.pizza_id = orders_details.pizza_id
GROUP BY pizza_types.category
ORDER BY revenue DESC;





