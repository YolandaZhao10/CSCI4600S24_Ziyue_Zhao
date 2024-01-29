# Creating a dataframe
# Example: RPI Weather dataframe.

days = c('Mon', 'Tue','Wed','Thur','Fri','Sat','Sun') #  days
temp <- c(28,30.5,32,31.2,29.3,27.9,26.4) # Temperature in F' during the winter :)
snowed <- c('T','T','F','F','T','T','F') # This is what I want : Snowed on that day: T = TRUE, F= FALSE
snowed
class(snowed)
help("data.frame")
RPI_Weather_Week <- data.frame(days,temp,snowed) # creating the dataframe using the data.frame() function

RPI_Weather_Week 
head(RPI_Weather_Week) # head of the data frame, NOTE: it will show only 6 rows, usually head() function shows the 
# first 6 rows of the dataframe, here we have only 7 rows in our dataframe. 

str(RPI_Weather_Week) # we can take a look at the structure of the dataframe using the str() function.

summary(RPI_Weather_Week) # summary of the dataframe using the summary() function

RPI_Weather_Week[1,] # showing the 1st row and all the columns
RPI_Weather_Week[,1] # showing the 1st coulmn and all the rows

RPI_Weather_Week[,'snowed']
RPI_Weather_Week[,'days']
RPI_Weather_Week[,'temp']
RPI_Weather_Week[1:5,c("days","temp")]
RPI_Weather_Week[1:5,c("days","snowed")]
RPI_Weather_Week$temp
RPI_Weather_Week$snowed
subset(RPI_Weather_Week,subset=snowed==TRUE)


sorted.snowed <- order(RPI_Weather_Week$snowed)
sorted.snowed
RPI_Weather_Week[sorted.snowed,]

#descending_snowed <- order(-RPI_Weather_Week['snowed'])
# descending_snowed

# RPI_Weather_Week[descending_snowed,]


dec.snow <- order(-RPI_Weather_Week$temp)
dec.snow
# Creating Dataframes
# creating an empty dataframe
empty.DataFrame <- data.frame()
empty.DataFrame

v1 <- 1:10
v1
letters
v2 <- letters[1:10]
v2
df <- data.frame(col_name.1 = v1,First10Letters = v2)
df
# importing data and exporting data
# writing to a CSV file:
write.csv(df,file = 'saved_df1_Section2.csv')
df_section2 <- read.csv('saved_df1_Section2.csv')
df_section2

nrow(df)
ncol(df)
dim(df)
colnames(df)
rownames(df)
str(df)
summary(df)

# Referencing Cells
df[[5,2]]
df[[5,'col.name.2']]
df[[3,'col.name.1']]
df[[4,'col.name.2']]
df[[3,'col.name.2']] <- 3000
df 
df[[3,'col.name.2']] <- 'c'
df
df[[3,"col.name.1"]] <- 3300
df
df[2,] # referencing rows
head(mtcars)
mtcars$mpg
mtcars[,'mpg']
mtcars[['mpg']]
mtcars['mpg']
mtcars[1]
mtcars[c('mpg','cyl')]
head(mtcars[c('mpg','cyl')])
# Adding rows to the Data Frames
df2 <-data.frame(col.name.1= 2500, col.name.2 = 'new')
df2
dfNew <- rbind(df,df2)
dfNew

persons.df <- data.frame(FirstName = 'Thilanka', LastName ='Munasinghe', ID = 123456, Instituete = 'RPI')
persons.df

# Adding new Columns to the Data Frame.
df$newcol <- 3*df$col.name.1
df
# making a copy of a column and adding that to the data frame
df$copyCol2 <- df$col.name.2
df
# Also you can do this way as well:
df[,'copy2_Col2'] <- df$col.name.2
df
# Find out the Column names
colnames(df)
# Rename the coulumns
# renaming the 4th column
colnames(df)[4] <- 'LETTERS'
df
# Not selecting a row in a data frame
# Not selecting the 3rd row in this data frame
df[-3,]
# Not selecting the 4th column in this data frame
df[,-4]
# Conditional Collection:
head(mtcars)
# selecting the mpg > 20
mtcars[mtcars$mpg >20,]
# selecting the mpg > 20 and cyl == 4
mtcars[mtcars$mpg >20 & mtcars$cyl == 4 ,]
# it is better to use the () in your logical statement, therefore you can do the above with () 
mtcars[(mtcars$mpg >20) & (mtcars$cyl ==4) , ]
# if you want to select specific columns, 
mtcars[(mtcars$mpg >20) & (mtcars$cyl == 4) , c('mpg','cyl','hp')]
mtcars[(mtcars$mpg >20) & (mtcars$cyl == 4) , c('cyl','hp')]
mtcars[(mtcars$mpg >20) & (mtcars$cyl == 4) , c('mpg')]
mtcars[(mtcars$mpg >20) & (mtcars$cyl == 4) , c('hp')]
mtcars[, c(1,2,3)]

