# Load necessary libraries
library(rpart)

# Assuming the Abalone dataset is already loaded into a data frame called `abalone`
# Here's how to load the dataset from a file (CSV for example):
abalone <- read.csv("c:/code/CSCI4600_hw/DA_Files/abalone.csv")

# Fit the decision tree model
# Replace the dots with the actual predictor variables you want to include
abalone_tree <- rpart(Rings ~ ., data=abalone, method="anova")

# Plot the decision tree
plot(abalone_tree)
text(abalone_tree, use.n=TRUE)

# Prune the tree if necessary
cp_values <- abalone_tree$cptable[, "CP"]
best_cp <- cp_values[which.min(abalone_tree$cptable[, "xerror"])]
pruned_tree <- prune(abalone_tree, cp=best_cp)

# Plot the pruned tree
plot(pruned_tree)
text(pruned_tree, use.n=TRUE)


