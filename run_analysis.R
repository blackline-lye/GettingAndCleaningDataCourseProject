# "Getting and Cleaning Data" Course Project
#
# This script downloads raw data from source, combines and cleans up the "test"
# and "training" data sets, and outputs a table with averages of measured 
# variables grouped by subject and activity.

# This script uses the data table package
library(data.table)

# If not already done, download the raw data and unzip it
if(!dir.exists("UCI HAR Dataset")) {
    download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", 
                  "data.zip", method="curl")
    unzip("data.zip")
}

# Read feature and activity lists
features <- fread(".\\UCI HAR Dataset\\features.txt")[[2]]
activities <- fread(".\\UCI HAR Dataset\\activity_labels.txt")[[2]]

# Read "test" data set
test_subject <- fread(".\\UCI HAR Dataset\\test\\subject_test.txt")
test_data <- fread(".\\UCI HAR Dataset\\test\\X_test.txt")
test_activity <- fread(".\\UCI HAR Dataset\\test\\y_test.txt")

# Read "training" data set 
train_subject <- fread(".\\UCI HAR Dataset\\train\\subject_train.txt")
train_data <- fread(".\\UCI HAR Dataset\\train\\X_train.txt")
train_activity <- fread(".\\UCI HAR Dataset\\train\\y_train.txt")

# Combine "test" and "training" subject field
subject <- rbind(test_subject, train_subject)
names(subject) <- "subject"

# Combine "test" and "training" data fields
data <- rbind(test_data, train_data)

# Provide variable names for the data fields
names(data) <- features

# Filter for variables that are either mean or standard deviation
data <- data[,grepl("mean\\(\\)|std\\(\\)", names(data)), with=FALSE]

# Combine "test" and "training" activity field
activity <- rbind(test_activity, train_activity)
names(activity) <- "activity"

# Convert activity into a factor with literal activity names
activity$activity <- factor(activity$activity, labels=activities)

# Now combine subject, activity and the data set
tidy_data = cbind(subject, activity, data)

# Get mean all measured variables grouped by subject and activity
tidy_data_mean <- tidy_data[,lapply(.SD, mean),by=.(subject, activity)]

# Sort by subject and activity to make it look nice
tidy_data_mean <- tidy_data_mean[order(subject, activity)]

# Add "mean of" to all measured variable names
names(tidy_data_mean)[-(1:2)] <- paste("mean of", names(tidy_data_mean)[-(1:2)])

# Output the result
write.table(tidy_data_mean, "tidy_data_mean.txt", row.names = FALSE)