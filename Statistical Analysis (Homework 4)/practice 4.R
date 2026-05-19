#--------------------start-------------------------------
# Get current working directory
getwd()
#----------------read dataset--------------------------
#install.packages("remotes")
#remotes::install_version("wPerm",version = "1.0.1",repos = "https://cran.r-project.org")
#install.packages("wPerm", type = "source")
#install.packages("https://cran.r-project.org/src/contrib/Archive/wPerm/wPerm_1.0.3.tar.gz",repos = NULL,type = "source")
install.packages("wPerm")
library(wPerm)

data <- read.csv("data_for_analysis.csv")
data$outcome <- as.factor(data$outcome)
summary(data)

# testing for normality of distribution
shapiro.test(data$lipids1)
shapiro.test(data$lipids2)

hist(data$lipids1)  
qqnorm(data$lipids1)

# Spearman's correlation test
spearman_result<-cor.test(data$lipids1, data$lipids2, method="spearman")
print(spearman_result)


# data.frame for result
results <- data.frame(
  variable1 = character(),
  variable2 = character(),
  spearman_corr = numeric(),
  s_p_value = numeric(),
  stringsAsFactors = FALSE
)

# variables for analysis
target_vars <- c("lipids1", "lipids2", "lipids3", "lipids4")

# main correlation analysis
for (i in 1:(length(target_vars)-1)) {
  
  for (j in (i+1):length(target_vars)) {
    
    var1 <- target_vars[i]
    var2 <- target_vars[j]
    
  # spearman permutation test
  perm_spearman <- perm.relation(
    x = data[[var1]], 
    y = data[[var2]],
    method = "spearman",
    R = 10000
  )
  
  # add result
  results <- rbind(results, data.frame(
    variable_1 = var1,
    variable_2 = var2,
    spearman_corr = perm_spearman$Observed,
    s_p_value =  perm_spearman$p.value
    ))
  }
}

# output result
print(results)

#------visualization of significant results of correlation analysis---------

data<-data[order(data$lipids2),]

plot(data$lipids2, data$lipids1)
lines(data$lipids2, data$lipids1, col = "blue")
abline(lm(data$lipids1 ~ data$lipids2), col="red")

#_____________regression analysis________________ 

df <- data
df <- df[order(df$lipids1),]

# REGRESSION ANALYSIS BETWEEN OTHER VARIABLES
#linear regression

# results table
regression_results <- data.frame(
  dependent = character(),
  independent = character(),
  best_model = character(),
  BIC_value = numeric(),
  stringsAsFactors = FALSE
)

# regression variables
regression_vars <- c("lipids1", "lipids2", "lipids3", "lipids4")

# main regression loop
for (i in 1:length(regression_vars)) {
  
  for (j in 1:length(regression_vars)) {
    
    if (i != j) {
      
      dep_var <- regression_vars[i]
      indep_var <- regression_vars[j]

      # linear regression
      model_linear <- lm(
        as.formula(paste(dep_var, "~", indep_var)),
        data=df
      )

      #second degree polynomal
      model_2 <- lm(
        as.formula(paste(dep_var, "~ poly(", indep_var, ",2)")),
        data=df
      )
    
      # third degree polynomial
      model_3 <- lm(
        as.formula(paste(dep_var, "~ poly(", indep_var, ",3)")),
        data=df
      )
      
      model_log <- lm(
        as.formula(paste("log(", dep_var, ") ~", indep_var)), 
        data=df
      )
      
      model_exp <- lm(
        as.formula(paste(dep_var, "~ log(", indep_var, ")")), 
        data=df
      )

      # comparison of models
      rezult <- data.frame(
        model = c("model_linear", 
                "model_2", 
                "model_3", 
                "model_log",
                "model_exp"),
        
        BIC_value = c(
          BIC(model_linear),
          BIC(model_2),
          BIC(model_3),
          BIC(model_log),
          BIC(model_exp)
        )
      )
    
      rezult <- rezult[order(rezult$BIC_value),]
  
      # add best model result
      regression_results <- rbind(
        regression_results,
        data.frame(
          dependent = dep_var,
          independent = indep_var,
          best_model = rezult$model[1],
          BIC_value = rezult$BIC_value[1]
        )
      )
  
    }
  }
}

