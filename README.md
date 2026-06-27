# 📊 WorldMart E-Commerce Sales Analysis

> End-to-End Data Analyst Portfolio Project using **PostgreSQL, Python, SQL, and Power BI**

---

## 📖 Project Overview

This project analyzes the **Olist Brazilian E-Commerce Dataset** to generate business insights through an end-to-end data analytics workflow.

The project covers the complete data analysis lifecycle, including:

- Exploratory Data Analysis (EDA)
- Data Cleaning
- Relational Database Design
- Data Import into PostgreSQL
- SQL Business Analysis
- Interactive Dashboard Development using Power BI

The objective is to transform raw transactional data into meaningful business insights that support strategic decision-making.

---

## 🎯 Business Objectives

This project aims to answer several business questions, including:

- How many customers, orders, and sellers are in the database?
- What is the overall revenue generated?
- Which product categories generate the highest revenue?
- Which sellers contribute the most sales?
- Which payment methods are preferred by customers?
- How well does the delivery process perform?
- How satisfied are customers based on review scores?

---

# 🛠 Tech Stack

| Category | Tools |
|-----------|------|
| Programming | Python |
| Data Analysis | Pandas, NumPy |
| Database | PostgreSQL |
| Query Language | SQL |
| Visualization | Power BI |
| Version Control | Git & GitHub |

---

# 📂 Project Structure

```
WorldMart-Sales-Analysis
│
├── dataset
│   ├── raw
│   └── cleaned
│
├── python
│   ├── 01_EDA.py
│   └── 02_Data_Cleaning.py
│
├── sql
│   ├── 01_Create_Tables.sql
│   ├── 02_Create_Indexes.sql
│   ├── 03_Import_Data.sql
│   └── 04_SQL_Analysis.sql
│
├── powerbi
│   └── WorldMart_Sales_Dashboard.pbix
│
├── dashboard
│   ├── Executive_Overview.png
│   ├── Sales_Customer_Analysis.png
│   └── Product_Customer_Satisfaction.png
│
├── README.md
├── requirements.txt
└── LICENSE
```

---

# 🔄 Project Workflow

```
Raw Dataset
      │
      ▼
Exploratory Data Analysis (Python)
      │
      ▼
Data Cleaning (Python)
      │
      ▼
Clean Dataset
      │
      ▼
PostgreSQL Database Design
      │
      ▼
Import CSV into PostgreSQL
      │
      ▼
SQL Business Analysis
      │
      ▼
Power BI Dashboard
```

---

# 🗄 Database Schema

The database consists of eight relational tables.

| Table | Description |
|--------|-------------|
| customers | Customer information |
| orders | Customer orders |
| categories | Product categories |
| products | Product details |
| sellers | Seller information |
| orders_item | Order transaction details |
| payments | Payment information |
| reviews | Customer reviews |

---

# 🔍 SQL Analysis

The SQL analysis is divided into eight business sections.

### Part 1 — Database Overview

- Total Customers
- Total Orders
- Total Sellers
- Total Products
- Total Revenue

### Part 2 — Customer Analysis

- Customers by State
- Customers by City
- Top Customer Locations

### Part 3 — Order Analysis

- Orders by Status
- Monthly Orders
- Monthly Revenue

### Part 4 — Product Analysis

- Revenue by Category
- Top Selling Products
- Most Expensive Products
- Average Product Price

### Part 5 — Seller Analysis

- Top Sellers
- Revenue by Seller
- Seller Distribution

### Part 6 — Payment Analysis

- Payment Method Distribution
- Installment Analysis

### Part 7 — Delivery Analysis

- On-time Delivery
- Late Delivery
- Average Delivery Time

### Part 8 — Customer Review Analysis

- Review Score Distribution
- Average Review Score

---

# 📊 Dashboard

## Executive Overview

Displays the overall business performance including:

- Total Revenue
- Total Orders
- Total Customers
- Total Sellers
- Revenue Trend
- Order Trend

```
(Add screenshot here)
```

---

## Sales & Customer Analysis

Displays:

- Revenue by Seller
- Customer Distribution
- Payment Method Distribution

```
(Add screenshot here)
```

---

## Product & Customer Satisfaction Analysis

Displays:

- Revenue by Product
- Delivery Performance
- Customer Review Distribution

```
(Add screenshot here)
```

---

# 💡 Key Business Insights

- Generated revenue reached approximately **13.6 million**.
- The majority of customers are located in **São Paulo (SP)**.
- Credit Card is the most frequently used payment method.
- Most deliveries were completed on time.
- Review score **5** dominates customer feedback.
- Revenue is concentrated among a relatively small number of products and sellers.

---

# 📈 Skills Demonstrated

✔ Exploratory Data Analysis (EDA)

✔ Data Cleaning

✔ Data Validation

✔ Relational Database Design

✔ PostgreSQL

✔ SQL Query Writing

✔ SQL JOIN

✔ Aggregation

✔ Window Functions

✔ Data Visualization

✔ Dashboard Development

✔ Business Analysis

---

# 📚 Dataset

Dataset used in this project:

**Olist Brazilian E-Commerce Public Dataset**

https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce

---

# 👨‍💻 Author

**Dendy Randa**

Physics Graduate | Aspiring Data Analyst

GitHub: *(Add your GitHub profile)*

LinkedIn: *(Add your LinkedIn profile)*

---

# ⭐ If you found this project helpful, feel free to give it a star!
