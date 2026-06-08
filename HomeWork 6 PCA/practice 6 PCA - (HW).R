# Install packages if needed
# install.packages(c("Hmisc","knitr","vegan","factoextra","plotly"))

# LOAD LIBRARIES
library(Hmisc)
library(knitr)
library(vegan)
library(factoextra)
library(plotly)

# WORKING DIRECTORY

getwd()

setwd("C:/Users/OBED/Videos/Masters/Second Semester/Data Analysis/Homework 6")

# DATASET 1 : PCB CONCENTRATIONS (data_omul.txt)

cat("\n=====================================================\n")
cat("DATASET 1 : PCB CONCENTRATIONS\n")
cat("=====================================================\n")

# READ DATA

data <- read.table(
  "data_omul.txt",
  header = TRUE,
  sep = "\t"
)

summary(data)

# FACTOR (SEX)

data_factor <- data[, 8, drop = FALSE]

# PCB CONCENTRATIONS

data_conc <- data[, 1:7]

# STANDARDIZATION

data_std <- decostand(
  data_conc,
  method = "range",
  MARGIN = 2
)

# CORRELATION ANALYSIS (SPEARMAN)

data_matrix <- as.matrix(data_std)

rcorr_result <- rcorr(
  data_matrix,
  type = "spearman"
)

DD <- rcorr_result$r
DP <- rcorr_result$P

DD[DP > 0.05] <- 0

diag(DD) <- 1

# TABLE 1

cat("\nTABLE 1\n")

table1 <- kable(
  DD,
  digits = 3,
  caption = "Table 1 – Significant correlation coefficients (p < 0.05) showing the strength and direction of the relationship between the studied PCB concentrations."
)

print(table1)

# PCA

fit <- prcomp(data_std)

cat("\nPCA SUMMARY\n")
summary(fit)

# FIGURE 1

figure1 <- fviz_pca_biplot(
  fit,
  habillage = data_factor$sex,
  addEllipses = TRUE,
  ellipse.level = 0.95,
  title = "Figure 1 – PCA of PCB concentrations by sex"
)

print(figure1)

# PERMANOVA

result <- adonis2(
  data_std ~ sex,
  data = data_factor,
  method = "euclidean",
  permutations = 1000,
  by = "terms"
)

print(result)


# TABLE 2

table2 <- kable(
  result,
  caption = "Table 2 – Assessment of the significance of the effect of sex on PCB concentrations in individuals using PERMANOVA with Euclidean distances and adonis2().",
  digits = c(0, 2, 3, 2, 4),
  align = c("l", "c", "c", "c", "c")
)

print(table2)


# DATASET 2 : MORPHOMETRY (data_morphometry.txt)


cat("\n=====================================================\n")
cat("DATASET 2 : MORPHOMETRY\n")
cat("=====================================================\n")

# OPTIONAL LOCALE

Sys.setlocale("LC_CTYPE", "Russian")


# READ DATA

morph <- read.table(
  "data_morphometry.txt",
  header = TRUE,
  sep = "\t"
)

summary(morph)

# GROUP COLUMN

p_names <- morph[, 1]


# NUMERIC VARIABLES
morph <- morph[, -1]

# STANDARDIZATION

morph_std <- decostand(
  morph,
  method = "range",
  MARGIN = 2
)

# CORRELATION ANALYSIS (ORIGINAL LOOP VERSION)

DD <- matrix(
  nrow = ncol(morph_std),
  ncol = ncol(morph_std)
)

rownames(DD) <- colnames(morph_std)
colnames(DD) <- colnames(morph_std)

DP <- DD

for(i in 1:ncol(morph_std))
{
  for(j in 1:ncol(morph_std))
  {
    R <- cor.test(
      morph_std[, i],
      morph_std[, j],
      method = "spearman"
    )
    
    DD[i, j] <- R$estimate
    DP[i, j] <- R$p.value
    
    if(i == j)
    {
      DD[i, j] <- 1
    }
  }
}

DD[DP > 0.05] <- 0

# CORRELATION TABLE

kable(
  DD,
  digits = 3,
  caption = "Significant Spearman correlations for morphometric variables (p < 0.05)"
)

# PCA

fit2 <- prcomp(morph_std)

cat("\nMORPHOMETRY PCA SUMMARY\n")
summary(fit2)

# ORIGINAL PCA BIPLOT

fviz_pca_biplot(
  fit2,
  title = "Morphometry PCA"
)

# ORIGINAL GROUPED PCA BIPLOT

fviz_pca_biplot(
  fit2,
  habillage = p_names,
  title = "Morphometry PCA by Collection Site"
)

# ORIGINAL ELLIPSE PCA BIPLOT

fviz_pca_biplot(
  fit2,
  habillage = p_names,
  addEllipses = TRUE,
  ellipse.level = 0.95,
  title = "Morphometry PCA with 95% Confidence Ellipses"
)

# 3D PCA VISUALIZATION

scores <- fit2$x

x <- scores[,1]
y <- scores[,2]
z <- scores[,3]

loads <- fit2$rotation

p <- plot_ly()

p <- p %>%
  add_trace(
    x = x,
    y = y,
    z = z,
    type = "scatter3d",
    mode = "markers",
    marker = list(
      color = y,
      colorscale = c("#FFE1A1","#683531"),
      opacity = 0.7
    )
  )

# LOADING ARROWS

scale.loads <- 5

for(k in 1:nrow(loads))
{
  x_line <- c(0, loads[k,1]) * scale.loads
  y_line <- c(0, loads[k,2]) * scale.loads
  z_line <- c(0, loads[k,3]) * scale.loads
  
  p <- p %>%
    add_trace(
      x = x_line,
      y = y_line,
      z = z_line,
      type = "scatter3d",
      mode = "lines",
      line = list(width = 8),
      opacity = 1
    )
}

# DISPLAY 3D PCA

print(p)