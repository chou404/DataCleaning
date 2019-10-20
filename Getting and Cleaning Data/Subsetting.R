setwd("/home/cnemri/Documents/JHU Data Science/Getting and Cleaning Data")
set.seed(13435)

X <- data.frame('var1'=sample(1:5), 'var2'=sample(6:10), 'var3'=sample(11:15))
X <- X[sample(1:5),]; X$var2[c(1,3)]=NA
X

sort(X$var1)

library(plyr)
# order data.frame by the increasing values of var1
arrange(X,var1)

# order data.frame by the descreasing values of var1
arrange(X,desc(var1))

X$var4 <- rnorm(5)

Y <- cbind(X, rnorm(5))