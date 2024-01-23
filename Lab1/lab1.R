
EPI_data <- read.csv("c:/code/CSCI4600S24_Ziyue_Zhao/Lab1/2010EPI_data.csv")
EPI_data_name <- EPI_data[1,]
EPI_data = EPI_data[-1,]
colnames(EPI_data) <- c(EPI_data_name)
summary(EPI_data)
attach(EPI_data)
fix(EPI_data)


# Exercise 1
epi_values <- EPI_data$EPI
epi_values <- as.numeric(epi_values)
tf <- is.na(EPI)
EPI <- epi_values[!tf]
summary(EPI)
fivenum(EPI,na.rm=TRUE)
stem(EPI)
hist(EPI)
hist(EPI, seq(30., 95., 1.0), prob=TRUE)
lines(density(EPI,na.rm=TRUE,bw=1.)) # or try bw=“SJ”
lines(density(EPI,na.rm=TRUE,bw="SJ"))
rug(EPI) 

plot(ecdf(EPI), do.points=FALSE, verticals=TRUE)
par(pty="s")
qqnorm(EPI); qqline(EPI)
x <- seq(30,95,1)
qqplot(qt(ppoints(250), df = 5), x, xlab = "Q-Q plot for t dsn")
qqline(x)


# try variable ==> DALY
# exploring the distribution
DALY_values <- EPI_data$DALY
DALY_values <- as.numeric(DALY_values)
tf <- is.na(DALY)
DALY <- DALY_values[!tf]
summary(DALY)
fivenum(DALY,na.rm=TRUE)
hist(DALY, seq(0., 95., 1.0), prob=TRUE)
lines(density(DALY,na.rm=TRUE,bw=1.)) # or try bw=“SJ”
lines(density(DALY,na.rm=TRUE,bw="SJ"))
rug(DALY) 

# fitting a distribution beyond histograms
plot(ecdf(DALY), do.points=FALSE, verticals=TRUE)
par(pty="s")
qqnorm(DALY); qqline(DALY)
x <- seq(0,95,1)
qqplot(qt(ppoints(250), df = 5), x, xlab = "Q-Q plot for t dsn")
qqline(x)


boxplot(EPI,DALY) 
qqplot(EPI,DALY)

# try to create a function to do all this things
exploration <- function(data){
    data <- as.numeric(data)
    tf <- is.na(data)
    data <- data[!tf]
    fivenum(data,na.rm=TRUE)
    min_data <- min(data,na.rm = TRUE)
    min_data <- floor(min_data)
    max_data <- max(data,na.rm = TRUE)
    max_data <- ceiling(max_data)
    hist(data, seq(min_data, max_data, 1.0), prob=TRUE)
    lines(density(data,na.rm=TRUE,bw=1.)) # or try bw=“SJ”
    lines(density(data,na.rm=TRUE,bw="SJ"))
    rug(data) 
}

fitting <- function(data){ 
    data <- as.numeric(data)
    tf <- is.na(data)
    data <- data[!tf]
    fivenum(data,na.rm=TRUE)
    min_data <- min(data,na.rm = TRUE)
    min_data <- floor(min_data)
    max_data <- max(data,na.rm = TRUE)
    max_data <- ceiling(max_data)
    plot(ecdf(data), do.points=FALSE, verticals=TRUE)
    par(pty="s")
    qqnorm(data); qqline(data)
    x <- seq(min_data, max_data, 1.0)
    qqplot(qt(ppoints(250), df = 5), x, xlab = "Q-Q plot for t dsn")
    qqline(x)
    
}

data <- EPI_data$ENVHEALTH
exploration(data)
fitting(data)

data <- EPI_data$ECOSYSTEM
exploration(data)
fitting(data)

data <- EPI_data$AIR_H
exploration(data)
fitting(data)

data <- EPI_data$WATER_H
exploration(data)
fitting(data)

# we could not graph use EPI_data$AIR_EWATER_E, because all fivenum is NA
data <- EPI_data$AIR_EWATER_E

data <- EPI_data$BIODIVERSITY
exploration(data)
fitting(data)



