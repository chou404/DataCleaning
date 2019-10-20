# Quizz 1 - Getting and cleaning data
fileUrl <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv'
download.file(url = fileUrl, destfile = './data/communities.csv', method = 'curl')

communities <- read.csv('data/communities.csv', header = T)

communities$VAL

val <- communities$VAL[!is.na(communities$VAL)]
sum(val == 24)

fileUrl <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx'
download.file(fileUrl, destfile = './data/NatGasAc.xlsx', method = 'curl')

require(xlsx)
dat <- read.xlsx(file = './data/NatGasAc.xlsx', sheetIndex = 1, rowIndex = 18:23, colIndex = 7:15)

sum(dat$Zip*dat$Ext, na.rm=T)

fileUrl <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml'
download.file(fileUrl, './data/Baltrest.xml', method = 'curl')
require('XML')
doc <- xmlInternalTreeParse('./data/Baltrest.xml')
rootNode <- xmlRoot(doc)
zipcodes <- as.numeric(xpathSApply(rootNode, '//zipcode', xmlValue))

sum(zipcodes == 21231)

fileUrl <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv'
download.file(fileUrl, destfile = './data/communities2.csv', method = 'curl')

require(data.table)
DT <- fread(file = './data/communities2.csv')