# Lipid Profile Statistical Analysis in R

## Project Overview

This project performs a comprehensive statistical analysis of the dataset `data_for_analysis.csv` using the R programming language. The analysis focuses on exploring relationships between lipid variables and predicting a binary outcome variable using regression and logistic regression techniques.

The assignment includes:

1. Correlation analysis between variables
2. Permutation-based significance testing
3. Regression analysis between variables
4. Best model selection using BIC
5. Logistic regression modeling for binary outcome prediction
6. Model comparison using AIC/BIC
7. Odds ratio interpretation
8. ROC curve and AUC evaluation

---

# Assignment Objectives

The following objectives were completed in this project:

* Perform correlation analysis between variables
* Obtain a table with correlation coefficients and significance assessment using permutation methods
* Perform regression analysis between variables
* Select the best regression model using Bayesian Information Criterion (BIC)
* Fit logistic regression models using lipid/hormone variables to predict a binary outcome
* Compare logistic regression models using AIC and BIC
* Compute odds ratios and confidence intervals
* Evaluate model performance using ROC curves and AUC

---

# Dataset Description

Dataset used:

```text
data_for_analysis.csv
```

The dataset contains:

* Multiple lipid/hormone-related numerical variables:

  * `lipids1`
  * `lipids2`
  * `lipids3`
  * `lipids4`

* One binary outcome variable:

  * `outcome`

The outcome variable was converted to a factor variable for logistic regression analysis.

Example preprocessing:

```r
data$outcome <- as.factor(data$outcome)
```

Missing values were removed using:

```r
data <- na.omit(data)
```

---

# Software and Environment

## Programming Language

* R

## R Version

Recommended version:

```text
R 4.6 or later
```

## Main Packages Used

### Statistical Packages

```r
library(wPerm)
library(pROC)
```

### Package Purposes

| Package | Purpose                               |
| ------- | ------------------------------------- |
| wPerm   | Permutation-based correlation testing |
| pROC    | ROC curve and AUC analysis            |

---

# Statistical Procedures Used

---

# 1. Normality Testing

The distribution of variables was examined using:

* Shapiro-Wilk normality test
* Histograms
* Q-Q plots

Example:

```r
shapiro.test(data$lipids1)
```

Visualization:

```r
hist(data$lipids1)
qqnorm(data$lipids1)
qqline(data$lipids1)
```

---

# 2. Correlation Analysis

## Method Used

Spearman rank correlation was selected because:

* the variables were not assumed to follow a normal distribution
* Spearman correlation is robust for non-parametric data

Example:

```r
cor.test(data$lipids1,
         data$lipids2,
         method = "spearman")
```

---

# 3. Permutation Significance Testing

Permutation testing was performed using the `wPerm` package.

Function used:

```r
perm.relation()
```

Example:

```r
perm.relation(
  x = data[[var1]],
  y = data[[var2]],
  method = "spearman",
  R = 10000
)
```

## Purpose

This method evaluates statistical significance without relying on strict distributional assumptions.

The results table includes:

* Variable pair
* Spearman correlation coefficient
* Permutation p-value

---

# 4. Regression Analysis

Regression analysis was performed between all lipid variables.

## Models Compared

The following regression models were fitted:

| Model               | Description                          |
| ------------------- | ------------------------------------ |
| Linear              | Standard linear regression           |
| Polynomial Degree 2 | Quadratic relationship               |
| Polynomial Degree 3 | Cubic relationship                   |
| Logarithmic         | Log-transformed dependent variable   |
| Exponential         | Log-transformed independent variable |

Example:

```r
lm(lipids1 ~ lipids2)
```

Polynomial example:

```r
lm(lipids1 ~ poly(lipids2, 2))
```

---

# 5. Model Selection Using BIC

The Bayesian Information Criterion (BIC) was used to determine the best regression model.

Example:

```r
BIC(model_linear)
```

The model with the lowest BIC value was selected as the best-fitting model.

---

# 6. Logistic Regression Analysis

Logistic regression models were developed to predict the binary outcome variable.

## Models Fitted

### Model 1

Single predictor:

```r
outcome ~ lipids1
```

### Model 2

Two predictors:

```r
outcome ~ lipids1 + lipids2
```

### Model 3

All lipid variables:

```r
outcome ~ lipids1 + lipids2 + lipids3 + lipids4
```

---

# 7. Logistic Model Comparison

Models were compared using:

* Akaike Information Criterion (AIC)
* Bayesian Information Criterion (BIC)

Example:

```r
AIC(model_logit_1)
BIC(model_logit_1)
```

The model with the lowest AIC/BIC was considered the best model.

---

# 8. Prediction and Classification

Predicted probabilities were generated using:

```r
predict(model_logit_2,
        type = "response")
```

Classification was performed using a 0.5 threshold:

```r
ifelse(pred_prob > 0.5, 1, 0)
```

A confusion matrix was produced to evaluate prediction accuracy.

---

# 9. ROC Curve and AUC

Receiver Operating Characteristic (ROC) curves were generated to evaluate classification performance.

Example:

```r
roc(data$outcome,
    data$pred_prob)
```

Area Under the Curve (AUC) values were computed for each logistic model.

Interpretation:

* Higher AUC values indicate better classification performance.

---

# 10. Stepwise Variable Selection

Stepwise logistic regression was performed using AIC optimization.

Example:

```r
step(model_logit_all,
     direction = "both")
```

This procedure helps identify the most important predictors.

---

# 11. Odds Ratios

Odds ratios and confidence intervals were calculated for interpretation of logistic regression coefficients.

Example:

```r
exp(cbind(
  OR = coef(model_logit_2),
  confint(model_logit_2)
))
```

Interpretation:

* OR > 1 indicates increased odds
* OR < 1 indicates decreased odds

---

# Output Generated

The script generates:

* Summary statistics
* Normality test results
* Correlation tables
* Permutation p-values
* Regression model summaries
* BIC comparison tables
* Logistic regression summaries
* AIC/BIC comparison tables
* ROC curves
* AUC values
* Confusion matrix
* Odds ratio tables

---

# How to Run the Project

## Step 1 — Install Required Packages

```r
install.packages("wPerm")
install.packages("pROC")
```

## Step 2 — Load Packages

```r
library(wPerm)
library(pROC)
```

## Step 3 — Run the Script

Open the `.R` file in RStudio and run the script sequentially.

---

# Notes

* Spearman correlation was used due to possible non-normality of variables.
* Permutation methods were applied to obtain robust significance estimates.
* BIC was used for model selection because it penalizes model complexity more strongly than AIC.
* Logistic regression was selected because the outcome variable is binary.

---
