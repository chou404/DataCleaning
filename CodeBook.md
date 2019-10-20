## Raw Data Description

A Group of 30 volunteers performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearinga smartphone (Samsung Galaxy S II) on the waist. 3-axial linear acceleration and 3-axial angular velocity have been captured at a constant rate of 50Hz. A vector of 561 different features in the time and frequency domains has then been obtained. The dataset has been randomly partitioned (70% training data - 30% test data)

The dataset includes the following files:

- 'README.txt'

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

Full description of the Dataset can be found on the following link:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## Data Cleaning Steps

In this part, we explain the different transformation that the data has undergone during the cleaning process.

1. We started by downloading the zipfile under './data/' directory.
2. We unzipped the compressed folder.
3. We used fread for optimal memory usage
4. The following variables have been loaded as data.table :
  - **Features** names from *features.txt*
  - **Training** and **test activity labels** respectively from */train/Y_train.txt* and */test/Y_test.txt*
  - **Training** and **testing features matrices** respectively from */train/X_train.txt* and */test/X_test.txt*
  - The **subject ids** from */train/subject_train.txt* and */test/subject_test.txt*

5. Only the second column of **Features** is kept because it contains the features names.
6. Only the second column of **id** is kept because it contains the ids
7. Only the second column of **Activity_labels** is kept because it contains the descriptive labels that we are going to use later.
8. We add the training and the testing **id** and **Activity** columns respectively on the right and on the left of X_train and X_test.
9. Then we use Features vector to set the names of the resulting X_train and X_test.
10. X_train and X_test are binded by rows into **X** using `rbind(X_train,X_test)`.
11. In order to keep the features containing std and means only, we define the following regular expression : `(.*)mean(.*)|(.*)std(.*)` :
  - `Features_logicals <- grepl('(.*)mean(.*)|(.*)std(.*)', Features)`
  - `Features_std_mean <- Features[Features_logicals]`
12. Then the corresponding columns are selected as follows : `X <- X[, c('id',Features_std_mean,'Activity'), with=FALSE]`. It is important to set with to **FALSE**, otherwise it won't work as same as for data.frames.
13. The integers in the activity labels are then replaced using the Activity_labels vector and the following *plyr* function : `X <- mutate(X, Activity = Activity_labels$V2[Activity])`

14. In order to have the tidy dataset as requested in the assignment's step 5, we need first to melt the dataset using **id** and **Activity** as id.vars and the rest of the features as measure.vars.
15. dcast function allows obtaining the tidy dataset as follows : `X_tidy <- dcast(Xmelt, variable ~ Activity, mean)`
