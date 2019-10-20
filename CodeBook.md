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

## Data Cleaning Steps

In this part, we explain the different transformation that the data has undergone during the cleaning process.

1 - We started by downloading the zipfile under './data/' directory.
2 - We unzipped the compressed folder.
3 - We used fread for optimal memory usage and the following variables
