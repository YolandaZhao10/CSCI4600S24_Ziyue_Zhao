library(kknn)
data(iris)
m <- dim(iris)[1]
val <- sample(1:m, size = round(m/3), replace = FALSE, prob = rep(1/m, m)) 
iris.learn <- iris[-val,] 	# train
iris.valid <- iris[val,]	# test
iris.kknn <- train.kknn(Species~., iris.learn, distance = 1, kernel = c("triangular", "epanechnikov", "biweight", "triweight", "cos", "inv", "gaussian", "rank", "optimal") )
summary(iris.kknn)
table(predict(iris.kknn,iris.valid),iris.valid$Species)

summary(iris.kknn$data)
head(iris.kknn$data$Sepal.Length)
head(iris.kknn$data$Sepal.Width)
head(iris.kknn$data$Petal.Width)
head(iris.kknn$data$Petal.Length)
head(iris.kknn$data$Species)
head(iris.kknn$fitted.values)

