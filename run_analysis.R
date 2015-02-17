#Sets up Workspace
setwd("~/Downloads/UCI HAR Dataset")

library("dplyr")

activity_labels <- read.table("~/Downloads/UCI HAR Dataset/activity_labels.txt", quote="", stringsAsFactors = FALSE) %>%
  tbl_df
features <- read.table("~/Downloads/UCI HAR Dataset/features.txt", quote="", stringsAsFactors = FALSE) %>%
  tbl_df

subject_test <- read.table("~/Downloads/UCI HAR Dataset/test/subject_test.txt", quote="") %>%
  tbl_df
subject_train <- read.table("~/Downloads/UCI HAR Dataset/train/subject_train.txt", quote="") %>%
  tbl_df

y_test <- read.table("~/Downloads/UCI HAR Dataset/test/y_test.txt", quote="") %>%
  tbl_df
y_train <- read.table("~/Downloads/UCI HAR Dataset/train/y_train.txt", quote="") %>%
  tbl_df

X_test <- read.table("~/Downloads/UCI HAR Dataset/test/X_test.txt", quote="") %>%
  tbl_df
X_train <- read.table("~/Downloads/UCI HAR Dataset/train/X_train.txt", quote="") %>%
  tbl_df


#Extracts only the measurements on the mean and standard deviation for each measurement.
X <- bind_rows(X_test, X_train)

features$V2 <- make.names(features$V2, unique = TRUE)
for (i in 1:561) {
  names(X)[i] <- features[i, 2]
}

X2 <- select(X, contains("mean", ignore.case = FALSE), contains("std"), -contains("Freq"))


#Merges the training and the test sets to create one data set.
subject <- bind_rows(subject_test, subject_train)
y <- bind_rows(y_test, y_train)

subjectyX <- bind_cols(list(subject, y, X2))


#Appropriately labels the data set with descriptive variable names.
names(subjectyX)[1:2] <- c("Subject", "Activity")

subjectyX <- rename(subjectyX,  fBodyAccJerkMag.mean.. = fBodyBodyAccJerkMag.mean.., fBodyGyroMag.mean.. = fBodyBodyGyroMag.mean.., fBodyGyroJerkMag.mean.. = fBodyBodyGyroJerkMag.mean.., fBodyAccJerkMag.std.. = fBodyBodyAccJerkMag.std.., fBodyGyroMag.std.. = fBodyBodyGyroMag.std.., fBodyGyroJerkMag.std.. = fBodyBodyGyroJerkMag.std..)


#Uses descriptive activity names to name the activities in the data set
for (i in 1:10299) {
  a <- subjectyX[i, 2]
  if (a == 1) {
    subjectyX[i, 2] <- activity_labels[1, 2]
  }
  else if (a == 2) {
    subjectyX[i, 2] <- activity_labels[2, 2]
  }
  else if (a == 3) {
    subjectyX[i, 2] <- activity_labels[3, 2]
  }
  else if (a == 4) {
    subjectyX[i, 2] <- activity_labels[4, 2]
  }
  else if (a == 5) {
    subjectyX[i, 2] <- activity_labels[5, 2]
  }
  else if (a == 6) {
    subjectyX[i, 2] <- activity_labels[6, 2]
  }
}
subjectyX$Activity <- factor(subjectyX$Activity)


#From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
subjectyX2 <- arrange(subjectyX, Subject, Activity) %>%
  group_by(Subject, Activity) %>%
  summarize(mean(tBodyAcc.mean...X), mean(tBodyAcc.mean...Y), mean(tBodyAcc.mean...Z), mean(tBodyAcc.std...X), mean(tBodyAcc.std...Y), mean(tBodyAcc.std...Z), mean(tGravityAcc.mean...X), mean(tGravityAcc.mean...Y), mean(tGravityAcc.mean...Z), mean(tGravityAcc.std...X), mean(tGravityAcc.std...Y), mean(tGravityAcc.std...Z), mean(tBodyAccJerk.mean...X), mean(tBodyAccJerk.mean...Y), mean(tBodyAccJerk.mean...Z), mean(tBodyAccJerk.std...X), mean(tBodyAccJerk.std...Y), mean(tBodyAccJerk.std...Z), mean(tBodyGyro.mean...X), mean(tBodyGyro.mean...Y), mean(tBodyGyro.mean...Z), mean(tBodyGyro.std...X), mean(tBodyGyro.std...Y), mean(tBodyGyro.std...Z), mean(tBodyGyroJerk.mean...X), mean(tBodyGyroJerk.mean...Y), mean(tBodyGyroJerk.mean...Z), mean(tBodyGyroJerk.std...X), mean(tBodyGyroJerk.std...Y), mean(tBodyGyroJerk.std...Z), mean(tBodyAccMag.mean..), mean(tBodyAccMag.std..), mean(tGravityAccMag.mean..), mean(tGravityAccMag.std..), mean(tBodyAccJerkMag.mean..), mean(tBodyAccJerkMag.std..), mean(tBodyGyroMag.mean..), mean(tBodyGyroMag.std..), mean(tBodyGyroJerkMag.mean..), mean(tBodyGyroJerkMag.std..), mean(fBodyAcc.mean...X),  mean(fBodyAcc.mean...Y), mean(fBodyAcc.mean...Z), mean(fBodyAcc.std...X), mean(fBodyAcc.std...Y), mean(fBodyAcc.std...Z), mean(fBodyAccJerk.mean...X), mean(fBodyAccJerk.mean...Y), mean(fBodyAccJerk.mean...Z), mean(fBodyAccJerk.std...X), mean(fBodyAccJerk.std...Y), mean(fBodyAccJerk.std...Z),  mean(fBodyGyro.mean...X), mean(fBodyGyro.mean...Y), mean(fBodyGyro.mean...Z), mean(fBodyGyro.std...X), mean(fBodyGyro.std...Y), mean(fBodyGyro.std...Z), mean(fBodyAccMag.mean..), mean(fBodyAccMag.std..), mean(fBodyAccJerkMag.mean..), mean(fBodyAccJerkMag.std..), mean(fBodyGyroMag.mean..), mean(fBodyGyroMag.std..), mean(fBodyGyroJerkMag.mean..), mean(fBodyGyroJerkMag.std..))


#Exports second, independent tidy data set
write.table(subjectyX2, file = "WideTidy.txt", row.name = FALSE)
