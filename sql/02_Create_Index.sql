/*
===============================================================================
Project     : WorldMart E-Commerce Sales Analysis
Author      : Dendy Randa
Role        : Data Analyst Portfolio Project
Database    : PostgreSQL

File        : 02_Create_Indexes.sql

Description
-----------
This script creates indexes on frequently queried columns to improve
query performance.

Indexes are created after all tables have been defined.

The indexed columns mainly support:

- JOIN operations
- WHERE filters
- Aggregation queries
- Business analysis reports

===============================================================================
*/

CREATE INDEX idx_orders_customers
ON orders(customer_id);

CREATE INDEX idx_order_items_order
ON orders_item(order_id);

CREATE INDEX idx_order_items_product
ON orders_item(product_id);

CREATE INDEX idx_order_items_seller
ON orders_item(seller_id);

CREATE INDEX idx_products_category_name
ON products(category_name);

CREATE INDEX idx_payments_order
ON payments(order_id);

CREATE INDEX idx_reviews_order
ON reviews(order_id);