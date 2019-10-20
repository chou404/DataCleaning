# QUizz for week 2

setwd("/home/cnemri/Documents/JHU Data Science/Getting and Cleaning Data")

# Question 1

library(httr)
library(RJSONIO)
# 1. find OAuth settings for github
# http://developer.github.com/v3/oauth/
oauth_endpoint("github", authorize = NULL, access = NULL)

# 2. To make your own application, register at
#     https://github.com/settings/developpers. Use any URL for homepage URL
#     (http://github.com is fine) and http://localhost:1410 ass callback url

myapp <- oauth_app('github',
                   key = 'acc0ec02d575bd254698', 
                   secret = '9d1100428b5f822893ec792761147b183f5c78d4')

# 3. Get OAuth credentials
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

# 4. Use API
gtoken <- config(token = github_token)
req <- GET("https://api.github.com/users/jtleek/repos", gtoken)
stop_for_status(req)
data <- content(req)

# OR
req <- with_config(gtoken, GET('ttps://api.github.com/users/jtleek/repos'))
stop_for_status(req)
data <- content(req)

# Exploiting the data
data <- jsonlite::fromJSON(toJSON(data))
data2 <- data[data['name']=='datasharing', ]
data2[, 'created_at']

############# Question 2
install.packages('sqldf')
library(sqldf)
url <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv'
download.file(url, './data/acs.csv', method = 'curl')
acs <- read.csv('./data/acs.csv')
str(acs)

sqldf('select pwgtp1 from acs where AGEP < 50')

#########" Question 3
sqldf('select distinct AGEP from acs')

########## Question 4
library(httr)

url <- 'http://biostat.jhsph.edu/~jleek/contact.html'
html <- GET(url)
content <- content(html, as='text')
parsedHtml <- htmlParse(content, asText=TRUE)
topNode <- xmlRoot(parsedHtml, '//body')

t <- xmlSApply(topNode, function(x)xmlSApply(x, xmlValue))

DF = data.frame(t(t))

######### Question 5
library(utils)
url <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for'
download.file(url, './data/set.for', method = 'curl')
DF5 <- read.fwf(file = './data/set.for', widths = c(10,rep(c(9,4),4)), skip = 4)

