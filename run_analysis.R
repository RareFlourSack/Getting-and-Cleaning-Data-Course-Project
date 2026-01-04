## set variables for downloading and unzipping datasets

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
dest_file <- "./dataset.zip"

## download and unzip datasets

download.file(url, destfile = dest_file, mode = "wb") 
unzip(dest_file, exdir = "./Getting-and-Cleaning-Data-Course-Project")

## read train datasets

x_train <- read.table("./Getting-and-Cleaning-Data-Course-Project/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./Getting-and-Cleaning-Data-Course-Project/UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./Getting-and-Cleaning-Data-Course-Project/UCI HAR Dataset/train/subject_train.txt")

## read test datasets

x_test <- read.table("./Getting-and-Cleaning-Data-Course-Project/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./Getting-and-Cleaning-Data-Course-Project/UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./Getting-and-Cleaning-Data-Course-Project/UCI HAR Dataset/test/subject_test.txt")

## read features dataset

features <- read.table("./Getting-and-Cleaning-Data-Course-Project/UCI HAR Dataset/features.txt")

## read activity labels and set column names

activity_labels <- read.table("./Getting-and-Cleaning-Data-Course-Project/UCI HAR Dataset/activity_labels.txt")
colnames(activity_labels) <- c("activityNum", "activityType")

## add column names for training datasets

colnames(x_train) <- features[, 2]
colnames(y_train) <- "activityNum"
colnames(subject_train) <- "subjectNum"

## add column names for testing datasets

colnames(x_test) <- features[, 2]
colnames(y_test) <- "activityNum"
colnames(subject_test) <- "subjectNum"

## combine datasets

collated_tr <- cbind(y_train, subject_train, x_train)
collated_te <- cbind(y_test, subject_test, x_test)
final_data <- rbind(collated_tr, collated_te)

## filter for mean and standard deviation data

get_mean_and_sd <- grepl("activityNum|subjectNum|mean\\(\\)|std\\(\\)", colnames(final_data), ignore.case = TRUE)
set_mean_and_sd <- final_data[, get_mean_and_sd]

## add activity labels

set_activity_names <- merge(set_mean_and_sd, activity_labels, by = "activityNum", all.x = TRUE)

colnames(set_activity_names) <- gsub("^t", "Time", colnames(set_activity_names))
colnames(set_activity_names) <- gsub("^f", "Frequency", colnames(set_activity_names))
colnames(set_activity_names) <- gsub("Acc", "Accelerometer", colnames(set_activity_names))
colnames(set_activity_names) <- gsub("Gyro", "Gyroscope", colnames(set_activity_names))
colnames(set_activity_names) <- gsub("Mag", "Magnitude", colnames(set_activity_names))

## load dplyr package for summarizing data

library(dplyr)

## create final tidy set

tidied_set <- summarise_all(group_by(set_activity_names, subjectNum, activityNum, activityType), mean)

## save as .txt

write.table(tidied_set, file = "tidied_set.txt", row.names = FALSE)