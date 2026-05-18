#--------------------start-------------------------------
# Get current working directory
getwd()

#----------------read dataset--------------------------
data_for_analysis<-read.csv("data_for_analysis.csv")

#-----------descriptive statistics------------------
summary(data_for_analysis)

#-----------for publication tables-----------------
#---------------Creating a custom table--------------
# Homework: Creating a custom table with descriptive statistics results

install.packages("gtsummary")
install.packages(c("cardx", "cards"))
install.packages("corrplot")

library(cardx)
library(gtsummary)

library(gtsummary)

tbl_summary(data_for_analysis)  # Automatic table
tbl_summary(data_for_analysis, by = outcome)  # By groups

#----------------convert outcome to factor----------------
str(data_for_analysis)

data_for_analysis$outcome<- as.factor(data_for_analysis$outcome)

#----------------select all hormones----------------------
# Excluding outcome column
hormones<-names(data_for_analysis)[names(data_for_analysis)!="outcome"]

#----------------create results table---------------------
results_table<-data.frame()

#--------------Statistical Tests---------------------
for(i in hormones){
  
  #----------------Group 1------------------------------
  value_outcome1<-data_for_analysis[data_for_analysis$outcome=="1",][[i]]
  
  hist(value_outcome1, col = "lightblue", main = paste("Histogram -", i, "Group 1"))
  
  qqnorm(value_outcome1, main = paste("Q-Q Plot -", i, "Group 1"))
  qqline(value_outcome1, col = "red", lwd = 2)
  
  # Shapiro-Wilk test (for n < 5000)
  shapiro1<-shapiro.test(value_outcome1)
  
  shapiro1
  
  #----------------Group 0------------------------------
  value_outcome0<-data_for_analysis[data_for_analysis$outcome=="0",][[i]]
  
  hist(value_outcome0, col = "lightgreen", main = paste("Histogram -", i, "Group 0"))
  
  qqnorm(value_outcome0, main = paste("Q-Q Plot -", i, "Group 0"))
  qqline(value_outcome0, col = "red", lwd = 2)
  
  # Shapiro-Wilk test (for n < 5000)
  shapiro0<-shapiro.test(value_outcome0)
  
  shapiro0
  
  #-------Levene's Test for Homogeneity of Variance--------------
  install.packages("car")
  
  library(car)
  
  levene_result<-car::leveneTest(
    as.formula(paste(i, "~ outcome")),
    data = data_for_analysis
  )
  
  levene_result
  
  #---------------Application of the Brunner-Munzel test----------
  install.packages("lawstat")
  
  library(lawstat)
  
  group1 <- data_for_analysis[[i]][data_for_analysis$outcome == "0"]
  group2 <- data_for_analysis[[i]][data_for_analysis$outcome == "1"]
  
  bm_test<-brunner.munzel.test(group1, group2)
  
  bm_test
  
  #-------------comparison of results with other tests--------------
  t_test<-t.test(group1, group2)
  
  t_test
  
  wilcox_res<-wilcox.test(group1, group2)
  
  wilcox_res
  
  #----------------Which test is applicable-------------------------
  if(
    shapiro1$p.value > 0.05 &
    shapiro0$p.value > 0.05 &
    levene_result$`Pr(>F)`[1] > 0.05
  ){
    
    applicable_test<-"t.test"
    
  }else{
    
    applicable_test<-"wilcox.test / brunner.munzel.test"
    
  }
  
  #----------------save results into table--------------------------
  results_table<-rbind(
    results_table,
    
    data.frame(
      
      Hormone=i,
      
      Mean_Group0=mean(group1, na.rm=TRUE),
      SD_Group0=sd(group1, na.rm=TRUE),
      Median_Group0=median(group1, na.rm=TRUE),
      
      Mean_Group1=mean(group2, na.rm=TRUE),
      SD_Group1=sd(group2, na.rm=TRUE),
      Median_Group1=median(group2, na.rm=TRUE),
      
      Shapiro_Group0_p=shapiro0$p.value,
      Shapiro_Group1_p=shapiro1$p.value,
      
      Levene_p=levene_result$`Pr(>F)`[1],
      
      Brunner_Munzel_p=bm_test$p.value,
      T_test_p=t_test$p.value,
      Wilcox_p=wilcox_res$p.value,
      
      Applicable_Test=applicable_test
      
    )
    
  )
  
}

#----------------display results table-------------------------
results_table

#----------------save results table----------------------------
write.csv(
  results_table,
  "results_table.csv",
  row.names = FALSE
)

#----------------Correlation Heatmaps--------------------------
install.packages("corrplot")

library(corrplot)

#----------------Group 0 correlation---------------------------
group0_data<-data_for_analysis[
  data_for_analysis$outcome=="0",
  hormones
]

#----------------Group 1 correlation---------------------------
group1_data<-data_for_analysis[
  data_for_analysis$outcome=="1",
  hormones
]

#----------------Choose correlation method---------------------
# Pearson for normal data
# Spearman for non-normal data

if(
  all(results_table$Shapiro_Group0_p > 0.05) &
  all(results_table$Shapiro_Group1_p > 0.05)
){
  
  correlation_method<-"pearson"
  
}else{
  
  correlation_method<-"spearman"
  
}

#----------------Correlation matrix Group 0--------------------
cor_group0<-cor(
  group0_data,
  use = "complete.obs",
  method = correlation_method
)

corrplot(
  cor_group0,
  method = "color",
  type = "upper",
  title = paste(
    "Correlation Heatmap Group 0 -",
    correlation_method
  )
)

#----------------Correlation matrix Group 1--------------------
cor_group1<-cor(
  group1_data,
  use = "complete.obs",
  method = correlation_method
)

corrplot(
  cor_group1,
  method = "color",
  type = "upper",
  title = paste(
    "Correlation Heatmap Group 1 -",
    correlation_method
  )
)

#----------------------------EDA----------------------------------
install.packages("DataExplorer")

library(DataExplorer)

create_report(data_for_analysis)  # Generates HTML report with graphs and statistics

create_report(
  data = data_for_analysis,
  output_file = "EDA_Report.html",  
  output_dir = getwd(),                
  report_title = "EDA Report"          
)
