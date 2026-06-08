# Multivariate Data Analysis in R

This project performs multivariate statistical analysis on two biological datasets using R. The analyses include:

- Spearman Correlation Analysis
- Principal Component Analysis (PCA)
- PCA Biplots
- PCA with Confidence Ellipses
- Interactive 3D PCA Visualization
- PERMANOVA (Permutational Multivariate Analysis of Variance)
- Export of results to Excel workbooks

The project was completed as part of a Data Analysis coursework assignment.

---

# Datasets

## 1. data_omul.txt

PCB (Polychlorinated Biphenyl) concentration data collected from individuals.

### Variables

| Variable | Description |
|-----------|-------------|
| con_28 | PCB 28 concentration |
| con_52 | PCB 52 concentration |
| con_101 | PCB 101 concentration |
| con_118_d | PCB 118 concentration |
| con_153 | PCB 153 concentration |
| con_138 | PCB 138 concentration |
| con_180 | PCB 180 concentration |
| sex | Sex of individual (m/f) |

### Analyses Performed

- Spearman correlation analysis
- PCA
- PCA biplot grouped by sex
- 95% confidence ellipses
- PERMANOVA using Euclidean distances

### Outputs

- Table 1: Significant correlation coefficients
- Figure 1: PCA visualization by sex
- Table 2: PERMANOVA results

---

## 2. data_morphometry.txt

Morphometric measurements collected from different sampling locations.

### Variables

The first column represents sampling groups/sites.

Remaining columns contain morphometric measurements such as:

- Generative shoot height
- Leaf lengths
- Leaf widths
- Perianth lengths
- Perianth widths
- Stamen height
- Pistil height

### Analyses Performed

- Spearman correlation analysis
- PCA
- PCA grouped by sampling site
- PCA with confidence ellipses
- Interactive 3D PCA visualization

---

# Statistical Methods

## Spearman Correlation Analysis

Used to assess monotonic relationships between variables.

Only statistically significant correlations were retained:

```r
p < 0.05
```

Non-significant correlations were set to zero.

---

## Principal Component Analysis (PCA)

Used to reduce dimensionality and identify major sources of variation in the datasets.

Conducted using:

```r
prcomp()
```

Outputs include:

- Variance explained
- PCA scores
- PCA loadings
- PCA biplots

---

## PERMANOVA

Used to test whether PCB concentration profiles differ significantly between sexes.

Conducted using:

```r
adonis2()
```

Parameters:

```r
method = "euclidean"
permutations = 1000
```

---

# Software Requirements

## R Version

This project was developed using:

```text
R version 4.5.1
```

You can verify your installed version with:

```r
R.version.string
```

---

# Required R Packages

Install packages using:

```r
install.packages(c(
  "Hmisc",
  "knitr",
  "vegan",
  "factoextra",
  "plotly",
  "openxlsx"
))
```

Load packages:

```r
library(Hmisc)
library(knitr)
library(vegan)
library(factoextra)
library(plotly)
library(openxlsx)
```

---

# Package Usage

## Hmisc

Used for:

```r
rcorr()
```

Calculates:

- Spearman correlation coefficients
- Correlation p-values

---

## vegan

Used for:

```r
decostand()
adonis2()
```

Functions:

- Range standardization
- PERMANOVA

---

## factoextra

Used for:

```r
fviz_pca_biplot()
```

Functions:

- PCA visualization
- Confidence ellipses
- Group-based PCA plots

---

## plotly

Used for:

```r
plot_ly()
```

Functions:

- Interactive 3D PCA visualization

---

Contains:

### Summary

Descriptive statistics for PCB variables.

### Table1_Correlations

Significant Spearman correlation matrix.

### PCA_Importance

Variance explained by principal components.

### PCA_Scores

Observation coordinates in PCA space.

### PCA_Loadings

Variable loadings for principal components.

### PERMANOVA

Results from adonis2().

---

Contains:

### Summary

Descriptive statistics.

### Correlations

Significant Spearman correlation matrix.

### PCA_Importance

Variance explained by principal components.

### PCA_Scores

Observation coordinates in PCA space.

### PCA_Loadings

Variable loadings.

---

# Running the Project

1. Clone the repository

```bash
git clone https://github.com/yourusername/your-repository-name.git
```

2. Open R or RStudio.

3. Set the working directory to the project folder.

```r
setwd("path/to/project")
```

4. Run the analysis script.

```r
source("practice 6 PCA - (HW).R")
```

---

# Author

Uwaifo Obed

Master's Student – Big Data and Artificial Intelligence

Irkutsk National Research Technical University

---

# License

This project is intended for educational and academic purposes.
