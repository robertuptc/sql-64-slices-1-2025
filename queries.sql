-- ### How many drivers she has. ###
-- SELECT COUNT(id) AS total_drivers FROM drivers;

-- ### How many deliveries has each store made? ###
-- SELECT s.id, COUNT(de.id) FROM stores s
-- LEFT JOIN drivers dr ON dr.store_id = s.id
-- LEFT JOIN deliveries de ON dr.id = de.driver_id
-- GROUP BY s.id
-- ORDER BY s.id ASC;

-- ### How many deliveries has each driver made? ###
-- SELECT dr.full_name, COUNT(de.order_id) AS total_deliveries FROM drivers dr
-- LEFT JOIN deliveries de ON dr.id = de.driver_id
-- GROUP BY dr.full_name
-- ORDER BY total_deliveries;

-- ### Which driver did the shortest delivery? ###
-- SELECT dr.full_name, de.started_delivery, de.completed_delivery, EXTRACT(EPOCH FROM de.completed_delivery - de.started_delivery) AS min_delivery_time
-- FROM drivers dr
-- LEFT JOIN deliveries de ON dr.id = de.driver_id
--     WHERE EXTRACT(EPOCH FROM de.completed_delivery - de.started_delivery) = (
--         SELECT MIN(EXTRACT(EPOCH FROM d.completed_delivery - d.started_delivery))
--         FROM deliveries d
--     );

-- ### Which driver did the longest delivery? ###
-- SELECT dr.full_name, de.started_delivery, de.completed_delivery, EXTRACT(EPOCH FROM de.completed_delivery - de.started_delivery) AS max_delivery_time 
-- FROM drivers dr
-- LEFT JOIN deliveries de ON dr.id = de.driver_id
--     WHERE  EXTRACT(EPOCH FROM de.completed_delivery - de.started_delivery) = (
--         SELECT MAX(EXTRACT(EPOCH FROM d.completed_delivery - d.started_delivery)) 
--         FROM deliveries d
--     );

-- ### How much money did they make on each order? ###
-- SELECT 
--     o.order_id,
--     o.pizza_type, 
--     ap.cost AS base_cost, 
--     o.toppings,
--     -- topping_id,
--     SUM(atp.cost_per_pizza) AS topings_total,
--     ap.cost + SUM(atp.cost_per_pizza) AS final_price
-- FROM orders o 
-- LEFT JOIN available_pizzas ap ON o.pizza_type = ap.id
-- LEFT JOIN LATERAL unnest(string_to_array(o.toppings, '/')) AS topping_id ON TRUE
-- LEFT JOIN available_toppings atp ON topping_id::INT = atp.id
-- GROUP BY o.order_id, ap.cost--, topping_id
-- LIMIT 15

-- ### Which store made the most money? ###
-- SELECT 
--     o.store_id,
--     SUM(ap.cost + COALESCE(total_topping_cost, 0)) AS total_revenue
-- FROM orders o
-- LEFT JOIN available_pizzas ap ON o.pizza_type = ap.id
-- LEFT JOIN (
--     SELECT 
--             o.order_id,
--             -- o.toppings,
--             -- topping_id,
--             SUM(atp.cost_per_pizza) AS total_topping_cost
--         FROM orders o
--         LEFT JOIN LATERAL unnest(string_to_array(o.toppings, '/')) AS topping_id ON TRUE
--         LEFT JOIN available_toppings atp ON topping_id::INT = atp.id
--         GROUP BY o.order_id 
-- ) atp ON o.order_id = atp.order_id
-- GROUP BY o.store_id
-- ORDER BY total_revenue DESC
-- LIMIT 1

-- ### Which customer spent the most money? ###
-- SELECT 
--     o.customer_id,
--     SUM(ap.cost + COALESCE(total_topping_cost, 0)) AS customer_cost
-- FROM orders o
-- LEFT JOIN customers c ON o.customer_id = c.id
-- LEFT JOIN available_pizzas ap ON o.pizza_type = ap.id
-- LEFT JOIN (
--     SELECT
--         o.order_id,
--         SUM(atp.cost_per_pizza) AS total_topping_cost
--     FROM orders o
--     LEFT JOIN LATERAL unnest(string_to_array(o.toppings, '/')) AS topping_id ON TRUE
--     LEFT JOIN available_toppings atp ON topping_id::INT = atp.id
--     GROUP BY o.order_id
-- ) atp ON o.order_id = atp.order_id
-- GROUP BY o.customer_id
-- ORDER BY customer_cost DESC
-- LIMIT 1

-- ### How much money did they make each month? ###
-- SELECT 
--     EXTRACT(MONTH FROM o.date) AS month,
--     SUM(ap.cost + COALESCE(total_topping_cost, 0)) AS monthly_profit
-- FROM orders o
-- LEFT JOIN available_pizzas ap ON o.pizza_type = ap.id
-- LEFT JOIN (
--     SELECT 
--         o.order_id,
--         SUM(atp.cost_per_pizza) AS total_topping_cost
--     FROM orders o
--     LEFT JOIN LATERAL unnest(string_to_array(o.toppings, '/')) AS topping_id ON TRUE
--     LEFT JOIN available_toppings atp ON topping_id::INT = atp.id
--     GROUP BY o.order_id
-- ) atp ON o.order_id = atp.order_id
-- GROUP BY month


-- ### Which driver, on average, takes the longest? ###
-- SELECT 
--     d.full_name,
--     AVG(EXTRACT(EPOCH FROM de.completed_delivery - de.started_delivery)) AS average_delivery_time
-- FROM drivers d
-- JOIN deliveries de ON d.id = de.driver_id
-- GROUP BY d.full_name
-- ORDER BY average_delivery_time DESC
-- LIMIT 1

-- ### Which driver, on average, is the quickest? ###
SELECT  
    d.full_name,
    AVG(EXTRACT(EPOCH FROM de.completed_delivery - de.started_delivery)) AS average_delivery_time
FROM drivers d
JOIN deliveries de ON d.id = de.driver_id
GROUP BY d.full_name
ORDER BY average_delivery_time ASC
LIMIT 1