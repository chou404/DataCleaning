# Getting and Cleaning Data Course Project

# The script processes Activity Recognition Using Smartphones Dataset
# It has two outputs
# data table X : Dataset as per Step 4 of the Instructions
# data table X_tidy : Tidy Data set as requested in Step 5 of the instructions

if(!file.exists('./data')) {dir.create('./data')}

# Downloading the dataset
if (!file.exists('./data/Dataset.zip')) {
  fileUrl = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileUrl, './data/Dataset.zip', method = 'curl')
  unzip('./data/Dataset.zip', exdir = './data')
  }

# Load the feature names
Features <- fread('./data/UCI HAR Dataset/features.txt', header = F, sep2 = '\t')
Features <- Features[,V2]

# Load Train set
Y_train <- fread("./data/UCI HAR Dataset/train/y_train.txt", header = F)
id <- fread('./data/UCI HAR Dataset/train/subject_train.txt', header = F)
X_train <- fread('./data/UCI HAR Dataset/train/X_train.txt', header = F, sep2 = '\t')
X_train$Activity <- Y_train
X_train$id <- id
names(X_train) <- c(Features, "Activity", 'id')
X_train <- X_train[, c(563, 1:562)]

# Load Test set
Y_test <- fread('./data/UCI HAR Dataset/test/y_test.txt', header = F)
id <- fread('./data/UCI HAR Dataset/test/subject_test.txt', header = F)
X_test <- fread('./data/UCI HAR Dataset/test/X_test.txt', header = F, sep2 = '\t')
X_test$Activity <- Y_test
X_test$id <- id
names(X_test) <- c(Features, 'Activity', 'id')
X_test <- X_test[, c(563, 1:562)]

# Merging train and test datasets
X <- rbind(X_train, X_test)

# Keeping std and means features only
Features_logicals <- grepl('(.*)mean(.*)|(.*)std(.*)', Features)
Features_std_mean <- Features[Features_logicals]
X <- X[, c('id',Features_std_mean,'Activity'), with=FALSE]

# Replacing activity flags with descriptive activity labels
Activity_labels <- fread('./data/UCI HAR Dataset/activity_labels.txt', sep2 = '\t')
library(dplyr)
X <- mutate(X, Activity = Activity_labels$V2[Activity])

# Tidy dataset
library(reshape2)
Xmelt <- melt(X, id.vars = c('id', 'Activity'), measure.vars = Features_std_mean)
X_tidy <- dcast(Xmelt, variable ~ Activity, mean)

# Removing unnecessary variables from workspace
rm('X_train','X_test','Features','Features_logicals', 'Activity_labels', 'Y_train','Y_test','id','fileUrl','Features_std_mean','Xmelt')