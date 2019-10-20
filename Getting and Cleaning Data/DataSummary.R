setwd("/home/cnemri/Documents/JHU Data Science/Getting and Cleaning Data")
if (!file.exists("./data")) {dir.create("./data")}
fileUrl <- "https://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl, destfile="./data/restaurants.csv", method = "curl")
restData <- read.csv("./data/restaurants.csv")
head(restData, n=3)
tail(restData, n=3)
summary(restData)
str(restData)

# Qualtiles of quantitative variables
quantile(restData$councilDistrict, na.rm = T)
# Specifiying the probabilities
quantile(restData$councilDistrict, probs = c(0.5, 0.75, 0.9))

# Make table 1 variable
table(restData$zipCode, useNA = 'ifany')

# Make table 2 variables
table(restData$councilDistrict, restData$zipCode)

# Check for missing values
sum(is.na(restData$councilDistrict))

# boolean
any(is.na(restData$councilDistrict))

# Check for wrong values
all(restData$zipCode > 0)

# Row & column sums
colSums(is.na(restData))

all(colSums(is.na(restData))==0)

# Values with specific characteristics
table(restData$zipCode %in% c('21212'))

table(restData$zipCode %in% c('21212', '21213'))

# Value with specific characteristics
restData_sub <- restData[restData$zipCode %in% c('21212', '21213'), ]
restData_sub

# Cross tabs
data("UCBAdmissions")
DF = as.data.frame(UCBAdmissions)
summary(DF)

xt <- xtabs(Freq ~ Gender + Admit, data=DF)

# Flat table
# a - on UCBAdmissions data set
ftable(UCBAdmissions)

# b - on warpbreaks data set
warpbreaks$replicate <- rep(1:9, len = 54)
xt = xtabs(breaks ~.,data=warpbreaks)
xt

ftable(xt)

# Size of a data set
fakeData = rnorm(1e5)
object.size(x = fakeData)

# for a better formatting
print(object.size(fakeData), units='Mb')