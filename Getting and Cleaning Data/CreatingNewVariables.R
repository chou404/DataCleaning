rm(list =ls())
setwd("/home/cnemri/Documents/JHU Data Science/Getting and Cleaning Data")
fileUrl = 'https://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?accessType=DOWNLOAD'
if (!file.exists('./data')) {dir.create('./data')}
download.file(fileUrl, destfile='./data/restaurants.csv', method='curl')
restData = read.csv('./data/restaurants.csv')

# 1 - Creating sequences
s1 <- seq(1,10, by=2);s1
s2 <- seq(1,10, length=3);s2
x <- c(1,3,8,25, 100); seq(along=x)

# 2 - Subsetting variables
restData$nearMe = restData$neighborhood %in% c('Roland Park', 'Homeland')
table(restData$nearMe)

# 3 - Creating binary variables
restData$zipWrong = ifelse(restData$zipCode < 0, TRUE, FALSE)
table(restData$zipWrong, restData$zipCode < 0)

# 4 - Creating categorical variables
restData$zipGroups = cut(restData$zipCode, breaks=quantile(restData$zipCode))
table(restData$zipGroups)

table(restData$zipGroups, restData$zipCode)

# 5 - Easier cutting
packages = installed.packages()
if (!('Hmisc' %in% packages[, 'Package'])) {install.packages('Hmisc')}
library(Hmisc)
restData$zipGroups = cut2(restData$zipCode, g=4)
table(restData$zipGroups)

# 6 - Creating factor variables

restData$zcf <- factor(restData$zipCode)
restData$zcf[1:10]

# 7 - Levels of factor variables

yesno = sample(c('yes', 'no'),size=10,replace=TRUE)
yesnofac = factor(yesno, levels=c('yes','no'))
relevel(yesnofac, ref='no')

as.numeric(yesnofac)

# 8 - Using mutate function
library(plyr)
restData2 = mutate(restData, zipGroups=cut2(zipCode,g=4))
table(restData2$zipGroups)