
# Source of data for this project: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

# Description of Project
#  You should create one R script called run_analysis.R that does the following.
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


# This R script does the following:

# 1. Merges the training and the test sets to create one data set.

temp1 <- read.table("train/X_train.txt")
temp2 <- read.table("test/X_test.txt")
X_bind <- rbind(temp1, temp2)

temp1 <- read.table("train/subject_train.txt")
temp2 <- read.table("test/subject_test.txt")
S_bind <- rbind(temp1, temp2)

temp1 <- read.table("train/y_train.txt")
temp2 <- read.table("test/y_test.txt")
Y_bind <- rbind(temp1, temp2)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.

features <- read.table("features.txt")
indices_of_good_features <- grep("-mean\\(\\)|-std\\(\\)", features[, 2])
X_bind <- X_bind[, indices_of_good_features]
names(X_bind) <- features[indices_of_good_features, 2]
names(X_bind) <- gsub("\\(|\\)", "", names(X_bind))
names(X_bind) <- tolower(names(X_bind))

# 3. Uses descriptive activity names to name the activities in the data set.

activities <- read.table("activity_labels.txt")
activities[, 2] = gsub("_", "", tolower(as.character(activities[, 2])))
Y_bind[,1] = activities[Y_bind[,1], 2]
names(Y_bind) <- "activity"

# 4. Appropriately labels the data set with descriptive activity names.

names(S_bind) <- "subject"
cleaned_data <- cbind(S_bind, Y_bind, X_bind)
write.table(cleaned_data, "merged_clean_data.txt", row.names = FALSE)

# 5. Creates a 2nd, independent tidy data set with the average of each variable for each activity and each subject.

unique_Subjects = unique(S_bind)[,1]
num_Subjects = length(unique(S_bind)[,1])
num_Activities = length(activities[,1])
numCols = dim(cleaned_data)[2]
result = cleaned[1:(num_Subjects*num_Activities), ]

row = 1
for (s in 1:num_Subjects) {
  for (a in 1:num_Activities) {
    result[row, 1] = unique_Subjects[s]
    result[row, 2] = activities[a, 2]
    tmp <- cleaned_data[cleaned_data$subject==s & cleaned_data$activity==activities[a, 2], ]
    result[row, 3:numCols] <- colMeans(tmp[, 3:numCols])
    row = row+1
  }
}
write.table(result, "tidy_data_set_with_averages.txt", row.names = FALSE)
