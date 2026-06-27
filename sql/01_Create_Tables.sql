/*
===============================================================================
Project     : WorldMart E-Commerce Sales Analysis
Author      : Dendy Randa
Role        : Data Analyst Portfolio Project
Database    : PostgreSQL

File        : 01_Create_Tables.sql

Description
-----------
This script creates the relational database schema for the WorldMart
e-commerce project.

The database consists of the following tables:

1. customers
2. orders
3. categories
4. products
5. sellers
6. orders_item
7. payments
8. reviews

Relationships between tables are implemented using primary keys
and foreign key constraints to ensure referential integrity.

===============================================================================
*/

CREATE TABLE customers(
	customer_id	VARCHAR(50) PRIMARY KEY,
	customer_unique_id VARCHAR(50),
	customer_zip_code_prefix INT,
	customer_city VARCHAR(100), 
	customer_state CHAR(2)
);

CREATE TABLE orders(
	order_id VARCHAR(50) PRIMARY KEY,
	customer_id VARCHAR(50),
	order_status VARCHAR(20) 
	CHECK (
		order_status IN
		(
			'created',
			'approved',
			'invoiced',
			'processing',
			'shipped',
			'delivered',
			'canceled',
			'unavailable'
		)
	),
	purchase_timestamp TIMESTAMP,
	approved_at TIMESTAMP,
	delivered_carrier_date TIMESTAMP,
	delivered_customer_date TIMESTAMP,
	estimated_delivery_date TIMESTAMP,
	CONSTRAINT fk_customer_id FOREIGN KEY(customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE categories(
	category_name VARCHAR(100) PRIMARY KEY,
	category_name_english VARCHAR(100)
	
);

CREATE TABLE products(
	product_id VARCHAR(50) NOT NULL PRIMARY KEY,
	category_name VARCHAR(100),
	product_name_length NUMERIC(10,2),
	product_description_length NUMERIC(10,2),
	product_photos_qty  NUMERIC(10,2),
	product_weight_g  NUMERIC(10,2),
	product_length_cm NUMERIC(8,2),
	product_height_cm NUMERIC(8,2),
	product_width_cm NUMERIC(8,2),
	CONSTRAINT fk_products_category_name FOREIGN KEY(category_name) REFERENCES categories(category_name)
);

CREATE TABLE sellers(
	seller_id VARCHAR(50) PRIMARY KEY,
	seller_zip_code_prefix INT,
	seller_city VARCHAR(100),
	seller_state CHAR(2)
);

CREATE TABLE orders_item(
	order_id VARCHAR(50),
	order_item_id INT,
	product_id VARCHAR(50),
	seller_id VARCHAR(50),
	shipping_limit_date TIMESTAMP,
	price NUMERIC(10,2),
	freight_value NUMERIC(10,2),
	CONSTRAINT fk_order_item_id FOREIGN KEY(order_id) REFERENCES orders(order_id),
	CONSTRAINT fk_order_item_product FOREIGN KEY(product_id) REFERENCES products(product_id),
	CONSTRAINT fk_order_item_seller FOREIGN KEY(seller_id) REFERENCES sellers(seller_id)
);


CREATE TABLE payments(
	payment_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	order_id VARCHAR(50),
	payment_sequential INT,
	payment_type VARCHAR(30)
	CHECK(
		payment_type IN 
		(
		'credit_card',
		'boleto',
		'voucher',
		'debit_card',
		'not_defined'
		)
	),
	payment_installments INT,
	payment_value NUMERIC(10,2),
	CONSTRAINT fk_payment_order_id FOREIGN KEY(order_id) REFERENCES orders(order_id)
);


CREATE TABLE reviews(
	review_id VARCHAR(50),
	order_id VARCHAR(50),
	review_score INT,
	review_comment_title TEXT,
	review_comment_message TEXT,
	review_creation_date DATE,
	review_answer_timestamp TIMESTAMP,
	CONSTRAINT fk_reviews_order_id FOREIGN KEY(order_id) REFERENCES orders(order_id)
);
