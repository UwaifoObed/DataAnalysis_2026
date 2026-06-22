# Diabetes Correlation Analysis using R

## Overview

This project investigates relationships between clinical, demographic, and familial risk characteristics and diabetes status using the Pima Indians Diabetes Dataset.

The analysis was conducted as part of a Master's Data Analysis course and focuses on correlation analysis rather than predictive modeling. Pearson, Spearman, and Point-Biserial correlation methods were used to examine associations between selected variables and diabetes status.

## Research Question

How are selected clinical, demographic, and familial risk characteristics related to diabetes status and to one another among women in the Pima Indians Diabetes Dataset?

## Dataset

Dataset: Pima Indians Diabetes Dataset

The dataset contains information collected from adult women of Pima Indian heritage and includes:

- Pregnancies
- Glucose
- Blood Pressure
- BMI
- Diabetes Pedigree Function
- Age
- Outcome (Diabetes Status)

Original variables Insulin and SkinThickness were excluded due to extensive missing values represented by biologically impossible zero measurements.

## Data Cleaning

The following preprocessing steps were performed:

1. Replaced biologically impossible values with NA:
   - BloodPressure = 0
   - BMI = 0
   - Glucose = 0

2. Removed variables with substantial missingness:
   - Insulin
   - SkinThickness

3. Applied listwise deletion using `na.omit()`.

### Dataset Size

- Original observations: 768
- Final observations after cleaning: 724

## Statistical Methods

### Point-Biserial Correlation

Used to examine relationships between diabetes status (Outcome) and:

- Glucose
- BMI
- Age
- BloodPressure

### Pearson Correlation

Used for approximately linear and symmetric relationships:

- Glucose ↔ BMI
- Age ↔ BloodPressure

### Spearman Correlation

Used for non-normal or ordinal/count data relationships:

- Age ↔ Pregnancies
- Pregnancies ↔ BMI
- Pregnancies ↔ Glucose
- DiabetesPedigreeFunction ↔ Glucose
- DiabetesPedigreeFunction ↔ BMI

## Visualizations

The project includes:

- Histograms
- Scatterplots with regression lines
- Boxplots
- Correlation heatmap

## Key Findings

### Diabetes Status

Strongest associations:

1. Glucose (r ≈ 0.49)
2. BMI (r ≈ 0.30)

Weaker but significant associations:

- Age (r ≈ 0.25)
- Blood Pressure (r ≈ 0.17)

### Relationships Between Variables

- Age and Pregnancies showed a strong positive association.
- Glucose and BMI showed a weak positive relationship.
- Diabetes Pedigree Function demonstrated weak associations with Glucose and BMI.
- Pregnancies and BMI showed no meaningful relationship.

### Blood Pressure Analysis

A supplementary comparison showed that participants with diabetes had significantly higher mean blood pressure than participants without diabetes.

## Limitations

- Cross-sectional data cannot establish causality.
- Listwise deletion reduced sample size.
- Insulin and SkinThickness were excluded due to extensive missing data.
- Multiple comparisons were conducted without formal correction procedures.
- Results are specific to women of Pima Indian heritage and may not generalize to other populations.

## Tools Used

- R
- corrplot
- Base R statistical functions
- RStudio

## Repository Structure

```
Final-Project/
│
├── diabetes.csv
├── correlation_analysis.R
├── Output/
│   ├── histograms
│   ├── scatterplots
│   ├── heatmap
│   └── boxplots
├── Final_Report.pdf
└── README.md
```

## References

- Field, A., Miles, J., & Field, Z. (2012). *Discovering Statistics Using R*. SAGE Publications.
- Knowler, W. C., Bennett, P. H., Hamman, R. F., & Miller, M. (1978). *American Journal of Epidemiology*, 108(6), 497–505.
- World Health Organization. Diabetes Fact Sheet.
- R Core Team. *R: A Language and Environment for Statistical Computing*.

## Author

Uwaifo Obed
