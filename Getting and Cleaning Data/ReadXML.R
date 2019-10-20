library('XML')
filepath <- "./data/simple.xml"
doc <- xmlTreeParse(filepath, useInternalNodes = T, isURL = TRUE)

class(doc)

topNode <- xmlRoot(doc)
class(topNode)
xmlName(topNode)

els <- getNodeSet(topNode, "//food")
class(els)

els
xmlSApply(els, function(x)xmlSApply(x, xmlValue))

class(xmlSApply(els, function(x)xmlSApply(x, xmlValue)))

t(xmlSApply(els, function(x)xmlSApply(x, xmlValue)))

data.frame(t(xmlSApply(els, function(x)xmlSApply(x, xmlValue))))

els_name <- getNodeSet(topNode, "//name")
els_price <- getNodeSet(topNode, "//price")
els_desc <- getNodeSet(topNode, "//description")
els_calorie <- getNodeSet(topNode, "//calories")

food_names <- xmlSApply(els_name, xmlValue)
price <- xmlSApply(els_price, xmlValue)
description <- xmlSApply(els_desc, xmlValue)
calories <- xmlSApply(els_calorie, xmlValue)

data.frame(name = food_names, price = price, description = description, calories = calories)

els <- getNodeSet(topNode, "//food", fun = xmlToList)

els

class(els)

data.frame(do.call(rbind,els))
