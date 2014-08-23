GettingAndCleaningData
======================

Coursera GettingAndCleanignData Project

In order to execute the script, make sure that you create under your working directory a folder called 'Data Science' that will contain the UCI HAR Dataset.

Description of the Script:

The goal is to prepare tidy data that can be used for later analysis
The script does the following:
1) Reads the training and test set using the read.table function
2) Modify the variable names to descriptive variable names
3) Bind both training and test set with the subject_train and and subject_test accordingly based on row number by using the Cbind function
4) Flag the records with MEAN, STD or NONE values depending if the feature name contains mean or std text string, performed this operation using the Pattern Matching and Replacement grepl function
5) Melt the Resulting Data set by ID (dimension) = subjectID,ActivityID and measures = value of X_train and X_test
6) Merges the data with the activity_labels and features file to get descriptive variable names.
7) return the data set for the values with FLAG different than NONE (Point 4)

