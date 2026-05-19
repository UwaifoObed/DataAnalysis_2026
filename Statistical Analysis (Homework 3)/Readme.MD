# Hormonal Data Statistical Analysis in R

## Project Overview

This project performs a complete statistical analysis of the dataset `data_for_analysis.csv` using the R programming language. The analysis focuses on comparing hormone/lipid variables between two independent outcome groups and evaluating their statistical properties using both parametric and non-parametric methods.

The project was developed as part of a laboratory/data analysis assignment and includes:

- Descriptive statistics
- Normality testing
- Homogeneity of variance testing
- Comparative statistical tests
- Correlation analysis
- Exploratory Data Analysis (EDA)
- Publication-style summary tables
- Visualization of distributions and correlations

---

# Tasks

The following tasks were completed:

1. Create descriptive statistics tables for all hormone variables by group.
2. Perform:
   - Shapiro-Wilk normality tests
   - Levene’s Test for Homogeneity of Variance
3. Generate:
   - Histograms
   - Q-Q plots
4. Apply statistical comparison tests for two independent groups:
   - Brunner-Munzel Test
   - Independent t-test
   - Wilcoxon Rank Sum Test
5. Determine which statistical test is appropriate based on:
   - Normality
   - Variance homogeneity
6. Construct correlation heatmaps separately for each group using:
   - Pearson correlation (normal data)
   - Spearman correlation (non-normal data)
7. Generate an automated EDA report.

---

# Dataset Description

## Dataset Name

`data_for_analysis.csv`

## Description

The dataset contains:

- Multiple hormone/lipid measurement variables
- A grouping variable named `outcome`

## Group Variable

| Variable | Description |
|---|---|
| outcome | Binary grouping variable (0 and 1) |

## Hormone Variables

All columns except `outcome` were treated as quantitative hormone/lipid variables during analysis.

Example variable:

- `lipids1`

The script automatically detects and analyzes all hormone variables in the dataset.

---

# Software Environment

## R Version

The project was developed using:

```r
R version 4.4
```

## Required R Packages

```r
gtsummary
car
lawstat
corrplot
DataExplorer
```

## Package Installation

```r
install.packages("gtsummary")
install.packages("car")
install.packages("lawstat")
install.packages("corrplot")
install.packages("DataExplorer")
```

---

# Statistical Procedures Used

## 1. Descriptive Statistics

The following statistics were calculated for each hormone variable by group:

- Mean
- Standard Deviation (SD)
- Median

Publication-style summary tables were generated using:

```r
tbl_summary(data_for_analysis, by = outcome)
```

---

# 2. Normality Testing

## Shapiro-Wilk Test

The Shapiro-Wilk test was used to assess whether each variable followed a normal distribution.

```r
shapiro.test(variable)
```

### Interpretation

| p-value | Interpretation |
|---|---|
| p > 0.05 | Data approximately normal |
| p ≤ 0.05 | Data not normally distributed |

---

# 3. Visualization of Distributions

For each hormone variable and group:

- Histogram
- Q-Q Plot

were generated to visually assess data distribution and normality.

---

# 4. Homogeneity of Variance

## Levene’s Test

Levene’s Test was used to determine whether variances were equal between groups.

```r
car::leveneTest(variable ~ outcome)
```

### Interpretation

| p-value | Interpretation |
|---|---|
| p > 0.05 | Equal variances assumed |
| p ≤ 0.05 | Unequal variances |

---

# 5. Comparative Statistical Tests

Three independent group comparison tests were applied for every hormone variable.

## Independent t-test

Used when:
- Data are normally distributed
- Variances are homogeneous

```r
t.test(group1, group2)
```

---

## Wilcoxon Rank Sum Test

Used when:
- Normality assumptions are violated

```r
wilcox.test(group1, group2)
```

---

## Brunner-Munzel Test

Used when:
- Distributions are non-normal
- Variances may differ between groups

```r
brunner.munzel.test(group1, group2)
```

---

# Test Selection Criteria

## Appropriate Test Decision Rule

| Condition | Recommended Test |
|---|---|
| Normal distribution + equal variances | Independent t-test |
| Non-normal distribution | Wilcoxon test |
| Non-normal distribution + unequal variances | Brunner-Munzel test |

---

# 6. Correlation Analysis

Correlation heatmaps were generated separately for:

- Outcome Group 0
- Outcome Group 1

## Correlation Method Selection

### Pearson Correlation

Used when:
- Data are normally distributed

```r
method = "pearson"
```

### Spearman Correlation

Used when:
- Data are non-normal

```r
method = "spearman"
```

Heatmaps were generated using the `corrplot` package.

---

# 7. Exploratory Data Analysis (EDA)

An automated HTML EDA report was generated using:

```r
create_report(data_for_analysis)
```

The report includes:

- Missing value analysis
- Correlation analysis
- Variable distributions
- Summary statistics
- Data structure overview

---

# Key Learning Outcomes

This project demonstrates:

- Statistical testing in R
- Parametric vs non-parametric analysis
- Assumption checking
- Correlation analysis
- Data visualization
- Automated EDA generation
- Reproducible research workflow

