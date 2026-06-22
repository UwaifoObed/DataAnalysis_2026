# ============================================================
# FINAL PROJECT
# CORRELATION ANALYSIS OF THE PIMA INDIANS DIABETES DATASET
# ============================================================

# ------------------------------------------------------------
# 1. LOAD DATA
# ------------------------------------------------------------

getwd()

setwd("C:/Users/OBED/Videos/Masters/Second Semester/Data Analysis/Final Project")

data_path <- "C:/Users/OBED/Videos/Masters/Second Semester/Data Analysis/Final Project/diabetes.csv"

data <- read.csv(data_path)

# ------------------------------------------------------------
# 2. INITIAL DATA INSPECTION
# ------------------------------------------------------------

dim(data)

str(data)

summary(data)

colSums(data == 0)

# ------------------------------------------------------------
# 3. DATA CLEANING
# ------------------------------------------------------------

# Replace biologically impossible values with NA

data$BloodPressure[data$BloodPressure == 0] <- NA

data$BMI[data$BMI == 0] <- NA

data$Glucose[data$Glucose == 0] <- NA

# Check NA counts

sum(is.na(data$BloodPressure))

sum(is.na(data$BMI))

sum(is.na(data$Glucose))

# Verify no zeros remain

sum(data$BloodPressure == 0, na.rm = TRUE)

sum(data$BMI == 0, na.rm = TRUE)

sum(data$Glucose == 0, na.rm = TRUE)

# ------------------------------------------------------------
# 4. REMOVE VARIABLES WITH EXCESSIVE MISSINGNESS
# ------------------------------------------------------------

data <- subset(
  data,
  select = -c(Insulin, SkinThickness)
)

names(data)

# ------------------------------------------------------------
# 5. LISTWISE DELETION
# ------------------------------------------------------------

data_clean <- na.omit(data)

dim(data_clean)

sum(is.na(data_clean))

# Verify impossible values removed

sum(data_clean$BloodPressure == 0)

sum(data_clean$BMI == 0)

sum(data_clean$Glucose == 0)

# ------------------------------------------------------------
# 6. CLEAN DATA OVERVIEW
# ------------------------------------------------------------

str(data_clean)

summary(data_clean)

# ------------------------------------------------------------
# 7. HISTOGRAMS
# ------------------------------------------------------------

hist(
  data_clean$Pregnancies,
  main = "Histogram (Pregnancies)",
  xlab = "Pregnancies"
)

hist(
  data_clean$Glucose,
  main = "Histogram (Glucose)",
  xlab = "Glucose"
)

hist(
  data_clean$BloodPressure,
  main = "Histogram (Blood Pressure)",
  xlab = "Blood Pressure"
)

hist(
  data_clean$BMI,
  main = "Histogram (BMI)",
  xlab = "BMI"
)

hist(
  data_clean$DiabetesPedigreeFunction,
  main = "Histogram (Diabetes Pedigree Function)",
  xlab = "DPF"
)

hist(
  data_clean$Age,
  main = "Histogram (Age)",
  xlab = "Age"
)

# ------------------------------------------------------------
# 8. NORMALITY TESTS
# ------------------------------------------------------------

shapiro.test(data_clean$Glucose)

shapiro.test(data_clean$BloodPressure)

shapiro.test(data_clean$BMI)

# ------------------------------------------------------------
# 9. SCATTERPLOTS FOR PEARSON ASSUMPTION CHECKING
# ------------------------------------------------------------

plot(
  data_clean$Glucose,
  data_clean$BMI,
  main = "Scatterplot of Glucose vs BMI",
  xlab = "Glucose",
  ylab = "BMI"
)

abline(
  lm(BMI ~ Glucose, data = data_clean),
  col = "red",
  lwd = 2
)

plot(
  data_clean$Age,
  data_clean$BloodPressure,
  main = "Scatterplot of Blood Pressure vs Age",
  xlab = "Age",
  ylab = "Blood Pressure"
)

abline(
  lm(BloodPressure ~ Age, data = data_clean),
  col = "red",
  lwd = 2
)

# ------------------------------------------------------------
# 10. POINT-BISERIAL CORRELATIONS
# ------------------------------------------------------------

pb_glucose <- cor.test(
  data_clean$Outcome,
  data_clean$Glucose,
  method = "pearson"
)

pb_bmi <- cor.test(
  data_clean$Outcome,
  data_clean$BMI,
  method = "pearson"
)

pb_age <- cor.test(
  data_clean$Outcome,
  data_clean$Age,
  method = "pearson"
)

pb_bp <- cor.test(
  data_clean$Outcome,
  data_clean$BloodPressure,
  method = "pearson"
)

# ------------------------------------------------------------
# 11. PEARSON CORRELATIONS
# ------------------------------------------------------------

pearson_glucose_bmi <- cor.test(
  data_clean$Glucose,
  data_clean$BMI,
  method = "pearson"
)

