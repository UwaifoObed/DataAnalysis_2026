# Data Analysis Project: Missing Data Handling & Outlier Detection

## Overview

This project demonstrates **data preprocessing, missing data exploration, imputation, and outlier detection** using R. The workflow focuses on preparing a dataset for analysis, understanding missing data patterns, imputing missing values with appropriate statistical methods, and detecting outliers using both traditional and density-based approaches.

The goal is to produce a clean dataset suitable for further statistical analysis or modeling while preserving the integrity of the original data.

---

## Dataset Description

* **File Name:** `DataSet_No_Details.csv`

The dataset contains **1,148 observations and 41 variables**, consisting of both **numeric and categorical features** related to biological and clinical measurements.

### Key Characteristics

* **Hormonal Variables:**
  Multiple variables (`hormone1` to `hormone14`) representing different hormone levels, indicating physiological measurements across subjects.

* **Derived Indices:**
  Calculated indices such as `h_index_34` and `h_index_56`, which likely represent relationships or ratios between hormone groups.

* **Lipid Variables:**
  Variables such as `lipids1` to `lipids5`, used for metabolic or biochemical analysis.

* **Categorical Factors:**
  Includes variables such as:

  * `outcome` (binary target variable)
  * `factor_eth` (ethnicity)
  * `factor_h`, `factor_pcos`, `factor_prl` (clinical or diagnostic indicators)

* **Identifier:**

  * `record_id` uniquely identifies each observation.

---

### Data Quality Notes

* The dataset contains **missing values across multiple variables**, with some variables having significant missingness.
* Certain variables (e.g., hormone-related features) exhibit **wide ranges and potential outliers**, making preprocessing essential.
* A mix of **low-missing and high-missing variables** requires careful handling through filtering and imputation techniques.

---

### Purpose of the Dataset

This dataset is suitable for:

* **Missing data analysis and imputation**
* **Exploratory data analysis (EDA)**
* **Outlier detection**
* **Statistical modeling and prediction tasks**

It provides a realistic scenario for applying **data cleaning, transformation, and advanced analytical techniques** in R.

---

## R Environment

* **R Version:** 4.5.3
* **IDE:** RStudio (Windows)
* **Key Packages Used:**

  * `dplyr` – for data manipulation
  * `tidyr` – for data reshaping
  * `ggplot2` – for visualization
  * `skimr` – for detailed data summaries
  * `visdat` – to visualize missing data
  * `naniar` – for missing data analysis and MCAR testing
  * `mice` – for multiple imputation
  * `dbscan` – for Local Outlier Factor (LOF) calculations

---

## Workflow and Tasks

### 1. Data Loading

The dataset was imported from a CSV file into R. The structure and variable types were inspected to understand the data types and initial distribution of numeric and categorical variables.

---

### 2. Exploratory Summary

A detailed summary of the dataset was performed to examine the distributions of numeric variables and overall dataset structure. Summary statistics and visualizations provided insights into potential anomalies and the extent of missing data.

---

### 3. Data Cleaning

Irrelevant or redundant columns were removed to focus analysis on meaningful variables. The dataset was divided into:

* **Main dataset (`MD_df`)** – for numeric and continuous variables
* **Factor dataset (`factor_df`)** – for categorical variables such as demographic factors and outcome variables

---

### 4. Missing Data Analysis

* Total and column-wise missing values were calculated to assess the extent of missingness.
* The percentage of missing values per variable was computed.
* Variables with more than 35% missing values were identified separately to determine if they should be excluded or handled differently.

---

### 5. Missing Data Visualization

Missing data patterns were visualized using matrix-style and bar plots to identify which variables and observations had the most missing information. This step helps in understanding the structure of missingness and planning the imputation strategy.

---

### 6. Impact of Missing Data

Variables with excessive missing values that could negatively impact imputation were removed. The remaining dataset was considered for statistical testing and imputation.

---

### 7. Statistical Test for Missingness (Little’s MCAR Test)

Little’s MCAR test was performed to assess whether missing values were **Missing Completely At Random (MCAR)**:

* **Null Hypothesis (H₀):** Data is MCAR
* **Alternative Hypothesis (H₁):** Data is not MCAR
  A p-value greater than 0.05 indicates that the missing data can be considered MCAR, allowing for valid imputation.

---

### 8. Multiple Imputation

Two imputation methods were applied to handle missing values:

1. **Predictive Mean Matching (PMM):**

   * Imputes missing numeric values while preserving realistic distributions.
   * Suitable for general numeric data.

2. **Random Forest (RF):**

   * Uses ensemble learning to model complex nonlinear relationships for imputation.
   * Appropriate for datasets with interactions and nonlinear patterns among variables.

The imputed datasets were saved separately for reproducibility and further analysis.

---

### 9. Visual Validation of Imputation

Density plots were generated to compare original and imputed values for key variables, ensuring that imputation preserved the underlying distribution of the data.

---

### 10. Outlier Detection

Outlier detection was performed using two approaches:

1. **Boxplots:**

   * Traditional visualization of numeric variables to detect extreme values.
   * Outliers were inspected across both individual variables and the entire numeric dataset.

2. **Local Outlier Factor (LOF):**

   * A density-based method that identifies multivariate outliers considering the local density of observations.
   * LOF scores were visualized in histograms and scatterplots, highlighting extreme points in the dataset.

---

## Output Files

* **Original dataset:** `DataSet_No_Details.csv`
* **Imputed datasets:**

  * `imputed_dataset_pmm.csv` (PMM method)
  * `imputed_dataset_rf.csv` (Random Forest method)
* **Graphs:** Plots illustrating missing data patterns, imputation validation, boxplots for outlier detection, and LOF scatterplots

---

## Notes

* Packages must be installed from CRAN for reproducibility.
* File paths may need adjustment to match local system directories.
* PMM is recommended for general numeric imputation, whereas RF is suitable for complex datasets with nonlinear interactions.
* All steps were performed to ensure the dataset is clean, imputed, and outlier-checked, ready for further statistical analysis or modeling.
