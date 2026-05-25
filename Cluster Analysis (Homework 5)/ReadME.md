# Ecological Community Analysis Using NMDS, Bray–Curtis, Jaccard, and UPGMA Clustering in R

## Assignment Description

This assignment focuses on multivariate ecological community analysis using species abundance data collected from multiple lake sampling sites. The analysis was performed in R using the `vegan` package and related ecological statistical methods.

The main objective of the assignment was to:

* Compare ecological similarities and differences among lakes/sites
* Visualize species composition patterns using ordination techniques
* Group ecologically similar sites using clustering methods
* Identify species significantly associated with ecological gradients
* Test whether ecological clusters differ significantly in species composition

The assignment specifically required:

1. NMDS ordination using:

   * Euclidean distance
   * Bray–Curtis dissimilarity
   * Jaccard distance

2. UPGMA hierarchical clustering using:

   * Euclidean distance
   * Bray–Curtis distance
   * Jaccard distance

3. Detailed Bray–Curtis analysis including:

   * NMDS ordination
   * Significant species vector fitting using `envfit`
   * UPGMA clustering
   * Cluster extraction using `cutree`
   * Confidence ellipses using `ordiellipse`
   * Non-overlapping site labels using `orditorp`
   * PERMANOVA testing using `adonis2`

---

# Dataset Description

The dataset (`data.txt`) contains ecological abundance data for multiple species collected from several lake sampling locations.

## Dataset Structure

* Rows = Sampling sites/lakes
* Columns = Species
* Values = Species abundance counts

The dataset includes various chrysophyte and synurophyte taxa such as:

* *Chrysosphaerella brevispina*
* *Paraphysomonas gladiata*
* *Mallomonas crassisquama*
* *Spiniferomonas serrata*
* *Synura punctulosa*

The abundance matrix was analyzed to determine ecological similarity among the sampling locations.

---

# R Version

The analysis was performed using R.

Recommended version:

```r
R version 4.4
```

---

# Packages Used

The following packages were required:

```r
install.packages(c("permute", "lattice"), dependencies = TRUE)
install.packages("vegan", dependencies = TRUE)
```

Main package used:

```r
library(vegan)
```

---

# Procedures Used

## 1. Data Import and Preparation

The dataset was imported into R using:

```r
read.table()
```

The first column containing lake names was assigned as row names, and species abundance values were retained for analysis.

---

## 2. Non-metric Multidimensional Scaling (NMDS)

NMDS ordination was performed using:

```r
metaMDS()
```

Three distance metrics were analyzed:

### Euclidean Distance

Used for general quantitative similarity analysis.

### Bray–Curtis Dissimilarity

Used as the primary ecological distance measure because it is robust for abundance data and ignores double zeros.

### Jaccard Distance

Used for presence/absence ecological similarity analysis.

Stress values were evaluated to determine ordination quality.

---

## 3. Hierarchical Clustering (UPGMA)

Hierarchical clustering was performed using:

```r
hclust(method = "average")
```

Distance matrices were generated using:

```r
vegdist()
```

UPGMA dendrograms were produced for:

* Euclidean distance
* Bray–Curtis distance
* Jaccard distance

---

## 4. Species Vector Fitting

Significant species vectors were fitted onto the Bray–Curtis NMDS ordination using:

```r
envfit()
```

Only species with:

```r
p ≤ 0.05
```

were considered significant and displayed on the ordination plot.

---

## 5. Cluster Identification

Ecological clusters were extracted from the Bray–Curtis dendrogram using:

```r
cutree()
```

The dendrogram was divided into two ecological clusters.

---

## 6. Confidence Ellipses and Site Labels

Confidence ellipses were added using:

```r
ordiellipse()
```

Non-overlapping site labels were added using:

```r
orditorp()
```

These procedures improved visualization and interpretation of ecological groupings.

---

## 7. PERMANOVA Analysis

PERMANOVA was performed using:

```r
adonis2()
```

This tested whether the ecological clusters differed significantly in species composition.

The following statistics were reported:

* F statistic
* R² value
* p-value

A final ecological interpretation was generated based on the p-value.

---

# Outputs Produced

The script generated several outputs including:

## Figures

1. Euclidean NMDS Ordination
2. Euclidean UPGMA Dendrogram
3. Bray–Curtis NMDS Ordination
4. Bray–Curtis UPGMA Dendrogram
5. Final Bray–Curtis NMDS with:

   * Cluster colours
   * Confidence ellipses
   * Significant species vectors
   * Site labels
6. Jaccard NMDS Ordination
7. Jaccard UPGMA Dendrogram

## Statistical Outputs

1. NMDS stress values
2. Significant species vectors
3. Cluster membership
4. PERMANOVA results
5. Statistical interpretation of ecological differences

---

# Interpretation of Stress Values

Stress values were interpreted as follows:

| Stress Value | Interpretation |
| ------------ | -------------- |
| < 0.05       | Excellent      |
| 0.05–0.10    | Good           |
| 0.10–0.20    | Acceptable     |
| > 0.20       | Poor           |

The dataset produced very low stress values, indicating excellent ordination quality.

---

# Key R Functions Used

| Function        | Purpose                     |
| --------------- | --------------------------- |
| `metaMDS()`     | NMDS ordination             |
| `vegdist()`     | Distance matrix calculation |
| `hclust()`      | Hierarchical clustering     |
| `cutree()`      | Cluster extraction          |
| `envfit()`      | Species vector fitting      |
| `ordiellipse()` | Confidence ellipses         |
| `orditorp()`    | Non-overlapping labels      |
| `adonis2()`     | PERMANOVA analysis          |

---

# Conclusion

This assignment demonstrated the application of multivariate ecological analysis techniques in R. Bray–Curtis dissimilarity provided the most ecologically meaningful results for abundance data, while NMDS and clustering methods successfully identified ecological relationships among sampling sites. Significant species vectors and PERMANOVA further supported interpretation of ecological community structure.
