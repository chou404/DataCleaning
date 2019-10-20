rm(list = ls())
setwd("/home/cnemri/Documents/JHU Data Science/Getting and Cleaning Data")

# Week 4 - Quizz
fileUrl = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"

download.file(fileUrl, './data/communities.csv', method = 'curl')
communities = read.csv('./data/communities.csv')
x = strsplit(x = names(communities), split = 'wgtp')
x[123]

# Question 2

fileUrl = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(fileUrl, './data/GDP.csv')
GDPData = read.csv('./data/GDP.csv', header = F, skip = 5)
GDPData = GDPData[, c(1,2,4,5)]
names(GDPData) <- c('CountryCode', 'Rank', 'LongName', 'GDP')
GDPData$Rank = as.numeric(factor(GDPData$Rank, levels = 1:205))
GDPData = GDPData[!is.na(GDPData$Rank), ]
tail(GDPData)

GDPData$GDP = as.numeric(gsub(',','',GDPData$GDP))
mean(GDPData$GDP)

# Question 4
fileUrl2 = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(fileUrl2, './data/ed.csv', method ='curl')
edData = read.csv('./data/ed.csv')

merged_data = arrange(join(GDPData,edData),Rank)
Fiscal_logicals = grepl('( )[Ee]nd(.*)( )[Jj]une', merged_data$Special.Notes)
table(Fiscal_logicals)

# Question 5

library(quantmod)
library(lubridate)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)
dates_logicals <- (year(sampleTimes) == 2012)
dates_logicals2 <- (year(sampleTimes) == 2012 & wday(sampleTimes) == 2)
table(dates_logicals)
table(dates_logicals2)