pearson_age_bp <- cor.test(
  data_clean$Age,
  data_clean$BloodPressure,
  method = "pearson"
)

# ------------------------------------------------------------
# 12. SPEARMAN CORRELATIONS
# ------------------------------------------------------------

spearman_age_preg <- cor.test(
  data_clean$Age,
  data_clean$Pregnancies,
  method = "spearman"
)

spearman_preg_bmi <- cor.test(
  data_clean$Pregnancies,
  data_clean$BMI,
  method = "spearman"
)

spearman_preg_glucose <- cor.test(
  data_clean$Pregnancies,
  data_clean$Glucose,
  method = "spearman"
)

spearman_dpf_glucose <- cor.test(
  data_clean$DiabetesPedigreeFunction,
  data_clean$Glucose,
  method = "spearman"
)

spearman_dpf_bmi <- cor.test(
  data_clean$DiabetesPedigreeFunction,
  data_clean$BMI,
  method = "spearman"
)

# ------------------------------------------------------------
# 13. DISPLAY CORRELATION OUTPUTS
# ------------------------------------------------------------

pb_glucose
pb_bmi
pb_age
pb_bp

pearson_glucose_bmi
pearson_age_bp

spearman_age_preg
spearman_preg_bmi
spearman_preg_glucose
spearman_dpf_glucose
spearman_dpf_bmi

# ------------------------------------------------------------
# 14. RESULTS TABLE
# ------------------------------------------------------------

results_table <- data.frame(
  Variable_Pair = c(
    "Outcome vs Glucose",
    "Outcome vs BMI",
    "Outcome vs Age",
    "Outcome vs BloodPressure",
    "Glucose vs BMI",
    "Age vs BloodPressure",
    "Age vs Pregnancies",
    "Pregnancies vs BMI",
    "Pregnancies vs Glucose",
    "DPF vs Glucose",
    "DPF vs BMI"
  ),
  
  Method = c(
    "Point-Biserial",
    "Point-Biserial",
    "Point-Biserial",
    "Point-Biserial",
    "Pearson",
    "Pearson",
    "Spearman",
    "Spearman",
    "Spearman",
    "Spearman",
    "Spearman"
  ),
  
  Correlation = c(
    unname(pb_glucose$estimate),
    unname(pb_bmi$estimate),
    unname(pb_age$estimate),
    unname(pb_bp$estimate),
    unname(pearson_glucose_bmi$estimate),
    unname(pearson_age_bp$estimate),
    unname(spearman_age_preg$estimate),
    unname(spearman_preg_bmi$estimate),
    unname(spearman_preg_glucose$estimate),
    unname(spearman_dpf_glucose$estimate),
    unname(spearman_dpf_bmi$estimate)
  ),
  
  P_Value = c(
    pb_glucose$p.value,
    pb_bmi$p.value,
    pb_age$p.value,
    pb_bp$p.value,
    pearson_glucose_bmi$p.value,
    pearson_age_bp$p.value,
    spearman_age_preg$p.value,
    spearman_preg_bmi$p.value,
    spearman_preg_glucose$p.value,
    spearman_dpf_glucose$p.value,
    spearman_dpf_bmi$p.value
  )
)

results_table

# Optional rounding

results_table$Correlation <- round(
  results_table$Correlation,
  3
)

results_table$P_Value <- signif(
  results_table$P_Value,
  3
)

results_table

# ------------------------------------------------------------
# 15. CORRELATION MATRIX HEATMAP
# ------------------------------------------------------------


install.packages("corrplot")

library(corrplot)

corr_data <- data_clean[, c(
  "Pregnancies",
  "Glucose",
  "BloodPressure",
  "BMI",
  "DiabetesPedigreeFunction",
  "Age"
)]

corr_matrix <- cor(
  corr_data,
  method = "pearson"
)

corrplot(
  corr_matrix,
  method = "color",
  type = "upper",
  addCoef.col = "black",
  tl.col = "black",
  tl.srt = 45,
  number.cex = 0.7
)

# ------------------------------------------------------------
# 16. BLOOD PRESSURE BY DIABETES STATUS
# ------------------------------------------------------------

aggregate(
  BloodPressure ~ Outcome,
  data = data_clean,
  mean
)

aggregate(
  BloodPressure ~ Outcome,
  data = data_clean,
  sd
)

boxplot(
  BloodPressure ~ Outcome,
  data = data_clean,
  main = "Blood Pressure by Diabetes Status (Boxplot)",
  xlab = "Outcome (0 = No Diabetes, 1 = Diabetes)",
  ylab = "Blood Pressure"
)

# ------------------------------------------------------------
# 17. WELCH TWO-SAMPLE T-TEST
# ------------------------------------------------------------

bp_ttest <- t.test(
  BloodPressure ~ Outcome,
  data = data_clean
)

bp_ttest

write.csv(
  results_table,
  "correlation_results.csv",
  row.names = FALSE
)
