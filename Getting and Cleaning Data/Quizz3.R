rm(list = ls())
setwd("/home/cnemri/Documents/JHU Data Science/Getting and Cleaning Data")

# Week 3 - Quizz

fileUrl = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"

download.file(fileUrl, './data/communities.csv', method = 'curl')
communities = read.csv('./data/communities.csv')

library(dplyr)

agricultureLogical = (communities$ACR == 3) & (communities$AGS == 6)

w <- which(agricultureLogical)
w[1:3]

# Question 2
packages = installed.packages()
if(!'jpeg' %in% packages[, 'Package']){install.packages('jpeg')}
library(jpeg)

imgUrl = "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
download.file(imgUrl, './data/FJeff.jpg', method = 'curl')
imgData = readJPEG('./data/FJeff.jpg', native = T)

quantile(imgData, probs= c(0.3,0.8))

# Question 3
fileUrl = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(fileUrl, './data/GDP.csv')
GDPData = read.csv('./data/GDP.csv', header = F, skip = 5)
GDPData = GDPData[, c(1,2,4,5)]
names(GDPData) <- c('CountryCode', 'Rank', 'LongName', 'GDP')
GDPData$Rank = as.numeric(factor(GDPData$Rank, levels = 1:205))
GDPData = GDPData[!is.na(GDPData$Rank), ]
tail(GDPData)

fileUrl2 = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(fileUrl2, './data/ed.csv', method ='curl')
edData = read.csv('./data/ed.csv')

merged_data = arrange(join(GDPData,edData),sort(Rank,decreasing = T))
merged_data = merged_data[!is.na(merged_data$Rank), ]
merged_data$GDP = as.numeric(merged_data$GDP)
tail(merged_data$Rank)

ddply(merged_data,.(Income.Group),summarize,mean=mean(Rank))

library(Hmisc)
merged_data$RankGroups = cut2(merged_data$Rank,g=5)

table(merged_data$RankGroups, merged_data$Income.Group)

