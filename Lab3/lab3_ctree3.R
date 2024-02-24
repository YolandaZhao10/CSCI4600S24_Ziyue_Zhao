fitK <- ctree(Kyphosis ~ Age + Number + Start, data=kyphosis)
plot(fitK, main="Conditional Inference Tree for Kyphosis")
plot(fitK, main="Conditional Inference Tree for Kyphosis",type="simple")
plot(fitK, main="Conditional Inference Tree for Kyphosis",type="simple",xlab = "Kyphosis Status")
plot(fitK, main="Conditional Inference Tree for Kyphosis",type="simple",xlab = "Kyphosis Status",ylab = "Proportion")
#etc.

