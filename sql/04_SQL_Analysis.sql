/*
===============================================================================
Project     : WorldMart E-Commerce Sales Analysis
Author      : Dendy Randa
Role        : Data Analyst Portfolio Project
Database    : PostgreSQL
Dataset     : Olist Brazilian E-Commerce Dataset

File        : 04_SQL_Analysis.sql

Description
-----------
This SQL script contains business analysis queries for the WorldMart
E-Commerce database.

Analysis Sections
-----------------
1 : Database Overview
2 : Customer Analysis
3 : Order Analysis
4 : Product Analysis
5 : Seller Analysis
6 : Payment Analysis
7 : Delivery Analysis
8 : Customer Review Analysis

===============================================================================
*/

/*
===============================================================================
1 : DATABASE OVERVIEW
===============================================================================

Business Goal
-------------
Understand the overall size and structure of the database before conducting
business analysis.
*/

-- Number of customers
SELECT COUNT(*)
FROM customers;

-- Number of orders
SELECT COUNT(*)
FROM orders;

-- Number of sellers
SELECT COUNT(*)
FROM sellers;

-- Number of products
SELECT COUNT(*)
FROM products;

-- Number of categories
SELECT COUNT(*)
FROM categories;

-- Number of payments
SELECT COUNT(*)
FROM payments;

-- Number of reviews
SELECT COUNT(*)
FROM reviews;

/*
===============================================================================
2 : CUSTOMER ANALYSIS
===============================================================================

Business Goal
-------------
Analyze customer distribution across cities and states.

*/

-- Number of customers per state
SELECT customer_state,
	   COUNT(*) AS total_customer
FROM customers
GROUP BY customer_state
ORDER BY total_customer DESC;

-- Top 10 cities
SELECT customer_city,
	   COUNT(*) AS total_customer
FROM customers
GROUP BY customer_city
ORDER BY total_customer DESC
Limit 10;

--Number of unique customers
SELECT COUNT(DISTINCT customer_unique_id)
FROM customers;

/*
===============================================================================
3 : ORDER ANALYSIS
===============================================================================

Business Goal
-------------
Understand order trends, purchasing activity, and order status.

*/

-- Status Orders
SELECT order_status,
	   COUNT(*) AS total
FROM orders
GROUP BY order_status
ORDER BY total DESC;

-- Monthly Orders
SELECT DATE_TRUNC('month', purchase_timestamp) AS month,
	   COUNT(*) AS total_orders
FROM orders
GROUP BY month
ORDER BY month;

-- Annual Orders
SELECT DATE_TRUNC('year', purchase_timestamp) AS year,
	   COUNT(*) AS total_orders
FROM orders
GROUP BY year
ORDER BY year;

-- Daily Orders
SELECT DATE_TRUNC('day', purchase_timestamp) AS day,
	   COUNT(*) AS total_orders
FROM orders
GROUP BY day
ORDER BY day;

/*
===============================================================================
4 : PRODUCT ANALYSIS
===============================================================================

Business Goal
-------------
Identify product performance, best-selling categories,
and product pricing.

*/

-- Top Categoiries
SELECT c.category_name_english,
	   COUNT(*) AS total_product
FROM products AS p
INNER JOIN categories as c ON (p.category_name = c.category_name)
GROUP BY c.category_name_english
ORDER BY total_product DESC
LIMIT 10;

-- Revenue by category
SELECT c.category_name_english,
	   ROUND(sum(oi.price), 2) AS total_revenue
FROM orders_item as oi
INNER JOIN products as p ON (oi.product_id=p.product_id)
INNER JOIN categories as c ON (p.category_name=c.category_name)
GROUP BY c.category_name_english
ORDER BY total_revenue DESC;

-- Top 10 Best Selling Products
SELECT oi.product_id,
	   COUNT(*) AS total_items_sold,
ROUND(sum(oi.price), 2) AS total_revenue
FROM orders_item AS  oi
GROUP BY oi.product_id
ORDER BY total_items_sold DESC
LIMIT 10;

-- Most Expensive Products
SELECT product_id,
	   MAX(price) AS highest_price
