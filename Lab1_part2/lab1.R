
# Base R plot
plot(mtcars$wt, mtcars$mpg)

# Loading the ggplot2 library
library(ggplot2)

# Using qplot (quick plot) from ggplot2
qplot(mtcars$wt, mtcars$mpg)
qplot(wt, mpg, data = mtcars)

# Using ggplot with geom_point
ggplot(mtcars, aes(x=wt, y=mpg)) + geom_point()

# Base R plot with type="l" for lines
plot(pressure$temperature, pressure$pressure, type = "l")
points(pressure$temperature, pressure$pressure)

# Base R plot with lines and points in different colors
lines(pressure$temperature, pressure$pressure/2, col="red")
points(pressure$temperature, pressure$pressure/2, col="blue")

# Loading the ggplot2 library again (which is redundant if already loaded)
library(ggplot2)

# Using qplot with geom="line"
qplot(pressure$temperature, pressure$pressure, geom="line")

# Using ggplot to create a line plot
ggplot(pressure, aes(x=temperature, y=pressure)) + geom_line() + geom_point()
ggplot(pressure, aes(x=temperature, y=pressure)) + geom_line() + geom_point()
# Creating Bar graphs
barplot(BOD$demand, names.arg = BOD$Time)
table(mtcars$cyl)
barplot(table(mtcars$cyl)) # generate a table of counts.
qplot(mtcars$cyl) # cyl is continuous here
qplot(factor(mtcars$cyl)) # treat cyl as discrete

# Bar graph of counts
qplot(factor(cyl), data = mtcars)
ggplot(mtcars, aes(x=factor(cyl))) + geom_bar()
# Creating Histogram
# View the distribution of one-dimensional data with a histogram.
hist(mtcars$mpg)
hist(mtcars$mpg, breaks = 10) # specify approximate number of bins with breaks.
hist(mtcars$mpg, breaks = 5)
hist(mtcars$mpg, breaks = 12)

qplot(mpg, data = mtcars, binwidth=4)
ggplot(mtcars, aes(x=mpg)) + geom_histogram(binwidth = 4)
ggplot(mtcars, aes(x=mpg)) + geom_histogram(binwidth = 5)

# Creating Box-plot
plot(ToothGrowth$supp, ToothGrowth$len) # using plot() function and pass it a factor of x-values and a vector of y-values.
#Formula Syntax
boxplot(len ~ supp, data = ToothGrowth) # if the tow vectors are in the same dataframe, you can use the formula syntax. With this syntax you can combine two variables on the x-axis.
# put interaction of two variables on x-axis
boxplot(len ~ supp + dose, data = ToothGrowth)
# with ggplot2 you can get the same results above.
library(ggplot2)
qplot(ToothGrowth$supp, ToothGrowth$len, geom = "boxplot")
# if the two vectors are in the same dataframe, you can use the following syntax
qplot(supp, len, data = ToothGrowth, geom = "boxplot")
# in ggplot2, the above is equivalent to:
ggplot(ToothGrowth, aes(x=supp, y=len)) + geom_boxplot()
# Using three seperate vectors
qplot(interaction(ToothGrowth$supp, ToothGrowth$dose), ToothGrowth$len, geom = "boxplot")
# You can write the same thing above, get the columns from the dataframe
qplot(interaction(supp, dose), len, data = ToothGrowth, geom = "boxplot")
# Using ggplot() you can do the samething and it is equivalent to:
ggplot(ToothGrowth, aes(x=interaction(supp, dose), y=len)) + geom_boxplot()
#Plotting a function curve









# Calling grid library
library(grid)
# Creating a rectangle
grid.rect(height=0.25,width=0.25)
# A rounded rectangle
grid.roundrect(height=0.2,width=0.2)
# A circle
grid.circle(r=0.1)
# Inserting text within the shape
grid.text("R Graphics")
# Drawing a polygon
grid.polygon()









# data generation
# Set the seed to make the example reproducible
set.seed(1234)
incubation_period <-
  c(rnorm(100,mean=10),rnorm(100,mean=15),rnorm(100,mean=5),rnorm(100,mean=20))
exposure_cat <- sort(rep(c(1:4),100))
dis_dat<-data.frame(incubation_period,exposure_cat)
# Producing histogram for each of the exposure category 1, 2, 3, and 4
# using traditional visualization code. The code below for
# panel histogram for different values of the variable
# exposure_cat. This code will produce a 2 x 2 matrix where
# we will have four different histograms.
op<-par(mfrow=c(2,2))
hist(dis_dat$incubation_period[dis_dat$exposure_cat==1])
hist(dis_dat$incubation_period[dis_dat$exposure_cat==2])
hist(dis_dat$incubation_period[dis_dat$exposure_cat==3])
hist(dis_dat$incubation_period[dis_dat$exposure_cat==4])
par(op)







library(lattice)
histogram(~incubation_period | factor(exposure_cat),
          data=dis_dat)
plot(incubation_period ~ factor(exposure_cat), data=dis_dat)
plot(incubation_period ~ exposure_cat, data=dis_dat)





# loading ggplot2 library
library(ggplot2)
# creating a basic ggplot object
p <- ggplot(data=mtcars)
# Creating scatter plot of mpg and disp variable
p1 <- p+geom_point(aes(x=disp,y=mpg))
# creating line chart from the same ggplot object but
different
# geom function
p2 <- p+geom_line(aes(x=disp,y=mpg))
# creating bar chart of mpg variable
p3 <- p+geom_bar(aes(x=mpg))
# creating boxplot of mpg over gear
p4 <- p+geom_boxplot(aes(x=factor(gear),y=mpg))
# writing certain text into the scatter plot
p5 <- p1+geom_text(x=200,y=25,label="Scatter plot")






col="yellow" #Setting the color to yellow
plot(cars$dist~cars$speed)
plot(cars$dist~cars$speed, # y~x
     main="Relationship between car distance & speed", # Plot Title
     xlab="Speed (miles per hour)", #X axis title
     ylab="Distance travelled (miles)", #Y axis title
     xlim=c(0,30), #Set x axis limits from 0 to 30
     ylim=c(0,140), #Set y axis limits from 0 to 140
     xaxs="i", #Set x axis style as internal
     yaxs="i", #Set y axis style as internal
     col="red", #Set the color of plotting symbol to red
     pch=19) #Set the plotting symbol to filled dots
points(cars$dist~cars$speed,pch=3)



# page 56
