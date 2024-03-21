data(Titanic)
mdl <- naiveBayes(Survived ~ ., data = Titanic)
mdl
predict(mdl, Titanic)

# etc.

