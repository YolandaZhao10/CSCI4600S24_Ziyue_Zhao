library(rpart)
library(rpart.plot)
swiss_rpart <- rpart(Fertility ~ Agriculture + Education + Catholic, data = swiss)
plot(swiss_rpart) # try some different plot options
text(swiss_rpart) # try some different text options

plot(swiss_rpart,main="swiss_rpart")
text(swiss_rpart,cex = .8) 

plot(swiss_rpart,sub="swiss_rpart")
text(swiss_rpart,adj = c(0,0)) 

rpart.plot(swiss_rpart)


