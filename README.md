# Getting and Cleaning Data Course Project

In today's era of wearable computing, companies like Nike, Fitbit, and Jawbone Up and racing to develop the most advanced technologies to widen their user base. In this project, data was collected from the accelerometers from the Samsung Galaxy S smartphone to measure human activity recognition. A full description of the data obtained can be found [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones). The data that was used can be obtained from this [dataset](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip). 

This repository contains 3 files: 

- `run_analysis.R`: This script goes through the entire data cleaning pipeline, from downloading and unzipping the datasets from their http(s) sources and cleans them for easier readability and downstream analysis. Specifically, the script runs through the following processes:

  1) Downloads and reads in the data from http source.
  2) Merges the training and the test sets to create one data set.
  3) Extracts only the measurements on the mean and standard deviation for each measurement.
  4) Uses descriptive activity names to name the activities in the data set and appropriately labels the data set with descriptive variable names.
  5) From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

- `final_data.txt`: The end result of running `run_analysis.R`; a second, independent tidy data set with the average of each variable for each activity and each subject.

- `CodeBook.md`: A detailed code book that describes the variables, the data, and the transformations performed throughout the cleaning process.
