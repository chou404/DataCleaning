# Creating a data.frame from xml file
setwd('/home/cnemri/Documents/JHU Data Science/Getting and Cleaning Data/')

library(XML)
library(httr) # Library built around http verbs (GET(), POST(), DELETE() ...)

# We use xmlTreeParse in order to read xml file.
# We set userInternal to TRUE in order to be able
# to use getNodeSet and xpathSApply later.
# the latter functions can be used on XMLInternalDOcument class only

fileUrl <- 'https://www.w3schools.com/xml/simple.xml'

download.file(fileUrl, destfile = './data/simple.xml', method = 'curl')
downloadDate <- date()

# from local file
doc <- xmlTreeParse('./data/simple.xml', useInternalNodes = T)

# from internet
doc2 <- xmlTreeParse(GET(fileUrl), useInternalNodes = T)
class(doc)

# The goal of xmlRoot is to obtain access to the top node.
# The top node is the node that contains all the other nodes
# in the file if you look at the file in page 1.

topNode <- xmlRoot(doc)
class(topNode)
xmlName(topNode)

# now we use the function getnodeset to obtain all the nodes
# with tag food, including all nodes between them.

els <- getNodeSet(topNode, "//food") #Check Xpath language
class(els)

# Looking at R object els, we can see the structure of information
# we want to access. All the nodes that are tagged as food are 
# arranged next to each other with no other nodes separating them

els

## Using the t() and data.frame() functions in R

# We can use the function xmlSApply and xmlValue to obtain all the values
# of the nodes in between the tags food

matrix1 <- xmlSApply(els, function(x) xmlSApply(x,xmlValue))

matrix2 <- xmlSApply(els, xmlValue)

data.frame(t(matrix1))