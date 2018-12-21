# ---
# Title: Data Science Workshop in R 
# Description: PCA using R
# Author:Arvind Iyer <arvind16122@iiitd.ac.in>,Debarka Sengputa<debarka@iiitd.ac.in> 
# Referenes: Various Online Resources
# Feel free to get in touch with us would love to talk :):)
# ---

# Clean workspace
rm(list=ls(all=TRUE))

#set working directory
setwd('data_science_workshop/')

# Import packages used for the tutorial
library(factoextra)



# Dataset description: Athletes' performance during two sporting meetings
data(decathlon2)
# View type of the dataset
str(decathlon2)
# Will use a subset dataset 
decathlon2.subset <- decathlon2[1:27, 1:10]
# View first 6 elements
head(decathlon2.subset[, 1:6])

# Compute PCA
pca.out <- prcomp(decathlon2.subset, scale = TRUE)
# View strucutre pca.out object
str(pca.out)

### Understanding the result using factoextra package and visualization

# Calculated as follows 
# pca.var <- pca.ou$sdev^2
# pca.var.per <- round(pca.var/sum(pca.var)*100, 1)
# get_eigenvalue: Used Extract the eigenvalues/variances of principal components
eig.val <- get_eigenvalue(pca.out)
eig.val

# Visualize eigenvalues (scree plot)
# Used to detrmine how many PC components are enough
# From this plot we might make first 3-4 componets represent well to this data
fviz_eig(pca.out,main = "Scree Plot")

## Results for Variables (Factor Variable Analysis)
# get_pca_var: Used Extract the data related to variables for the dataset related to PCA analysis
# Output of get_pca_var
##   Name       Description                                    
## 1 "$coord"   "Coordinates for the variables"                
## 2 "$cor"     "Correlations between variables and dimensions"
## 3 "$cos2"    "Cos2 for the variables"                       
## 4 "$contrib" "contributions of the variables"

res.var <- get_pca_var(pca.out)
res.var
res.var$coord          # Coordinates
res.var$contrib        # Contributions to the PCs:The contribution of a variable (var) to a given principal component is : (var.cos2 * 100) / (total cos2 of the component).
res.var$cos2           # Quality of representation It’s calculated as the squared coordinates: var.cos2 = var.coord * var.coord.

#Graph of variables. 
# The correlation between a variable and a principal component (PC) is used as the coordinates of the variable on the PC.
# Positive correlated variables point to the same side of the plot. Negative correlated variables point to opposite sides of the graph.
# Variable Correlation Plot
fviz_pca_var(pca.out,repel = TRUE)

# Quality of variable (Quality of representation)
# The quality of representation of the variables on factor map is called cos2(squred coordinates)
# fviz_pca_var(pca.out, col.var = "cos2",
#              gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"), 
#              repel = TRUE # Avoid text overlapping
# )


# Total cos2 of variables on Dim.1 and Dim.2
# A high value means good reprsentation and low values means not good and not represented in that PC.
# fviz_cos2(pca.out, choice = "var", axes = 1:2)

# Know how variables are impacting the PC are important.
# The red dashed line on the graph above indicates the expected average contribution. If the contribution of the variables were uniform, the expected value would be 1/length(variables) = 1/10 = 10%. 
fviz_contrib(pca.out, choice = "var", axes = 1, top = 10)
# Contributions of variables to PC2
fviz_contrib(pca.out, choice = "var", axes = 2, top = 10)


#The total contribution of a given variable, on explaining the variations retained by two principal components, say PC1 and PC2, is calculated as contrib = [(C1 * Eig1) + (C2 * Eig2)]/(Eig1 + Eig2)

# Correlation Variable Plot colored by total contribution.
# fviz_pca_var(pca.out,
#              col.var = "contrib", # Color by contributions to the PC
#              gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),
#              repel = TRUE     # Avoid text overlapping
#              )




# Results for individuals/samples
# get_pca_indr: Used Extract the data related to samples for the dataset related to PCA analysis
# Output of get_pca_var
##   Name       Description                       
## 1 "$coord"   "Coordinates for the individuals" 
## 2 "$cos2"    "Cos2 for the individuals"        
## 3 "$contrib" "contributions of the individuals"

res.ind <- get_pca_ind(pca.out)
res.ind$coord          # Coordinates
res.ind$contrib        # Contributions to the PCs
res.ind$cos2           # Quality of representation 

# Plotiing indivuals on first two PC's
fviz_pca_ind(pca.out)

# fviz_pca_ind(pca.out, col.ind = "cos2", 
#              gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),
#              repel = TRUE # Avoid text overlapping (slow if many points)
# )


# Total contribution on PC1 and PC2
fviz_contrib(pca.out, choice = "ind", axes = 1:2)

# Always Know the version of libray you are using as inter dependecies may effect your analysis
sessionInfo()


# Additional Links
# http://www.statpower.net/Content/312/R%20Stuff/PCA.html
# https://www.analyticsvidhya.com/blog/2016/03/practical-guide-principal-component-analysis-python/
# https://www.datacamp.com/community/tutorials/pca-analysis-r (Biplot Analysis)
# https://statquest.org/2017/11/27/statquest-pca-in-r-clearly-explained/


# Thank You
# Happy Learning and Sharing