# Exercise 2
#EPILand<-EPI_data[!Landlock]
EPILand <- EPI_data[Landlock==1,]
Eland <- EPILand[!is.na(EPILand),]
Eland$EPI <- as.numeric(Eland$EPI)
hist(Eland$EPI)
hist(Eland$EPI, seq(30., 95., 1.0), prob=TRUE)
data <- Eland$EPI
exploration(data)
fitting(data)

# No_surface_water
EPIN <- EPI_data[No_surface_water==1,]
EPIN <- EPIN[!is.na(EPIN),]
EPIN$EPI <- as.numeric(EPIN$EPI)
hist(EPIN$EPI)
hist(EPIN$EPI, seq(30., 95., 1.0), prob=TRUE)
data <- EPIN$EPI
exploration(data)
fitting(data)

# Desert
EPID <- EPI_data[Desert==1,]
EPID <- EPID[!is.na(EPID),]
EPID$EPI <- as.numeric(EPID$EPI)
hist(EPID$EPI)
hist(EPID$EPI, seq(30., 95., 1.0), prob=TRUE)
data <- EPID$EPI
exploration(data)
fitting(data)


#High_Population_Density

EPIH <- EPI_data[High_Population_Density==1,]
EPIH <- EPIH[!is.na(EPIH),]
EPIH$EPI <- as.numeric(EPIH$EPI)
hist(EPIH$EPI)
hist(EPIH$EPI, seq(30., 95., 1.0), prob=TRUE)
data <- EPIH$EPI
exploration(data)
fitting(data)


#EPI_regions
library(magrittr)
library(dplyr) 
levels(as.factor(EPI_data$EPI_regions))
EPI_South_Asia <- EPI_data %>% 
  select(c('EPI','EPI_regions','GEO_subregion' )) %>%
  mutate(EPI_regions=as.numeric(ordered(EPI_regions, levels = c("South Asia","East Asia and the Pacific", 
                                                                "Eastern Europe and Central Asia","Europe",
                                                                "Latin America and Caribbean","Middle East and North Africa",
                                                                "North America","Sub-Saharan Africa"))))
EPI_South_Asia <- EPI_South_Asia[EPI_South_Asia$EPI_regions==1,]
EPI_South_Asia <- EPI_South_Asia[!is.na(EPI_South_Asia$EPI),]
data <- EPI_South_Asia$EPI
data <- as.numeric(data)
exploration(data)
fitting(data)


# GEO_subregion
levels(as.factor(EPI_data$GEO_subregion))
EPI_South_Asia1 <- EPI_data %>% 
  select(c('EPI','EPI_regions','GEO_subregion' )) %>%
  mutate(GEO_subregion=as.numeric(ordered(GEO_subregion, levels = c(
"South Asia","Arabian Peninsula","Australia and New Zealand", "Caribbean", 
"Central Africa","Central Asia","Central Europe","Eastern Africa","Eastern Europe",
"Mashriq", "Meso America","North America","Northeast Asia","Northern Africa",
"South America","South East Asia","South Pacific","Southern Africa",
"Western Africa","Western Europe","Western Indian Ocean" ))))

EPI_South_Asia1 <- EPI_South_Asia1[EPI_South_Asia1$GEO_subregion==1,]
EPI_South_Asia1 <- EPI_South_Asia1[!is.na(EPI_South_Asia1$EPI),]
data <- EPI_South_Asia1$EPI
data <- as.numeric(data)
exploration(data)
fitting(data)

EPI_data$DALY<-as.numeric(EPI_data$DALY)
EPI_data$EPI<-as.numeric(EPI_data$EPI)
shapiro.test(EPI_data$DALY)


library(readxl)
excel_sheets('c:/code/CSCI4600S24_Ziyue_Zhao/Lab1/2010EPI_data.xls')
EPI_data1 <- read_xls('c:/code/CSCI4600S24_Ziyue_Zhao/Lab1/2010EPI_data.xls',sheet = 4)

summary(EPI_data1$EPI)
fivenum(EPI_data$EPI,na.rm = TRUE)
fivenum(EPI_data1$EPI,na.rm=TRUE)
boxplot(EPI_data1$EPI)

#extreme value distrubution
hist(EPI_data1$EPI)
hist(EPI,seq(30.,95.,1.0), prob=TRUE)
lines(density(EPI,na.rm=TRUE,bw="SJ"))
df <- data.frame(EPI_data1$Population07,EPI_data1$WATER_H)
df$EPI_data1.Population07<- as.numeric(df$EPI_data1.Population07)
df <- df[!is.na(df),]
plot(df)


