# Normality Tests...
# Normal Distribution
# Read the documentation of the random distribution function
help("rnorm")
set.seed(10)
data1 <- rnorm(50)

set.seed(30)
data2 <- rnorm(50)

# Shapiro-Wilk Normality Test
# Read the documentation of Shapiro-Wilk Normality Test
help("shapiro.test")

# As the test returns a p-value less than 0.05, we reject the null hypothesis
# and conclude that the population data is not normally distributed.
shapiro.test(data1)
hist(data1, col='green')
# the histogram shows that the curve is mildly left skewed in nature

shapiro.test(data2)
# As the test returns a p-value greater than 0.05, we accept the null hypothesis
# and conclude that the population data is normally distributed.
hist(data2, col='steelblue') # the histogram shows that the curve is normally distributed in nature

# We set the seed to make the example reproducible make this example reproducible
set.seed(0)
# Poisson Distribution
help("rpois")
# create dataset of 100 random values generated from a Poisson distribution
data <- rpois(n=100, lambda=3)
# perform Shapiro-Wilk test for normality
shapiro.test(data)
# The p-value of the test turns out to be 0.0003393.
# Since this value is less than 0.05, we have sufficient evidence
# to say that the sample data does not come from a population that is normally distributed.
# This result shouldn't be surprising since we generated the sample data using the rpois() function,
# rpois() generates random values from a Poisson distribution.
hist(data, col='yellow')
# We can see that the distribution is right-skewed and doesn't have the typical "bell-shape",
# so it is not normal distribution.
# Histogram matches the results of the Shapiro-Wilk test and confirms that our sample data
# does not come from a normal distribution.
# ================================================================================

# Anderson-Darling test for normality
help("ad.test")
# To conduct an Anderson-Darling Test in R, we can use the ad.test() function within the nortest library.
# The following examples shows how to conduct an Anderson-Darling Test to check
# whether or not a vector of 100 values follows a normal distribution:
# Make sure to install and load "nortest" library
# install.packages('nortest')
library(nortest)
# we use seed() function make this example reproducible
set.seed(1)
# defined vector of 100 values that are normally distributed
x <- rnorm(100, 0, 1)
# conduct Anderson-Darling Test to test for normality
ad.test(x)

