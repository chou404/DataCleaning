setwd("/home/cnemri/Documents/JHU Data Science/Getting and Cleaning Data")

con = url('https://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en')
htmlCode = readLines(con)
close(con)
# be careful huge print (may slow pc)
htmlCode[1]

library(XML)
library(RCurl)

url <- 'https://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en'
curl_data <- getURL(url)
html <- htmlTreeParse(curl_data, useInternalNodes = T)

# Show title
xpathSApply(html, "//title", xmlValue)

# Show citations
xpathSApply(html, "//a[@class='gsc_a_ac gs_ibl']", xmlValue)

library(httr); html2 = GET(url)
content2 = content(html2, as='text')
parsedHtml = htmlParse(content2, asText=TRUE)
xpathSApply(parsedHtml,"//title",xmlValue)

# Accessing Websites with password
pg1 = GET('http://httpbin.org/basic-auth/user/passwd')
pg1

pg2 = GET('http://httpbin.org/basic-auth/user/passwd',
          authenticate("user","passwd"))
pg2

# Usinr handles
google = handle('http://google.com')
pg1 = GET(handle=google,path='/')
pg2 = GET(handle=google,path='search')