# work on EPI_Data.csv file

EPI_data <- read.csv("c:/code/CSCI4600S24_Ziyue_Zhao/Lab1/EPI_Data.csv")
summary(EPI_data)
data <- as.numeric(EPI_data$EPI)
tf <- is.na(data)
data <- data[!tf]
fivenum(data,na.rm=TRUE)
min_data <- min(data,na.rm = TRUE)
min_data <- floor(min_data)
max_data <- max(data,na.rm = TRUE)
max_data <- ceiling(max_data)
hist(data, seq(min_data, max_data, 1.0), prob=TRUE)
lines(density(data,na.rm=TRUE,bw=1.)) # or try bw=“SJ”
lines(density(data,na.rm=TRUE,bw="SJ"))
rug(data) 

plot(ecdf(data), do.points=FALSE, verticals=TRUE)
par(pty="s")
qqnorm(data); qqline(data)
x <- seq(min_data, max_data, 1.0)
qqplot(qt(ppoints(250), df = 5), x, xlab = "Q-Q plot for t dsn")
qqline(x)


data <- as.numeric(EPI_data$EPI)
tf <- is.na(data)
data <- data[!tf]
fivenum(data,na.rm=TRUE)
min_data <- min(data,na.rm = TRUE)
min_data <- floor(min_data)
max_data <- max(data,na.rm = TRUE)
max_data <- ceiling(max_data)
hist(data, seq(min_data, max_data, 1.0), prob=TRUE)
lines(density(data,na.rm=TRUE,bw=1.)) # or try bw=“SJ”
lines(density(data,na.rm=TRUE,bw="SJ"))
rug(data) 

plot(ecdf(data), do.points=FALSE, verticals=TRUE)
par(pty="s")
qqnorm(data); qqline(data)
x <- seq(min_data, max_data, 1.0)
qqplot(qt(ppoints(250), df = 5), x, xlab = "Q-Q plot for t dsn")
qqline(x)

# work on GPW3_GRUMP_SummaryInformation_2010.csv file
GPW3_data <- read.csv("c:/code/CSCI4600S24_Ziyue_Zhao/Lab1/GPW3_GRUMP_SummaryInformation_2010.csv")
summary(GPW3_data)
data <- as.numeric(GPW3_data$PopulationPerUnit)
tf <- is.na(data)
data <- data[!tf]
fivenum(data,na.rm=TRUE)
min_data <- min(data,na.rm = TRUE)
min_data <- floor(min_data)
max_data <- max(data,na.rm = TRUE)
max_data <- ceiling(max_data)
hist(data, seq(min_data, max_data, 1.0), prob=TRUE)
lines(density(data,na.rm=TRUE,bw=1.)) # or try bw=“SJ”
lines(density(data,na.rm=TRUE,bw="SJ"))
rug(data) 

plot(ecdf(data), do.points=FALSE, verticals=TRUE)
par(pty="s")
qqnorm(data); qqline(data)
x <- seq(min_data, max_data, 1.0)
qqplot(qt(ppoints(250), df = 5), x, xlab = "Q-Q plot for t dsn")
qqline(x)


data <- as.numeric(GPW3_data$RefYearFirst)
tf <- is.na(data)
data <- data[!tf]
fivenum(data,na.rm=TRUE)
min_data <- min(data,na.rm = TRUE)
min_data <- floor(min_data)
max_data <- max(data,na.rm = TRUE)
max_data <- ceiling(max_data)
hist(data, seq(min_data, max_data, 1.0), prob=TRUE)
lines(density(data,na.rm=TRUE,bw=1.)) # or try bw=“SJ”
lines(density(data,na.rm=TRUE,bw="SJ"))
rug(data) 

plot(ecdf(data), do.points=FALSE, verticals=TRUE)
par(pty="s")
qqnorm(data); qqline(data)
x <- seq(min_data, max_data, 1.0)
qqplot(qt(ppoints(250), df = 5), x, xlab = "Q-Q plot for t dsn")
qqline(x)