# show regression results
print(regression_results)

# ORIGINAL REGRESSION ANALYSIS

# linear regression
model_linear <- lm(lipids1 ~ lipids2, data=df)
summary(model_linear)

# second degree polynomial
model_2 <- lm(lipids1 ~ poly(lipids2, 2), data=df)
summary(model_2)

# third degree polynomial
model_3 <- lm(lipids1 ~ poly(lipids2, 3), data=df)
summary(model_3)

# log dependence
model_log <- lm(log(lipids1) ~ lipids2, data=df)
summary(model_log)

# exponential dependence
model_exp <- lm(lipids1 ~ log(lipids2), data=df)
summary(model_exp)

# comparison of models
# table of result

rezult <- data.frame(
  model = c("model_linear",
            "model_2",
            "model_3",
            "model_log",
            "model_exp"),
  
  BIC_value = c(
    BIC(model_linear),
    BIC(model_2),
    BIC(model_3),
    BIC(model_log),
    BIC(model_exp)
  )
)

rezult <- rezult[order(rezult$BIC_value),]
print(rezult)

# best model
best_model <- rezult$model[1]

# __________building graphs______________
# linear regression graphs
plot(df$lipids2, df$lipids1)
lines(df$lipids2, fitted(model_linear), col="blue")

# Logistic regression
# Simple model with one predictor
model_logit_1 <- glm(outcome ~ lipids1, 
                     data = data, 
                     family = binomial)
summary(model_logit_1)

# Multi-predictor model
model_logit_2 <- glm(outcome ~ lipids1 + lipids2, 
                     data = data, 
                     family = binomial)

summary(model_logit_2)

# Model with all variables lipids 
model_logit_all <- glm(
  outcome ~ lipids1 + lipids2 + lipids3 + lipids4, 
  data = data, 
  family = binomial
)
summary(model_logit_all)

# MODEL PERFORMANCE COMPARISON
logistic_results <- data.frame(
  model = c("model_logit_1",
            "model_logit_2",
            "model_logit_all"),
  
  AIC_value = c(
    AIC(model_logit_1),
    AIC(model_logit_2),
    AIC(model_logit_all)
  ),
  
  BIC_value = c(
    BIC(model_logit_1),
    BIC(model_logit_2),
    BIC(model_logit_all)
  )
)

# order by BIC
logistic_results <- logistic_results[
  order(logistic_results$BIC_value),
]

print(logistic_results)

# best logistic model
best_logistic_model <- logistic_results$model[1]

# Prediction
# Predicting probabilities for new data (example)
data$pred_prob_1 <- predict(model_logit_1, type="response")
data$pred_prob_2 <- predict(model_logit_2, type="response")
data$pred_prob_all <- predict(model_logit_all, type="response")

if (!require(pROC)) install.packages("pROC")
library(pROC)

roc1 <- roc(data$outcome, data$pred_prob_1)
roc2 <- roc(data$outcome, data$pred_prob_2)
roc3 <- roc(data$outcome, data$pred_prob_all)

plot(roc1, col=1)
plot(roc2, add=TRUE, col=2)
plot(roc3, add=TRUE, col=3)

auc(roc1)
auc(roc2)
auc(roc3)

# Classification by threshold 0.5
data$pred_class <- ifelse(data$pred_prob_2 > 0.5, 1, 0)
table(data$outcome, data$pred_class)

# Stepwise variable selection (AIC)
step_model <- step(model_logit_all, direction = "both")
summary(step_model)

# odds ratios
exp(cbind(OR=coef(model_logit_2), confint(model_logit_2)))
exp(cbind(OR=coef(model_logit_all), confint(model_logit_all)))

#---------------- FINAL SUMMARY --------------------------

cat("\nFINAL SUMMARY:\n")
cat("Best regression model:", best_model, "\n")
cat("Best logistic model:", best_logistic_model, "\n")
cat("Correlation analysis completed using permutation tests.\n")
cat("Logistic models compared using AIC and BIC.\n")
cat("ROC and AUC computed for all models.\n")
cat("Odds ratios calculated for interpretation.\n")