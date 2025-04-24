DROP TABLE IF EXISTS available_pizzas, available_toppings, customers, deliveries, drivers, order_toppings, orders, stores;

CREATE TABLE available_pizzas(
    id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    cost DECIMAL(5, 2)
);

CREATE TABLE available_toppings(
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    cost_per_pizza DECIMAL(5,2)
);

CREATE TABLE customers(
    id SERIAL PRIMARY KEY,
    street VARCHAR,
    city VARCHAR(50),
    zip VARCHAR(10),
    country VARCHAR(20)
);

CREATE TABLE deliveries(
    id SERIAL PRIMARY KEY,
    driver_id BIGINT,
    order_id BIGINT,
    started_delivery TIME,
    completed_delivery TIME
);

CREATE TABLE drivers(
    id SERIAL PRIMARY KEY,
    store_id BIGINT,
    full_name VARCHAR(100)
);

CREATE TABLE order_toppings(
    id SERIAL PRIMARY KEY,
    order_id BIGINT,
    topping_id BIGINT
);

CREATE TABLE orders(
    order_id SERIAL PRIMARY KEY,
    customer_id BIGINT,
    date DATE,
    pizza_type VARCHAR(50),
    store_id INT,
    toppings VARCHAR
);

CREATE TABLE stores(
    id SERIAL PRIMARY KEY,
    location VARCHAR
);

\COPY available_pizzas FROM './stage-1/data/available_pizzas.csv' WITH CSV HEADER;
\COPY available_toppings FROM './stage-1/data/available_toppings.csv' WITH CSV HEADER;
\COPY customers FROM './stage-1/data/customers.csv' WITH CSV HEADER;
\COPY deliveries FROM './stage-1/data/deliveries.csv' WITH CSV HEADER;
\COPY drivers FROM './stage-1/data/drivers.csv' WITH CSV HEADER;
\COPY order_toppings FROM './stage-1/data/order_toppings.csv' WITH CSV HEADER;
\COPY orders FROM './stage-1/data/orders.csv' WITH CSV HEADER;
\COPY stores FROM './stage-1/data/stores.csv' WITH CSV HEADER;