data <- as.numeric(GPW3_data$Diff00)
tf <- is.na(data)
data <- data[!tf]
fivenum(data,na.rm=TRUE)
min_data <- min(data,na.rm = TRUE)
min_data <- floor(min_data)
max_data <- max(data,na.rm = TRUE)
max_data <- ceiling(max_data)
hist(data, seq(min_data, max_data, 1.0), prob=TRUE)
lines(density(data,na.rm=TRUE,bw=1.)) # or try bw=“SJ”
lines(density(data,na.rm=TRUE,bw="SJ"))
rug(data) 

plot(ecdf(data), do.points=FALSE, verticals=TRUE)
par(pty="s")
qqnorm(data); qqline(data)
x <- seq(min_data, max_data, 1.0)
qqplot(qt(ppoints(250), df = 5), x, xlab = "Q-Q plot for t dsn")
qqline(x)


data <- as.numeric(GPW3_data$Diff95)
tf <- is.na(data)
data <- data[!tf]
fivenum(data,na.rm=TRUE)
min_data <- min(data,na.rm = TRUE)
min_data <- floor(min_data)
max_data <- max(data,na.rm = TRUE)
max_data <- ceiling(max_data)
hist(data, seq(min_data, max_data, 1.0), prob=TRUE)
lines(density(data,na.rm=TRUE,bw=1.)) # or try bw=“SJ”
lines(density(data,na.rm=TRUE,bw="SJ"))
rug(data) 

plot(ecdf(data), do.points=FALSE, verticals=TRUE)
par(pty="s")
qqnorm(data); qqline(data)
x <- seq(min_data, max_data, 1.0)
qqplot(qt(ppoints(250), df = 5), x, xlab = "Q-Q plot for t dsn")
qqline(x)


data <- as.numeric(GPW3_data$Diff90)
tf <- is.na(data)
data <- data[!tf]
fivenum(data,na.rm=TRUE)
min_data <- min(data,na.rm = TRUE)
min_data <- floor(min_data)
max_data <- max(data,na.rm = TRUE)
max_data <- ceiling(max_data)
hist(data, seq(min_data, max_data, 1.0), prob=TRUE)
lines(density(data,na.rm=TRUE,bw=1.)) # or try bw=“SJ”
lines(density(data,na.rm=TRUE,bw="SJ"))
rug(data) 

plot(ecdf(data), do.points=FALSE, verticals=TRUE)
par(pty="s")
qqnorm(data); qqline(data)
x <- seq(min_data, max_data, 1.0)
qqplot(qt(ppoints(250), df = 5), x, xlab = "Q-Q plot for t dsn")
qqline(x)



data <- data.frame(as.numeric(GPW3_data$Diff90),as.numeric(GPW3_data$Diff95),as.numeric(GPW3_data$Diff00))
colnames(data)<-c("Diff90","Diff95","Diff00")
boxplot(data)


# work on water-treatment.csv file
water_treatment <- read.csv("c:/code/CSCI4600S24_Ziyue_Zhao/Lab1/water-treatment.csv")
summary(water_treatment)
data <- as.numeric(water_treatment$SS.E)
tf <- is.na(data)
data <- data[!tf]
fivenum(data,na.rm=TRUE)
min_data <- min(data,na.rm = TRUE)
min_data <- floor(min_data)
max_data <- max(data,na.rm = TRUE)
max_data <- ceiling(max_data)
hist(data, seq(min_data, max_data, 1.0), prob=TRUE)
lines(density(data,na.rm=TRUE,bw=1.)) # or try bw=“SJ”
lines(density(data,na.rm=TRUE,bw="SJ"))
rug(data) 

plot(ecdf(data), do.points=FALSE, verticals=TRUE)
par(pty="s")
qqnorm(data); qqline(data)
x <- seq(min_data, max_data, 1.0)
qqplot(qt(ppoints(250), df = 5), x, xlab = "Q-Q plot for t dsn")
qqline(x)


data <- as.numeric(water_treatment$SSV.E)
tf <- is.na(data)
data <- data[!tf]
fivenum(data,na.rm=TRUE)
min_data <- min(data,na.rm = TRUE)
min_data <- floor(min_data)
max_data <- max(data,na.rm = TRUE)
max_data <- ceiling(max_data)
hist(data, seq(min_data, max_data, 1.0), prob=TRUE)
lines(density(data,na.rm=TRUE,bw=1.)) # or try bw=“SJ”
lines(density(data,na.rm=TRUE,bw="SJ"))
rug(data) 

