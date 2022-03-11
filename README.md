# run_analysis
_Week 4 Getting and Cleaning Data Course Project_


The run_analysis.R script does the following:

After creating a directory and downloading and unzipping the data (lines 5-13)

1.Merges the training and the test sets to create one data set.
Read in and process files (lines 19-84)
Merge into one dataset (lines 86-115 including pieces below)

2.Extracts only the measurements on the mean and standard deviation for each measurement. (lines 117-119)
I use the data.table %like% operator to select mean and std columns.

3.Uses descriptive activity names to name the activities in the data set (lines 105-111)
I use left joines to accomplish this as they don't reorder the data in the process.

4.Appropriately labels the data set with descriptive variable names. (lines 89-103)
I use string replacements to make varaible names more human readable.

5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.(lines 120-121)
I use a group by and summarize across everything to minimize code.

I write out final files in lines 123-124

See the updated codebooks, README.txt (lines 31 - 33), features_info.txt (lines 61 - 92)