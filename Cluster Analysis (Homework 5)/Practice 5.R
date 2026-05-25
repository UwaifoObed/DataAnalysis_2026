install.packages(c("permute", "lattice"), dependencies = TRUE)
install.packages("vegan", dependencies = TRUE)
library(vegan)
#--------------------start-------------------------------
# Get current working directory
getwd()
#----------------read dataset----------------------------
data<-read.table("data.txt",header=TRUE,sep="\t",check.names = FALSE)

summary (data)
data

rownames(data)<-data[,1]
data<-data[,-1]

data

# Non-metric multidimensional scaling (NMDS) using Euclidean distances
# Perform NMDS ordination based on Euclidean distances.
# Euclidean distance is suitable for quantitative data but may be less appropriate
# for ecological community data due to sensitivity to double zeros.
# The metaMDS function automatically runs multiple random starts and scales the solution.
set.seed(123)
ord <- metaMDS(data, distance = "euclidean", trymax = 50)

#Visualisation of NMDS results
plot(ord, type = "n")                     # Create empty plot (axes only)

points(ord, disp = "sites", pch = 21, 
       cex = 2.5, lwd = 2.5, col = "red") # Add site points (samples)

text(ord, display = "site", cex = 0.7, 
     col = "red", pos = 3)                         # Label sites with their names

# Display stress value
ord$stress

# Cluster analysis with Euclidean distances
# Compute Euclidean distance matrix between sites
d<-vegdist(data,method="euclidean")

# Perform hierarchical agglomerative clustering using average linkage (UPGMA)
fit<-hclust(d, method="average")

# Visualise the dendrogram with labels aligned at the baseline
plot(fit, hang =-1)

# Simple dendrogram plot (default parameters)
plot(fit)


#/////////////////////////////////////////////////////////////
# Non-metric multidimensional scaling (NMDS) with Bray–Curtis dissimilarities
# Bray–Curtis is a standard ecological distance measure that ignores double zeros
# and is robust for abundance data.
# The metaMDS function automatically runs multiple random starts and scales the final solution.
set.seed(123)
ord <- metaMDS(data, distance = "bray", trymax = 100)

# Check stress value
ord$stress

# Visualisation of NMDS results
plot(ord, type = "n")
points(ord, disp="sites", pch=21, cex=2.5, lwd=2.5, col = "red")
text(ord, display = "site", cex=0.7, col="red", pos = 3)

# Cluster analysis with Bray–Curtis distances
# Compute Bray–Curtis dissimilarity matrix (standard for ecological community data)
d<-vegdist(data,method="bray")

# Perform hierarchical agglomerative clustering using average linkage (UPGMA)
fit<-hclust(d, method="average")

# Visualise dendrogram with labels aligned at the same horizontal level
plot(fit, hang =-1)

# Simple dendrogram plot (default R style)
plot(fit)

#/////////////////////////////////////////////////////////////
# Item 2. Detailed Analysis for the Bray–Curtis Distance
# 2.1. NMDS with the Bray-Curtis distance
# Repeated for rigorous analysis
set.seed(123)
ord_bray <- metaMDS(data, distance = "bray", trymax = 100)

# Display stress value
ord_bray$stress

#/////////////////////////////////////////////////////////////
# 2.2. Fit significant species vectors using envfit (p ≤ 0.05)
set.seed(123) # for reproducibility
fit_sp <- envfit(ord_bray, data, permutations = 999)

# Display only significant species (p ≤ 0.05)
sig_sp <- fit_sp$vectors$pvals <= 0.05
cat ("Significant Species (р <= 0.05):\n")
print(fit_sp$vectors$arrows[sig_sp, , drop = FALSE])
print(fit_sp$vectors$pvals[sig_sp])

#/////////////////////////////////////////////////////////////
# 2.3. Bray-Curtis based clustering (UPGMA)
d_bray <- vegdist(data, method = "bray") 
hc_bray <- hclust (d_bray, method = "average")

# Plot dendrogram
plot(hc_bray, hang = -1, main = "UPGMA Clustering using Bray-Curtis Distance")

#/////////////////////////////////////////////////////////////
# 2.4. Cut dendogram into clusters
# Here K = 2 clusters is used
k_clusters <- 2
clusters <- cutree(hc_bray, k = k_clusters)

# Convert clusters into factor for convenience.
clusters <- factor(clusters, labels = c("Cluster 1", "Cluster 2"))

# Display cluster membership
clusters

#/////////////////////////////////////////////////////////////
# 2.5. Final NMDS Plot with:
# - Points coloured by cluster
# - Confidence ellipses
# - Significant species vectors
# - Non-overlapping site labels

# Color scheme
cols <- c("blue", "red")[as.numeric(clusters)]

# Empty NMDS plot
plot(ord_bray, type = "n", main = "NMDS with Bray-Curtis Distance")

# Add sample points coloured by cluster
points(ord_bray, display = "sites", pch = 21,
       bg = cols, col = "black", cex = 2.5, lwd = 2)

# Add confidence ellipses around clusters
ordiellipse(ord_bray, groups = clusters, kind = "sd", conf = 0.95,
            draw = "polygon", border = c("blue", "red"),
            col = c("lightblue", "mistyrose"), label = TRUE)

# Add significant species vectors only (p ≤ 0.05)
plot(fit_sp, p.max = 0.05, col = "darkgreen")

# Add non-overlapping site labels
orditorp(ord_bray, display = "sites", cex = 0.8, col = "black")

#/////////////////////////////////////////////////////////////
# 2.6. PERMANOVA Analysis
# Test differences between clusters
adon <- adonis2(d_bray ~ clusters, permutations = 999)

# Display PERMANOVA table
adon

# Extract R² and p-value
R2_value <- adon$R2[1]
p_value <- adon$`Pr(>F)`[1]
cat("\nPERMANOVA Results:\n")
cat("R² =", R2_value, "\n")
cat("p-value =", p_value, "\n")

#/////////////////////////////////////////////////////////////
# 2.7. Conclusion based on PERMANOVA
if(p_value <= 0.05){
  cat("Conclusion: Clusters differ significantly in species composition.\n")
} else {
  cat("Conclusion: No significant difference in species composition between clusters.\n")
}

#/////////////////////////////////////////////////////////////
# Non-metric multidimensional scaling (NMDS) with Jaccard distance
set.seed(123)
ord <- metaMDS(data, distance = "jaccard", trymax = 50)

# Display stress value
ord$stress

# Visualization
plot(ord, type = "n")
points(ord, disp="sites", pch=21, cex=2.5, lwd=2.5, col = "red")
text(ord, display = "site", cex=0.7, col="red", pos = 3)

# Cluster analysis with Jaccard distance
# Compute Jaccard dissimilarity matrix
d<-vegdist(data,method="jaccard")

# Hierarchical clustering using average linkage (UPGMA)
fit<-hclust(d, method="average")

# Visualise dendrogram with labels aligned
plot(fit, hang =-1)

# Default dendrogram plot
plot(fit)



