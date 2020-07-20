# Code Book

`run_analysis.R` goes through five different steps in order to obtain a final, clean data set.

- Downloading and reading in the data
  - The data is downloaded from [this](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) link. If the filename does not exist within the working directory, then the file is unzipped using the `unzip()` function. The `UCI HAR Dataset` folder appears in the list of files in the working directory.
  - Each main dataset from the `UCI HAR Dataset` folder is read in using the `read_table()` function. 
    - `activities` from `activity_labels.txt` (6 rows by 2 columns): contains the list of activities performed while measurements were obtained. Includes `class_labels` (or codes) for each activity 
    - `features` from `features.txt` (561 rows by 2 columns): contains features from the gyroscope and accelerometer 3-axial signals tAcc-XYZ and tGyro-XYZ 
    - `subject_test` from `subject_test.txt` (2947 rows by 1 column): includes the test data of 9 out of 30 subjects observed 
    - `x_test` from `test/X_test.txt` (2947 rows by 561 columns): includes the observed features of the test data 
    - `y_test` from `test/y_test.txt` (2947 rows by 1 column): includes the activity's class labels test data 
    - `subject_train` from `train/subject_train.txt` (7352 rows by 1 column): contains the training data of the other 21 out of 30 test subjects observed 
    - `x_train` from `train/X_train.txt` (7352 rows by 561 columns): includes the observed features of the train data 
    - `y_train` from `train/y_train.txt` (7352 rows by 1 column): includes the activity's class labels train data 

- Merges the training and the test sets to create one data set.
  - The `x_test` and `x_train` tables are binded by rows to create the table `X` (10299 rows by 561 columns); the `y_test` and `y_train` tables are binded by rows to create the table `Y` (10299 rows by 1 column); the `subject_test` and `subject_train` tables are binded by rows (`rbind()`) to create the table `subject` (10299 rows by 1 column)
  - The `X`, `Y`, and `subject` tables are binded by columns (`cbind()`) to create the table `mdf` (10299 rows by 563 columns)
  
- Extracts only the measurements on the mean and standard deviation for each measurement.
  - `tidy_df` is created by using the dplyr function `select` to obtain columns that include `mean` or `std`
  - The columns returned include the `subject`, `class_labels`, and any columns that include `mean` or `std`
  
- Uses descriptive activity names to name the activities in the data set and appropriately labels the data set with descriptive variable names.
  - `class_labels` column names are modified to become the corresponding activity from the list found in the `activities` table
  - The `class_labels` column is renamed into the `activity` column
  - Abbreviations are made more detailed: all `Gyro` in columns become `Gyroscope`, `Freq` becomes `Frequency`, `Acc` becomes `Accelerometer`, `Mag` becomes `Magnitude`
  - In all columns that start with `f`, the `f` is replaced by `Frequency`; similarly, all that start with `t` are replaced with `Time`
  - `BodyBody` was changed to just `Body`
  
- From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
  - All measurements were in double format, so there was no need to convert column types
  - `final_data` was obtained by grouping `tidy_df` by subject and activity (using `group_by`) and summarizing by mean (using `summarize_all` to summarize all variables)
  - The final text file `final_data.txt` is written to the working directory
  
  
The text file `final_data.txt` can now be used to perform any further analyses.