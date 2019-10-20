rm(list = ls())
setwd("/home/cnemri/Documents/JHU Data Science/Getting and Cleaning Data")

library(reshape2)
head(mtcars)

# 1 - Melting data frames
mtcars$carname <- rownames(mtcars)
carMelt <- melt(mtcars,id=c('carname','gear','cyl'), measure.vars = c('mpg','hp'))

head(carMelt, n=3)
tail(carMelt, n=3)

# 2 - Casting data frames
cylData <- dcast(carMelt, cyl ~ variable);cylData # length is default aggregation function
cylData <- dcast(carMelt, cyl ~ variable, mean); cylData

# 3 - Averaging values
head(InsectSprays)
tapply(InsectSprays$count, InsectSprays$spray, sum)

# 4 - Another way / Split
spIns = split(InsectSprays$count, InsectSprays$spray); spIns
sprCount = lapply(X = spIns,FUN = sum);sprCount
unlist(sprCount)
# or directly using sapply
sapply(X = spIns, sum)

# 6 - Using the plyr package
library(plyr)
ddply(.data = InsectSprays, .variables = .(spray), .fun = summarise, sum(count))

# 7 - Creating a new variable
spraySums <- ddply(InsectSprays, .(spray), summarise, sum = ave(count, FUN=sum))
dim(spraySums)