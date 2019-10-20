if (!file.exists('data')) dir.create('./data')
fileUrl <- 'https://data.baltimorecity.gov/api/views/dz54-2aru/rows.xlsx?accessType=DOWNLOAD'
download.file(fileUrl, destfile = './data/cameras.xlsx', method = 'curl')
dateDownloaded <- date()
 
require(xlsx)
cameraData <- read.xlsx(file = './data/file_example_XLS_50.xls', sheetIndex = 1, header = TRUE)
dateDownloaded <- date()
str(cameraData)