FROM orders_item
GROUP BY product_id
ORDER BY highest_price DESC
LIMIT 10;

-- Average Product Price
SELECT ROUND(AVG(price), 2) AS average_product_price
FROM orders_item;

/*
===============================================================================
PART 5 : SELLER ANALYSIS
===============================================================================

Business Goal
-------------
Evaluate seller performance and identify the highest
contributing sellers.

*/

-- Top Sellers by Number of Products Sold
SELECT s.seller_id,
	   COUNT(*) AS total_products_sold
FROM sellers AS s
INNER JOIN orders_item AS oi ON (s.seller_id = oi.seller_id)
GROUP BY s.seller_id
ORDER BY total_products_sold DESC
LIMIT 10;

-- Sellers by City
SELECT seller_city,
	   COUNT(*) AS total_sellers
FROM sellers
GROUP BY seller_city
ORDER BY total_sellers DESC
LIMIT 10;

--Sellers by State
SELECT seller_state,
	   COUNT(*) AS total_sellers
FROM sellers
GROUP BY seller_state
ORDER BY total_sellers DESC
LIMIT 10;

/*
===============================================================================
6 : PAYMENT ANALYSIS
===============================================================================

Business Goal
-------------
Analyze customer payment behavior.

*/

-- Payment Method Distribution
SELECT payment_type,
	   COUNT(*) AS total_transaction
FROM payments
GROUP BY payment_type
ORDER BY total_transaction DESC;

-- Revenue by Payment Type
SELECT payment_type,
	   ROUND(SUM(payment_value), 2) AS total_revenue
FROM payments
GROUP by payment_type
ORDER BY total_revenue DESC;

-- Average Installments
SELECT ROUND(AVG(payment_installments), 2) AS average_installments
FROM payments;

-- Average Payment Value
SELECT ROUND(AVG(payment_value), 2) AS average_payment
FROM payments;

/*
===============================================================================
PART 7 : DELIVERY ANALYSIS
===============================================================================

Business Goal
-------------
Measure shipping performance and delivery efficiency.

*/

-- Average Delivery Time
SELECT
    ROUND(
        AVG(
            delivered_customer_date::DATE -
            purchase_timestamp::DATE
        ), 2) AS average_delivery_days
FROM orders
WHERE delivered_customer_date IS NOT NULL;

-- Average Shipping Delay
SELECT
    ROUND(
        AVG(
            delivered_carrier_date::DATE -
            approved_at::DATE
        ), 2) AS average_shipping_delay
FROM orders
WHERE approved_at IS NOT NULL
AND delivered_carrier_date IS NOT NULL;

-- Late Deliveries
SELECT COUNT(*) AS late_deliveries
FROM orders
WHERE delivered_customer_date > estimated_delivery_date;

-- On Time Deliveries
SELECT COUNT(*) AS late_deliveries
FROM orders
WHERE delivered_customer_date <= estimated_delivery_date;

/*
===============================================================================
PART 8 : CUSTOMER REVIEW ANALYSIS
===============================================================================

Business Goal
-------------
Evaluate customer satisfaction using review data.

*/

-- Review Score Distribution
SELECT review_score,
       COUNT(*) AS total_reviews
FROM reviews
GROUP BY review_score
ORDER BY review_score;

-- Average Review Score
SELECT ROUND(AVG(review_score),2) AS average_review
FROM reviews;

-- Review Sentiment
SELECT CASE WHEN review_score >= 4 THEN 'Positive'
            WHEN review_score = 3 THEN 'Neutral'
            ELSE 'Negative'
       END AS sentiment,
       COUNT(*) AS total_reviews
FROM reviews
GROUP BY sentiment
ORDER BY total_reviews DESC;

-- Average Review by Order Status
SELECT o.order_status,
	   ROUND(AVG(r.review_score),2) AS average_review
FROM orders AS o
JOIN reviews AS r ON (o.order_id = r.order_id)
GROUP BY o.order_status
ORDER BY average_review DESC;

-- Lowest Rated Orders
SELECT order_id,
       review_score
FROM reviews
WHERE review_score = 1
ORDER BY order_id;