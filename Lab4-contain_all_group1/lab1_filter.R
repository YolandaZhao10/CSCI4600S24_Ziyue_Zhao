#Landlock

EPI_data <- read.csv("c:/code/CSCI4600S24_Ziyue_Zhao/Lab1/2010EPI_data.csv")
EPI_data_name <- EPI_data[1,]
EPI_data = EPI_data[-1,]
colnames(EPI_data) <- c(EPI_data_name)
summary(EPI_data)

EPI<-EPI_data

EPILand<-EPI[EPI$Landlock != 0, ]
EPILand <- EPILand[!is.na(EPILand$EPI),]
EPILand<- as.numeric(EPILand$EPI)
hist(EPILand)
hist(EPILand, seq(30., 95., 1.0), prob=TRUE)