plot(ecdf(data), do.points=FALSE, verticals=TRUE)
par(pty="s")
qqnorm(data); qqline(data)
x <- seq(min_data, max_data, 1.0)
qqplot(qt(ppoints(250), df = 5), x, xlab = "Q-Q plot for t dsn")
qqline(x)


data <- as.numeric(water_treatment$SSV.P)
tf <- is.na(data)
data <- data[!tf]
fivenum(data,na.rm=TRUE)
min_data <- min(data,na.rm = TRUE)
min_data <- floor(min_data)
max_data <- max(data,na.rm = TRUE)
max_data <- ceiling(max_data)
hist(data, seq(min_data, max_data, 1.0), prob=TRUE)
lines(density(data,na.rm=TRUE,bw=1.)) # or try bw=“SJ”
lines(density(data,na.rm=TRUE,bw="SJ"))
rug(data) 

plot(ecdf(data), do.points=FALSE, verticals=TRUE)
par(pty="s")
qqnorm(data); qqline(data)
x <- seq(min_data, max_data, 1.0)
qqplot(qt(ppoints(250), df = 5), x, xlab = "Q-Q plot for t dsn")
qqline(x)

data <- data.frame(as.numeric(water_treatment$SSV.S),as.numeric(water_treatment$SSV.P),
                   as.numeric(water_treatment$SSV.E),as.numeric(water_treatment$SSV.D))
colnames(data)<-c("SSV.S","SSV.P","SSV.E","SSV.D")
summary(data)
boxplot(data)


# work on 2016EPI_Raw_Data.xls file
library(readxl)
excel_sheets('c:/code/CSCI4600S24_Ziyue_Zhao/Lab1/2016EPI_Raw_Data.xls')
EPI_data1 <- read_xls('c:/code/CSCI4600S24_Ziyue_Zhao/Lab1/2016EPI_Raw_Data.xls',sheet = 3)
summary(EPI_data1)
EPI_data1 <- EPI_data1[,-c(1:3)]
EPI_data1[EPI_data1<=-9999] <- NA
summary(EPI_data1)
EPI_data1 <- na.omit(EPI_data1)
boxplot(EPI_data1,scale = TRUE,center = TRUE)


data <- as.numeric(EPI_data1$ACSAT.2009)
tf <- is.na(data)
data <- data[!tf]
fivenum(data,na.rm=TRUE)
min_data <- min(data,na.rm = TRUE)
min_data <- floor(min_data)
max_data <- max(data,na.rm = TRUE)
max_data <- ceiling(max_data)
hist(data, seq(min_data, max_data, 1.0), prob=TRUE)
lines(density(data,na.rm=TRUE,bw=1.)) # or try bw=“SJ”
lines(density(data,na.rm=TRUE,bw="SJ"))
rug(data) 

plot(ecdf(data), do.points=FALSE, verticals=TRUE)
par(pty="s")
qqnorm(data); qqline(data)
x <- seq(min_data, max_data, 1.0)
qqplot(qt(ppoints(250), df = 5), x, xlab = "Q-Q plot for t dsn")
qqline(x)



data <- as.numeric(EPI_data1$ACSAT.2010)
tf <- is.na(data)
data <- data[!tf]
fivenum(data,na.rm=TRUE)
min_data <- min(data,na.rm = TRUE)
min_data <- floor(min_data)
max_data <- max(data,na.rm = TRUE)
max_data <- ceiling(max_data)
hist(data, seq(min_data, max_data, 1.0), prob=TRUE)
lines(density(data,na.rm=TRUE,bw=1.)) # or try bw=“SJ”
lines(density(data,na.rm=TRUE,bw="SJ"))
rug(data) 

plot(ecdf(data), do.points=FALSE, verticals=TRUE)
par(pty="s")
qqnorm(data); qqline(data)
x <- seq(min_data, max_data, 1.0)
qqplot(qt(ppoints(250), df = 5), x, xlab = "Q-Q plot for t dsn")
qqline(x)

