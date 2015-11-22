# Getting and Cleaning Data Project

##Summary
The purpose of this project is to demonstrate the ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. The used data was collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

##The Script
The script called run_analysis.R was created to get a clean the data collected from the accelerometers from the Samsung Galaxy S smartphone.  The script in the file called run_analysis.R performs the following. 
* Merges the training and the test sets to create one data set.
* Extracts only the measurements on the mean and standard deviation for each measurement. 
* Uses descriptive activity names to name the activities in the data set
* Appropriately labels the data set with descriptive variable names. 
* From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

 ***Note: In order to the script works properly, all the data should be in your R working directory. The root folder should be named "UCI HAR Dataset".***

 ##Steps
 In order to achieve the objectives of the project, the script performs the following steps to get and clean the data:
 1. Include the necessary libraries to work (i.e. data.table, plyr, dplyr).
 2. Read the data from files using the fread function.
 3. Add id columns to the catalogs in order to be able to perform join operations. 
 4. Rename columns in datasets by significative names.
 5. Filter columns to get only mean and standar deviation variables.
 6. Merge data with catalogs.
 7. Append train data to test data to get an unique dataset.
 8. Summarize data grouping by activity and subject.
 9. Write the final dataset to disk.


##Files
* Readme: Contains general information about the script and the project objective.
* CodeBook: Contains information about the variables in the final dataset.
* run_analysis.R: Script to get and clean the data.