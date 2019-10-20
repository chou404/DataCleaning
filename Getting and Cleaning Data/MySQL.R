setwd("/home/cnemri/Documents/JHU Data Science/Getting and Cleaning Data")

# Loading R MySQL library
require('RMySQL')

# Accessing UCSC genome database
ucscDb <- dbConnect(MySQL(), user = 'genome', host = 'genome-mysql.cse.ucsc.edu')
# "show databases;" is a MySQL query ! Be careful to disconnect from database
result <- dbGetQuery(ucscDb, "show databases;"); dbDisconnect(ucscDb)

# result has the list of all the databases of ucsc
str(result)

# Now let's study one DB in particular
hg19 <- dbConnect(MySQL(), user="genome", db="hg19", host="genome-mysql.cse.ucsc.edu")
# Let's get the name of all tables in this DB
allTables <- dbListTables(hg19); dbDisconnect(ucscDb)
length(allTables)

allTables[1:5]
dbListFields(hg19,"affyU133Plus2")

# select count(*) is a MySQL command to get the number of rows
dbGetQuery(hg19, "select count(*) from affyU133Plus2")
affyData <- dbReadTable(hg19,"affyU133Plus2")
head(affyData)

query <- dbSendQuery(hg19, "select * from affyU133Plus2 where misMatches between 1 and 3")
affyMis <- fetch(query); quantile(affyMis$misMatches)
affyMisSmall <- fetch(query, n=10); dbClearResult(query)
dim(affyMisSmall)
dbDisconnect(hg19)