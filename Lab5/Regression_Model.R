# Cook's Distance example using mtcars
mtcars
head(mtcars)
str(mtcars)

# Create a linear model
model1 <- lm(mpg ~ cyl + wt, data = mtcars)
model1

# For getting help on Cook's distance function
help("cooks.distance")

# Plotting the model with Cook's Distance indicated
plot(model1, pch = 18, col = 'red', which = c(4))

# We can use the cooks.distance() function to identify the Cook's distance to each observation
cooks.distance(model1)

# Store Cook's Distance in a variable
CooksDistance <- cooks.distance(model1)

# Now we will round off the values to 5 decimal points so that it is easy to read
# we can use the round() function to round off values in R.
round(CooksDistance, 5)
sort(round(CooksDistance, 5))
