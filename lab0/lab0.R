#MASS library

library(MASS) # load the library MASS
attach(Boston) # attaching the dataset
?Boston # help function with "?"
head(Boston) # show the head of the dataset
dim(Boston) # dimensions of the dataset
names(Boston) # column names
str(Boston) # str function shows the structure of the dataset
nrow(Boston) # function shows the number of rows
ncol(Boston) # function shows the number of columns
summary(Boston) # summary() function shows the summary statistics
summary(Boston$crim) # summary of the "crime" column in the Boston dataset


# ISLR library
library(ISLR)
data(Auto)
head(Auto)
names(Auto)
summary(Auto)
summary(Auto$mpg)
fivenum(Auto$mpg)
boxplot(Auto$mpg)
hist(Auto$mpg)
summary(Auto$horsepower)
summary(Auto$weight)
fivenum(Auto$weight)
boxplot(Auto$weight)
mean(Auto$weight)
median((Auto$weight))

#read csv
EPI_data <- read.csv("c:/code/CSCI4600S24_Ziyue_Zhao/Lab1/2010EPI_data.csv")
EPI_data_name <- EPI_data[1,]
EPI_data = EPI_data[-1,]
colnames(EPI_data) <- c(EPI_data_name)

#read xls
library(readxl)
excel_sheets('c:/code/CSCI4600S24_Ziyue_Zhao/Lab1/2010EPI_data.xls')
EPI_data1 <- read_xls('c:/code/CSCI4600S24_Ziyue_Zhao/Lab1/2010EPI_data.xls',sheet = 4)

#choose file
help(read.csv)
data1 <- read.csv(file.choose(),header=T)


fivenum(EPI_data$EPI)
summary(EPI_data$EPI)
plot(EPI_data$EPI,EPI_data$Population07)
boxplot(EPI_data$EPI)
hist(EPI_data$EPI)

pt(q=-1.549, df=14, lower.tail = TRUE)
