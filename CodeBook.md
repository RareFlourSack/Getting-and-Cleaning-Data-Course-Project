# R Script
As per the project instructions, run_analysis.R does the following:
- Downloads and unzips the original dataset
1. Merges the training and the test sets to create one data set.
- Uses read.table() to read the individual files
2. Extracts only the measurements on the mean and standard deviation for each measurement.
- Uses grepl() to filter for columns that include mean and standard deviation values
3. Uses descriptive activity names to name the activities in the data set
- Uses colnames() to set activity_labels.txt as column names
4. Appropriately labels the data set with descriptive variable names.
- Uses colnames() and gsub() to add or change column names
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
- Creates a second dataset using dplyr functions

# Variables
+ **x_train, y_train, subject_train, x_test, y_test, subject_test** are values stored from the original datasets
+ **features, set_activity_names** serve as the column names for the dataset
+ **collated_tr, collated_te, final_data** are the merged datasets for tidying
+ **tidied_set** is the final tidied set
