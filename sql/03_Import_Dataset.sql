/*
===============================================================================
Project     : WorldMart E-Commerce Sales Analysis
Author      : Dendy Randa
Role        : Data Analyst Portfolio Project
Database    : PostgreSQL

File        : 03_Import_Data.sql

Description
-----------
This script imports the cleaned CSV datasets into PostgreSQL tables
using the COPY command.

Import order is important because of foreign key dependencies.

Import Sequence

1. customers
2. categories
3. products
4. sellers
5. orders
6. orders_item
7. payments
8. reviews

All CSV files are generated from the data cleaning process.

===============================================================================
*/

Copy customers
FROM 'C:\ProjekDB\Worldmart\dataset\cleaned\olist_customers_dataset.csv'
DELIMITER ','
CSV HEADER;

SELECT * FROM customers;

Copy categories
FROM 'C:\ProjekDB\Worldmart\dataset\cleaned\product_category_name_translation.csv'
DELIMITER ','
CSV HEADER;

SELECT * FROM categories;

INSERT INTO categories(category_name, category_name_english)
VALUES ('pc_gamer', 'pc_gamer'),
	   ('portateis_cozinha_e_preparadores_de_alimentos', 'portateis_cozinha_e_preparadores_de_alimentos');

Copy products
FROM 'C:\ProjekDB\Worldmart\dataset\cleaned\olist_products_dataset.csv'
DELIMITER ','
CSV HEADER;

SELECT * FROM products;

Copy sellers
FROM 'C:\ProjekDB\Worldmart\dataset\cleaned\olist_sellers_dataset.csv'
DELIMITER ','
CSV HEADER;

SELECT * FROM sellers;

Copy orders
FROM 'C:\ProjekDB\Worldmart\dataset\cleaned\olist_orders_dataset.csv'
DELIMITER ','
CSV HEADER;

SELECT * FROM orders;

Copy orders_item 
FROM 'C:\ProjekDB\Worldmart\dataset\cleaned\olist_order_items_dataset.csv'
DELIMITER ','
CSV HEADER;

SELECT * FROM orders;

Copy payments (order_id, payment_sequential, payment_type, payment_installments, payment_value)
FROM 'C:\ProjekDB\Worldmart\dataset\cleaned\olist_order_payments_dataset.csv'
DELIMITER ','
CSV HEADER;

SELECT * FROM payments;

Copy reviews
FROM 'C:\ProjekDB\Worldmart\dataset\cleaned\olist_order_reviews_dataset.csv'
DELIMITER ','
CSV HEADER;