DROP TABLE IF EXISTS available_pizzas, available_toppings, customers, deliveries, drivers, order_toppings, orders, stores;

CREATE TABLE stores(
    id SERIAL PRIMARY KEY,
    location VARCHAR
);

CREATE TABLE available_pizzas(
    id SERIAL PRIMARY KEY,
    name VARCHAR(50)
        CHECK(name IN('small', 'medium', 'large')),
    cost DECIMAL(5, 2)
);

CREATE TABLE available_toppings(
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    cost_per_pizza DECIMAL(5,2) NOT NULL
);

CREATE TABLE customers(
    id SERIAL PRIMARY KEY,
    street VARCHAR(200) NOT NULL,
    city VARCHAR(50) NOT NULL,
    zip VARCHAR(10) NOT NULL,
    country VARCHAR(20) NOT NULL
);

CREATE TABLE drivers(
    id SERIAL PRIMARY KEY,
    store_id INT NOT NULL,
    full_name VARCHAR(100) NOT NULL
        CHECK(full_name ~ '^[A-Z][a-z0-9]*(?:-[A-Z][a-z0-9]*)*(?: [A-Z0-9][a-z0-9]*(?:-[A-Z0-9][a-z0-9]*)*)*$'),
    FOREIGN KEY (store_id) REFERENCES stores(id)
);

CREATE TABLE orders(
    order_id SERIAL PRIMARY KEY,
    customer_id BIGINT NOT NULL,
    date DATE NOT NULL,
    pizza_type INT NOT NULL
        CHECK (pizza_type IN (1, 2, 3)),
    store_id INT,
    toppings VARCHAR, -- UNSURE about this, a many-to-many relationship was created, but the csv file still have the toppings column. hat to do?
    FOREIGN KEY (store_id) REFERENCES stores(id)
);

CREATE TABLE order_toppings(
    id SERIAL PRIMARY KEY,
    order_id INT,
    topping_id INT,  
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (topping_id) REFERENCES available_toppings(id)
);

CREATE TABLE deliveries(
    id SERIAL PRIMARY KEY,
    driver_id INT,
    order_id INT UNIQUE,
    started_delivery TIME NOT NULL,
    completed_delivery TIME NOT NULL,
    FOREIGN KEY (driver_id) REFERENCES drivers(id),
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);



\COPY stores FROM './stage-1/data/stores.csv' WITH CSV HEADER;
\COPY available_pizzas FROM './stage-1/data/available_pizzas.csv' WITH CSV HEADER;
\COPY available_toppings FROM './stage-1/data/available_toppings.csv' WITH CSV HEADER;
\COPY customers FROM './stage-1/data/customers.csv' WITH CSV HEADER;
\COPY drivers FROM './stage-1/data/drivers.csv' WITH CSV HEADER;
\COPY orders FROM './stage-1/data/orders.csv' WITH CSV HEADER;
\COPY order_toppings FROM './stage-1/data/order_toppings.csv' WITH CSV HEADER;
\COPY deliveries FROM './stage-1/data/deliveries.csv' WITH CSV HEADER;