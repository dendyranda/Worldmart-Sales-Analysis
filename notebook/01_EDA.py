"""
===============================================================================
Project     : WorldMart E-Commerce Sales Analysis
Author      : Dendy Randa
Role        : Data Analyst Portfolio Project
Dataset     : Olist Brazilian E-Commerce Dataset
Source      : Kaggle

Notebook    : 01 - Exploratory Data Analysis (EDA)

Description
-----------
This notebook performs an initial exploration of the raw datasets before
loading them into PostgreSQL.

Objectives
----------
1. Load all datasets automatically.
2. Explore dataset dimensions.
3. Assess data quality.
4. Identify missing values.
5. Detect duplicate records.
6. Examine data types.
7. Generate descriptive statistics.
8. Understand categorical and numerical distributions.
9. Produce an EDA summary for data cleaning.

===============================================================================
"""

# Import Libraries
import pandas as pd
import matplotlib.pyplot as plt
import numpy as np
from pathlib import Path

pd.set_option('display.max_columns', None)
pd.set_option('display.max_rows', 100)
plt.style.use("ggplot")

# Import library
import pandas as pd
import matplotlib.pyplot as plt
from pathlib import Path

pd.set_option('display.max_columns', None)
pd.set_option('display.max_rows', 100)


# Load Dataset
data_path = Path("C:/Users/Dendy/OneDrive/Dokumen/ProjekDB/Worldmart/dataset/cleaned")
datasets = {}

for file in data_path.glob("*.csv"):
    datasets[file.stem] = pd.read_csv(file)
    
print(f"Jumlah dataset: {len(datasets)}")
print(list(datasets.keys()))
print(f"Total Dataset : {len(datasets)}\n")

for name in datasets.keys():

    print(name)

# Dataset Dataset
print("="*80)
print("DATASET OVERVIEW")
print("="*80)

for name, df in datasets.items():
    print(f"{name:40} Rows = {df.shape[0]:10} | Columns = {df.shape[1]:10}")

# EDA Function
def perform_eda(df, dataset_name):
    print("\n")
    print("="*100)
    print(dataset_name.upper())
    print("="*100)
    
    # Shape
    print("\n1. Dataset Shape")

    print(f"Rows    : {df.shape[0]}")
    print(f"Columns : {df.shape[1]}")
    
    # Column
    print("\n2. Column Names")
    for column in df.columns:
        print(f"-{column}")
        
    # Data Type
    print("\n3. Data Types")
    print(df.dtypes.to_frame("Data Type"))
    
    # Missing Value
    print("\n4. Missing Values")

    missing = pd.DataFrame({
        "Missing": df.isnull().sum(),
        "Percentage (%)":
            round(df.isnull().mean()*100,2)
    })
    print(missing)
    
    # Duplicate
    print("\n5. Duplicate Rows")
    print(df.duplicated().sum())
    
    # Sample Data
    print("\n6. First Five Rows")
    print(df.head())
    
    # Statitics
    print("\n7. Statistics")
    print(df.describe(include="all"))
    
# Run EDA
for name, df in datasets.items():
    perform_eda(df, name)
    
# Data Quality Summary
Summary = []
for name, df in datasets.items():
    rows = df.shape[0]
    columns = df.shape[1]
    duplicate = df.duplicated().sum()
    missing = df.isnull().sum().sum()
    percent = round(
        missing /
        (rows*columns)
        *100,
        2
    )
    if percent == 0:
        status = "Good"
    elif percent < 5:
        status = "Need Review"
    else:
        status = "Poor"
    Summary.append({
        "Dataset": name,
        "Rows": rows,
        "Columns": columns,
        "Missing": missing,
        "Missing (%)": percent,
        "Duplicate": duplicate,
        "Status": status
    })
Summary = pd.DataFrame(Summary)
Summary

# Save Summary
Summary.to_csv("C:/Users/Dendy/OneDrive/Dokumen/ProjekDB/Worldmart/Data_Quality_Report.csv",index=False)
print("Data Quality Report berhasil disimpan.")

# Missing Value Visualization
for name, df in datasets.items():
    missing = df.isnull().sum()
    missing = missing[missing > 0]
    if missing.empty:
        continue
    plt.figure(figsize=(10,4))
    missing.plot.bar()
    plt.title(f"Missing Value - {name}")
    plt.ylabel("Count")
    plt.xticks(rotation=45)
    plt.tight_layout()
    plt.show()
    
# EDA Conclusion
print("""
EDA Findings
============

1. All datasets were successfully loaded.
2. No duplicate records were identified in most datasets.
3. Missing values exist in several timestamp columns and review comments.
4. Numerical variables show different distributions and potential outliers.
5. Several categorical variables will require validation during data cleaning.
6. Date-related columns are currently stored as object data types and should be converted to datetime.
7. The datasets are generally well-structured and suitable for further cleaning.
""")