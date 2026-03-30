# Data Manipulation and Cleaning

## Overview
This module focuses on exploring, cleaning, and preparing the dataset `DataSet_No_Details.csv` for further analysis. It includes missing data identification, imputation, and outlier detection using R.

## Dataset
- File: `DataSet_No_Details.csv`
- Source: Local machine
- Number of observations: [insert number]
- Number of variables: [insert number]

## R Version
- R 4.5 (Windows 10)
- RStudio IDE

## Procedures Used

1. **Data Loading & Exploration**
   - Read CSV file using `read.csv()`
   - Structure and summary using `str()`, `summary()`, `skim()`

2. **Data Cleaning**
   - Removed irrelevant columns
   - Checked for missing values per column
   - Filtered variables based on missingness threshold (≤ 35%)

3. **Missing Data Visualization**
   - `visdat::vis_miss()` to visualize missing patterns
   - `naniar::gg_miss_var()` to generate missing value barplots

4. **Missing Data Analysis**
   - Performed Little’s MCAR test using `naniar::mcar_test()`
   - Hypotheses:
     - H₀: Data is Missing Completely At Random
     - H₁: Data is not MCAR

5. **Imputation**
   - Multiple Imputation using `mice`
   - Methods:
     - Random Forest (RF)
     - Predictive Mean Matching (PMM)
   - Imputed datasets saved as:
     - `imputed_dataset_rf.csv`
     - `imputed_dataset_pmm.csv`
   - Visual comparison using density plots (`ggplot2`)

6. **Outlier Detection**
   - Boxplots for numeric variables
   - Local Outlier Factor (LOF) using `dbscan`
   - Bivariate scatterplots with outliers highlighted

## Files in this Folder
| File | Description |
|------|-------------|
| `data_cleaning_code.R` | R script with data preprocessing and imputation |
| `DataSet_No_Details.csv` | Original dataset |
| `imputed_dataset_rf.csv` | RF imputed dataset |
| `imputed_dataset_pmm.csv` | PMM imputed dataset |
| `graphs/` | Folder containing plots generated in analysis |
| `additional_outputs/` | Optional CSVs with summaries and stats |

## Output Examples
- Density plot comparing original vs imputed values for `hormone10_generated`  
- Boxplots for outlier detection  
- LOF scatterplots highlighting extreme observations  
