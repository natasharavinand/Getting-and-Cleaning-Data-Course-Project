library(dplyr)

filename <- "getdata_projectfiles_UCI HAR Dataset.zip"
zipped_filename <- "UCI HAR Dataset"
if (!file.exists(filename)) {
  url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(url, filename, method="curl")
}

if(!file.exists(zipped_filename)) {
  unzip(filename)
}

activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("class_labels", "activity"))
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n", "features"))
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = c("subject"))
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$features)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = c("class_labels"))
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = c("subject"))
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$features)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = c("class_labels"))

x <- rbind(x_test, x_train)
y <- rbind(y_test, y_train)
subject <- rbind(subject_test, subject_train)
mdf <- cbind(subject, x, y)

tidy_df <- mdf %>% select(subject, class_labels, contains("mean"), contains("sd"))

tidy_df$class_labels <- activities[tidy_df$class_labels, 2]

tidy_df <- rename(tidy_df, activity = class_labels)
colnames(tidy_df) <- gsub("Gyro", "Gyroscope", colnames(tidy_df))
colnames(tidy_df) <- gsub("Acc", "Accelerometer", colnames(tidy_df))
colnames(tidy_df) <- gsub("tBody", "TimeBody", colnames(tidy_df))
colnames(tidy_df) <- gsub("BodyBody", "Body", colnames(tidy_df))
colnames(tidy_df) <- gsub("Mag", "Magnitude", colnames(tidy_df))
colnames(tidy_df) <- gsub("angle", "Angle", colnames(tidy_df))
colnames(tidy_df) <- gsub("Freq", "Frequency", colnames(tidy_df))
colnames(tidy_df) <- gsub("gravity", "Gravity", colnames(tidy_df))
colnames(tidy_df) <- gsub("^t", "Time", colnames(tidy_df))
colnames(tidy_df) <- gsub("^f", "Frequency", colnames(tidy_df))
colnames(tidy_df)<-gsub("\\.", "", colnames(tidy_df))
colnames(tidy_df)<-gsub("std", "STD", colnames(tidy_df))
colnames(tidy_df)<-gsub("mean", "Mean", colnames(tidy_df))

final_data <- tidy_df %>% 
  group_by(subject, activity) %>% 
  summarize_all(mean)

write.table(final_data, file = "./final_data.txt", row.names = F)
