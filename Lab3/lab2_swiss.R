data(swiss)
summary(swiss)
sclass <- kmeans(swiss[1:6], 3) 
table(sclass$cluster, swiss[,2])    
# 
library(e1071)
nam <- swiss[, -2]
m <- naiveBayes(nam, swiss[, 2])
table(predict(m, nam, swiss[, 2]))

