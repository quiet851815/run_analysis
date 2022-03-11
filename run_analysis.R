#Getting and Cleaning Data Wk 4 Course Project 

#1.Merges the training and the test sets to create one data set.

#create data directory
if(!file.exists("data")) {
        dir.create("data")
}

#download and unzip data
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, "./data/run_data.zip", method = "curl")
unzip("./data/run_data.zip", exdir = "./data")

library(dplyr)

##root files

#'features.txt': List of all features.
features_text <- read.table("./data/UCI HAR Dataset/features.txt", header = FALSE, sep = "", dec = ".") %>%
        rename (variable_id = V1,
                variable = V2)


#'activity_labels.txt': Links the class labels with their activity name.
activity_labels <- read.table("./data/UCI HAR Dataset/activity_labels.txt", header = FALSE, sep = "", dec = ".") %>%
        rename(activity_label = V1,
              activity_name = V2)

##train files

#'train/X_train.txt': Training set.
x_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt", header = FALSE, sep = "", dec = ".")

#'train/y_train.txt': Training labels.
y_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt", header = FALSE, sep = "", dec = ".") %>%
        rename(activity_label = V1)

#'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.
subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt", header = FALSE, sep = "", dec = ".") %>%
        rename(subject = V1)

#'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 
total_acc_x_train <- read.table("./data/UCI HAR Dataset/train/Inertial Signals/total_acc_x_train.txt", header = FALSE, sep = "", dec = ".")
total_acc_y_train <- read.table("./data/UCI HAR Dataset/train/Inertial Signals/total_acc_y_train.txt", header = FALSE, sep = "", dec = ".")
total_acc_z_train <- read.table("./data/UCI HAR Dataset/train/Inertial Signals/total_acc_z_train.txt", header = FALSE, sep = "", dec = ".")

#'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 
body_acc_x_train <- read.table("./data/UCI HAR Dataset/train/Inertial Signals/body_acc_x_train.txt", header = FALSE, sep = "", dec = ".")
body_acc_y_train <- read.table("./data/UCI HAR Dataset/train/Inertial Signals/body_acc_y_train.txt", header = FALSE, sep = "", dec = ".")
body_acc_z_train <- read.table("./data/UCI HAR Dataset/train/Inertial Signals/body_acc_z_train.txt", header = FALSE, sep = "", dec = ".")

#'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 
body_gyro_x_train <- read.table("./data/UCI HAR Dataset/train/Inertial Signals/body_gyro_x_train.txt", header = FALSE, sep = "", dec = ".")
body_gyro_y_train <- read.table("./data/UCI HAR Dataset/train/Inertial Signals/body_gyro_y_train.txt", header = FALSE, sep = "", dec = ".")
body_gyro_z_train <- read.table("./data/UCI HAR Dataset/train/Inertial Signals/body_gyro_z_train.txt", header = FALSE, sep = "", dec = ".")

##test files

#'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.
subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt", header = FALSE, sep = "", dec = ".") %>%
        rename(subject = V1)

#'train/X_train.txt': Training set.
x_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt", header = FALSE, sep = "", dec = ".")

#'train/y_train.txt': Training labels.
y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt", header = FALSE, sep = "", dec = ".") %>%
        rename(activity_label = V1) 

#'test/Inertial Signals/total_acc_x_test.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_test.txt' and 'total_acc_z_test.txt' files for the Y and Z axis. 
total_acc_x_test <- read.table("./data/UCI HAR Dataset/test/Inertial Signals/total_acc_x_test.txt", header = FALSE, sep = "", dec = ".")
total_acc_y_test <- read.table("./data/UCI HAR Dataset/test/Inertial Signals/total_acc_y_test.txt", header = FALSE, sep = "", dec = ".")
total_acc_z_test <- read.table("./data/UCI HAR Dataset/test/Inertial Signals/total_acc_z_test.txt", header = FALSE, sep = "", dec = ".")

#'test/Inertial Signals/body_acc_x_test.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 
body_acc_x_test <- read.table("./data/UCI HAR Dataset/test/Inertial Signals/body_acc_x_test.txt", header = FALSE, sep = "", dec = ".")
body_acc_y_test <- read.table("./data/UCI HAR Dataset/test/Inertial Signals/body_acc_y_test.txt", header = FALSE, sep = "", dec = ".")
body_acc_z_test <- read.table("./data/UCI HAR Dataset/test/Inertial Signals/body_acc_z_test.txt", header = FALSE, sep = "", dec = ".")

#'test/Inertial Signals/body_gyro_x_test.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 
body_gyro_x_test <- read.table("./data/UCI HAR Dataset/test/Inertial Signals/body_gyro_x_test.txt", header = FALSE, sep = "", dec = ".")
body_gyro_y_test <- read.table("./data/UCI HAR Dataset/test/Inertial Signals/body_gyro_y_test.txt", header = FALSE, sep = "", dec = ".")
body_gyro_z_test <- read.table("./data/UCI HAR Dataset/test/Inertial Signals/body_gyro_z_test.txt", header = FALSE, sep = "", dec = ".")

## bring data together - TEST
library(tidyr)

#4.Appropriately labels the data set with descriptive variable names. 
features_text <- features_text %>% mutate(human_variable = tolower(variable))

library(stringi)
#make variables human readable for tidyness
features_text$human_variable <- stri_replace_all_regex(features_text$human_variable,
                                  pattern=c('^t', '^f', '\\(\\)', '\\(' , '\\)', '-', ','),
                                  replacement=c('time_', 'freq_', '' , '', '', '_', '_'),
                                  vectorize=FALSE)
#and save in vector
human_variable_names <- features_text$human_variable

#replace x_test and x_train names with features_text variable names
names(x_test) <- human_variable_names
names(x_train) <- human_variable_names

#3.Uses descriptive activity names to name the activities in the data set
y_test <- left_join(y_test, activity_labels, by = "activity_label")
y_train <- left_join(y_train, activity_labels, by = "activity_label")

#combine test and train subjects and their variable vectors and
subject_x_test <- cbind(subject_test, y_test, x_test)
subject_x_train <- cbind(subject_train, y_train, x_train)

#Merge text and train sets into one
tidy_data <- rbind(subject_x_test, subject_x_train)

#2.Extracts only the measurements on the mean and standard deviation for each measurement.
library(data.table)
mean_std_tidy_data <- tidy_data[names(tidy_data) == "subject" | names(tidy_data) == "activity_name" |names(tidy_data) %like% "mean" | names(tidy_data) %like% "std"]

#5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
final_tidy_data <- mean_std_tidy_data %>% group_by(subject, activity_name) %>% summarise(across(everything(), list(mean)))

write.table(mean_std_tidy_data, file = "mean_std_tidy_data.txt", row.names = FALSE)
write.table(final_tidy_data, file = "final_tidy_data.txt", row.names = FALSE)
