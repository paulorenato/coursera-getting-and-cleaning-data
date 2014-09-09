# GETTING AND CLEANING DATA PROJECT SCRIPT: run_analysis.R
# Merges the training and the test sets to create one data set.
# Extracts only the measurements on the mean and standard deviation for each measurement. 
# Uses descriptive activity names to name the activities in the data set
# Appropriately labels the data set with descriptive variable names. 
# Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

library(dplyr)
# Assumes the 'UCI HAR Dataset' folder is in the current working directory. Change working directory accordingly if not

###### AUXILIARY FUNCTION ############### 
get_set <- function(set, activity_labels) { 
# Reads either the test or training set and returns a data frame
# with the observations. 
# Parameters:
# set: string, either "train" ot "test"
# activity_labels: data frame extracted from activity_labels.txt

# 1.  Import  X_.txt with read.table into local 'df' data frame
path = paste('./UCI HAR Dataset/', set, '/X_', set, '.txt',sep = "")
df = read.table(path)
# 2.	Import the activity labels y_.txt file into a vector. Import the labeling key into another df.
path = paste('./UCI HAR Dataset/', set, '/y_', set, '.txt',sep = "")
ylabels = read.table(path)
# 3.	Replace each number with its associated activity string according to the activity_labels.txt.
activity_col = sapply(ylabels[,1], function(x) activity_labels[x,2])
# 4.	Import the subject_.txt file and column bind to the dataframe
path = paste('./UCI HAR Dataset/', set, '/subject_', set, '.txt',sep = "")
subject = read.table(path)
df = cbind(df,subject[1])
names(df)[ncol(df)] <- "Subject"
# 5.  Column bind to create an 'Activity' column 
df = cbind(df,activity_col)
names(df)[ncol(df)] <- "Activity"
return(df)
}

###### DATA PROCESSING ############### 
activity_labels = read.table('./UCI HAR Dataset/activity_labels.txt', as.is = TRUE)

# 1. 	Training Set Import 
df_train = get_set("train", activity_labels)

# 2. 	Test Set Import
df_test = get_set("test", activity_labels)

# 3.	Merge the test set and training sets. 
# First, add a column to each so we can still separate data that came from 'training' versus 'test' if we want to
df_train = cbind(df_train, rep("TRAIN", nrow(df_train)))
names(df_train)[ncol(df_train)] <- "TRAIN/TEST"
df_test = cbind(df_test, rep("TEST", nrow(df_test)))
names(df_test)[ncol(df_test)] <- "TRAIN/TEST"
# Now merge them under 'df_combined'. Remove old dataframes to free memory.
df_combined = rbind(df_train,df_test)
rm(df_test,df_train)

# 4.	Use the features.txt to name the column variables in the dataframe. Use sapply (may need to pad)
features = read.table('./UCI HAR Dataset/features.txt', as.is = TRUE)
# Copy names from features (2nd column) to the first 561 names of df_combined
names(df_combined)[1:(ncol(df_combined)-3)] <- features[,2]

# 5.	Select only the columns with mean and std 
# Using dplyr so it's better to use tbl_df converison and delete older data frame
tbl_df(df_combined) -> tidy
# Problem is ambiguous as to whether "mean" can be any part of the variable name. Arrange by subject and calculate average for each variable
# Used only the ones with 'std()' and 'mean()' so it returns the same number of elements for each (33). 
# Use alternate select statement below if user wants *any* variable with 'mean' or 'std' in the name:
# select(contains("std"), contains("mean")) %>%
tidy <- tidy %>%
	select(matches("std\\(\\)"), matches("mean\\(\\)"), Activity, Subject) %>%
    group_by(Subject,Activity) %>%
	summarise_each(funs(mean))

# 6.	Write into a tidy.txt file. Using write.table() defaults. User can read file with: read.table("tidy.txt", header = TRUE)
write.table(tidy, "tidy.txt")

