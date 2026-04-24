# Data Analysis of Probability Distributions

## Project Overview

This project presents my analysis of probability distributions for continuous variables using the dataset data_for_analysis. I worked with three datasets that included distribution examples, factor variables, and imputed numerical variables. I merged the factor and imputed datasets using a common record identifier to create a unified dataset suitable for statistical analysis. The final dataset contains clinical and biochemical variables, including lipid measurements and an outcome variable used to define groups.

## Data Preparation

I began by examining the structure of each dataset to ensure that all variables were correctly loaded and appropriately typed. I converted relevant variables to numeric format where necessary to enable statistical computations. I then merged the datasets to produce a complete dataset for analysis. During preprocessing, I identified missing values in the lipids5 variable and resolved this issue by imputing the missing values using the mean of the observed data. This step ensured that all variables were complete and suitable for further analysis.

## Methodology

I first used the example dataset to explore different probability distributions, including normal, lognormal, exponential, and Poisson distributions. I calculated summary statistics such as mean and standard deviation and visualized the data using histograms. I applied maximum likelihood estimation to estimate the parameters of each distribution and used the Bayesian Information Criterion to compare model fits.

For the main analysis, I focused on lipid variables from lipids1 to lipids5. I split the dataset into groups based on the outcome variable and performed distribution fitting separately for each group. For each variable within each group, I fitted normal, lognormal, and exponential distributions. I calculated the Bayesian Information Criterion for each model and selected the distribution with the lowest value as the best fitting model.

## Results

I visualized the distributions of each lipid variable using histograms for both groups. This allowed me to compare the shapes and spread of the data across outcome groups. The analysis showed that most lipid variables tend to follow a lognormal distribution, which is consistent with their positive values and skewed nature.

I created a summary table that includes each variable, the corresponding group, and the selected distribution. This table provides a structured overview of the distributional characteristics of the data. I also exported the results as a CSV file for documentation and further use.

## Conclusion

This project demonstrates the application of statistical distribution fitting, model selection using Bayesian Information Criterion, and data preprocessing techniques such as handling missing values. The results provide insight into how lipid variables behave across different outcome groups and establish a foundation for further statistical analysis and modeling.

## Technologies Used

R programming language was used for data processing, statistical modeling, and visualization. The MASS package was used for fitting probability distributions and estimating model parameters.