# using the subset() function 
subset(mtcars, mpg > 20 & cyl == 4)

# Checking for missing data
is.na(mtcars)
any(is.na(mtcars))
any(is.na(mtcars$mpg))

df[is.na(df)] <- 0
df

mtcars$mpg[is.na(mtcars$mpg)] <- mean(mtcars$mpg)

# Examples with DataFrames:
Age <- c(27,25,26,28)
Weight <- c(155,175,130,155)
Sex <- c('M','M','F','O')
Names <- c('Jim','John','Kristin','Dorthy')
people <- data.frame(Names, Age = Age, Weight = Weight, Sex = Sex)
people2 <- data.frame(Names, Age, Weight, Sex)
people2

df <- data.frame(row.names = Names, Age, Weight,Sex)
df
is.na(df)
is.data.frame(df)
# names <- data.frame(Age,Weight,Sex)
# names

mat <- matrix(1:25,nrow = 5)
mat2 <- as.data.frame(mat)
is.data.frame(mat2)


df <- mtcars
head(df)
Avg.mpg <- mean(df$mpg)
Avg.mpg
df[df$cyl==6,]
df[df$cyl==6, c('am','gear','carb')]
df[, c('am','gear','carb')]
df$performance <- df$hp/df$wt
head(df)
help("round") # Read the help function for round() 
# round the performance column values to 2 decimal points.
df$performance <- round(df$hp/df$wt,2)
head(df)

m1 <- df[df$hp >100 & df$wt >2.5,]
m1
mean(m1$mpg)
mean((df[df$hp >100 & df$wt > 2.5 ,])$mpg)

df['Hornet Sportabout','mpg']

# Lists 
vec <- c(6,7,8) # vector
mat <- matrix(1:30, nrow = 5) # matrix
mat
class(vec)
class(mat)
# if you want to include different data structures in to one single variable, you can use the list()
# list() function allow us to combine different datastructure into a single variable.
my.list <- list(vec,mat,df)
my.list
# instead of having automatically numbered, we can name the item in the list as follows:
my.named.list <- list(sampleVec = vec, SampleMatrix = mat, SampleDataFrame = df)
my.named.list

# List is more like an organizational tool, you can organize various dataframes 
# One advantage is, you can call the items in the list using the $ sign to call them as you call them like coulums.
my.named.list$sampleVec
my.named.list$SampleMatrix
my.named.list$SampleDataFrame

# Data Input/Output in R
# Read and Write CSV file
# Write CSV 
write.csv(mtcars, file = 'vehicles.csv')
# Read CSV
# if the CSV is in your working-directory in RStudio, then you can directly call it as follows ( otherwise you need to give the path to that file)
Vehicles <- read.csv('vehicles.csv') 
head(Vehicles)
tail(Vehicles)
class(Vehicles) 
# Excell Files input in RStudio
# In order to read the Excel file in R, you need to install the "readxl" package.
install.packages('readxl')
library(readxl)
excel_sheets('~/Downloads/EPI_data.xls')
help("excel_sheets")
my_data <- read_excel(file.choose())
my_data
my_data$`2010 Environmental Performance Index (EPI)`

# Writing xlsx files
# first install the package 'xlsx'
install.packages('xlsx')
library(xlsx)
write.xlsx(mtcars,'Vehicles.xlsx')

# How to read a dataframe using the read.csv()

myData = read.csv(file.choose(),header =TRUE)
str(myData)
dim(myData)
myData
head(myData)
View(myData)
myData$EPI
