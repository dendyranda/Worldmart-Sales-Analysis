"""
===============================================================================
Project     : WorldMart E-Commerce Sales Analysis
Author      : Dendy Randa
Role        : Data Analyst Portfolio Project
Dataset     : Olist Brazilian E-Commerce Dataset

Notebook    : 02 - Data Cleaning

Description
-----------
This notebook prepares the raw datasets for PostgreSQL and business analysis.

Cleaning Objectives
-------------------
1. Remove unnecessary whitespaces.
2. Detect duplicate records.
3. Assess missing values.
4. Convert date columns.
5. Validate categorical values.
6. Validate numerical values.
7. Save cleaned datasets.
8. Generate cleaning summary.

===============================================================================
"""

# Import Libraries
import pandas as pd
import numpy as np
from pathlib import Path
pd.set_option("display.max_columns", None)

# Project Configuration
RAW_DATA_PATH = Path("C:/Users/Dendy/OneDrive/Dokumen/ProjekDB/Worldmart/dataset/raw")
CLEAN_DATA_PATH = Path("C:/Users/Dendy/OneDrive/Dokumen/ProjekDB/Worldmart/dataset/cleaned")
CLEAN_DATA_PATH.mkdir(exist_ok=True)

# Load Dataset
data_path = Path("C:/Users/Dendy/OneDrive/Dokumen/ProjekDB/Worldmart/dataset/raw")
datasets = {}

for file in data_path.glob("*.csv"):
    datasets[file.stem] = pd.read_csv(file)
    
print(f"Jumlah dataset: {len(datasets)}")
print(list(datasets.keys()))
print(f"Total Dataset : {len(datasets)}\n")

for name in datasets.keys():

    print(name)
    
# Cleaning Report
cleaning_report = []

# Remove Whitespaces
for name, df in datasets.items():

    object_columns = df.select_dtypes(include="object").columns
    for column in object_columns:
        df[column] = df[column].str.strip()

    cleaning_report.append({
        "Dataset": name,
        "Action": "Trim whitespace",
        "Status": "Completed"
    })
print("Whitespace removal completed.")

# Duplicate Check
for name, df in datasets.items():
    duplicate_before = df.duplicated().sum()
    df.drop_duplicates(inplace=True)
    duplicate_after = df.duplicated().sum()
    cleaning_report.append({
        "Dataset": name,
        "Action": "Remove duplicate",
        "Before": duplicate_before,
        "After": duplicate_after
    })
print("Duplicate validation completed.")

# Missing Value Analysis
for name, df in datasets.items():
    print("="*70)
    print(name)
    print("="*70)
    missing = pd.DataFrame({
        "Missing Values": df.isnull().sum(),
        "Percentage (%)":
            round(df.isnull().mean()*100,2)
    })
    print(missing[missing["Missing Values"]>0])
    

# Missing Value Decision
missing_decision = pd.DataFrame({

"Column":[
"order_approved_at",
"order_delivered_carrier_date",
"order_delivered_customer_date",
"review_comment_title",
"review_comment_message"

],

"Decision":[
"Keep",
"Keep",
"Keep",
"Keep",
"Keep"
],

"Reason":[
"Order may not be approved.",
"Order may not be shipped.",
"Order may not be delivered.",
"Customer may submit rating only.",
"Review comment is optional."
]
})

missing_decision

# Convert Data Columns
date_columns = [
"order_purchase_timestamp",
"order_approved_at",
"order_delivered_carrier_date",
"order_delivered_customer_date",
"order_estimated_delivery_date",
"shipping_limit_date",
"review_creation_date",
"review_answer_timestamp"
]

for name, df in datasets.items():
    for column in date_columns:
        if column in df.columns:
            df[column] = pd.to_datetime(
                df[column],
                errors="coerce"
            )
print("Datetime conversion completed.")

# Validate Order Status
orders = datasets["olist_orders_dataset"]
print(orders["order_status"].value_counts())

# Validate Payment Type
payments = datasets["olist_order_payments_dataset"]
print(payments["payment_type"].value_counts())

# Validate Review Score
reviews = datasets["olist_order_reviews_dataset"]
print(reviews["review_score"].value_counts().sort_index())

# Check Negative Values
items = datasets["olist_order_items_dataset"]
print("="*50)
print("Negative Price")
print("="*50)
print((items["price"]<0).sum())
print("="*50)
print("Negative Freight")
print("="*50)
print((items["freight_value"]<0).sum())

# Export Clean Dataset
for name, df in datasets.items():
    df.to_csv(
        CLEAN_DATA_PATH /
        f"{name}.csv",
        index=False
    )
print("Clean datasets successfully exported.")

# Cleaning Summary
cleaning_report = pd.DataFrame(cleaning_report)
cleaning_report

# Save Cleaning Summary
cleaning_report.to_csv("C:/Users/Dendy/OneDrive/Dokumen/ProjekDB/Worldmart/Cleaning_Report.csv",index=False)
print("Cleaning report successfully saved.")

# Final Summary
print("""
===============================================================================

DATA CLEANING SUMMARY

===============================================================================

✓ Raw datasets successfully loaded.

✓ Leading and trailing whitespaces removed.

✓ Duplicate records validated.

✓ Missing values assessed and documented.

✓ Date columns converted to datetime.

✓ Categorical variables validated.

✓ Numerical variables validated.

✓ Clean datasets exported.

Next Step:
Import cleaned datasets into PostgreSQL.

===============================================================================
""")
