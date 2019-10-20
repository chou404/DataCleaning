# Setting work directory
setwd('/home/cnemri/Documents/JHU Data Science/Getting and Cleaning Data/')

# loading requiered library
library(XML)
library(httr)

fileUrl <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml'
doc <- xmlTreeParse(GET(fileUrl), useInternalNodes = T)

# First approach getting rootNode and then play with Node set
topNode <- xmlRoot(doc)

els <- getNodeSet(topNode, '//row[@*]')

data <- t(xmlSApply(els, function(x) xmlSApply(x,xmlValue)))

DF <- data.frame(data)

# Second approach : using xpathSApply directly

data2 <- t(xpathSApply(doc, '//row[@*]', function(x) xmlSApply(x,xmlValue)))
DF2 <- data.frame(data2)

# Check if the obtained data frame is the same
identical(DF,DF2)

# View(DF)

# Third approach - creating vectors

els_name <- getNodeSet(topNode, '//name')
els_zipcode <- getNodeSet(topNode, '//zipcode')
els_councildistrict <- getNodeSet(topNode, '//councildistrict')
els_policedistrict <- getNodeSet(topNode, '//policedistrict')
els_location_1 <- getNodeSet(topNode, '//location_1')

name <- xmlSApply(els_name, xmlValue)
zipcode <- xmlSApply(els_zipcode, xmlValue)
councildistrict <- xmlSApply(els_councildistrict, xmlValue)
policedistrict <- xmlSApply(els_policedistrict, xmlValue)
location_1 <- xmlSApply(els_location_1, xmlValue)

DF3 <- data.frame(name = name, zipcode = zipcode, council_district = councildistrict, police_district = policedistrict, location_1 = location_1)