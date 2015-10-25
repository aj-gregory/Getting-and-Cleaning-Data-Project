# Getting and Cleaning Data: Course Project

## Info on raw data
The raw data for this analysis was collected by the UCI Center for Machine Learning and Intelligent Systems. Information can be found at this site: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## Running the script
To run this script you must have the UCI HAR Dataset and `run_analysis.R` in your working directory. Then call `run_analysis()` and the output will be a tidy dataset of the mean of each mean or standard deviation variable per subject and activity. You must also have the `plyr` package installed.

## Viewing results
The best way to view the results of the `run_analysis.R` script is to load the `completed_assignment.txt` file into R with `data <- read.table('completed_assignment.txt', header = TRUE)` and then `View(data)`

## Summary of steps taken by run_analysis.R
1. (line 2) Load the `plyr` package. This will be used for the `ddply` function to find the means of each variable in the final step.
2. (lines 4-11) Read in all relevant data from the UCI HAR Dataset.
3. (lines 14-16) Append `x.test` to `x.train`, `y.test` to `y.train`, and `subject.test` to `subject.train` using `rbind()`.
  - This leaves us with three dataframes with 10299 rows each called `x.all`, `y.all`, and `subject.all`.
  - `x.all` represents the measured data for each trial.
  - `y.all` represents the activity being performed in each trial.
  - `subject.all` represents the subject performing each trial.
  - The "test" datasets are always appended to the "train" datasets to make sure our data stays in order and the rows from each resulting dataframe correspond with the same row in each other dataframe.
4. (lines 18-22) Rename the columns of each dataset with descriptive names.
  - `x.all` columns are renamed according to the list of features provided by the UCI HAR Dataset.
  - `y.all` contains only one column and it is given the name 'Activity'.
  - `subject.all` contains only one column and it is given the name 'Subject'.
5. (line 25) Extract columns from `x.all` that correspond to mean and standard deviation variables.
  - This is done by filtering on any column names containing "mean" or "std".
  - The decision was made to retain `meanFreq` columns due to the fact that it was not explicitly stated weather these columns were needed or not and it would be trivial to ignore or remove these columns whereas adding them back in would be more difficult.
6. (lines 28-29) Convert `y.all` to a factor of activity names with descriptive labels.
  - First `y.all` is converted into a factor. Then the levels of the resulting factor are set in accordance with the activity labels provided by the UCI HAR Dataset.
7. (line 32) Combine `subject.all`, `y.all`, and `x.all`.
  - The three dataframes are combined using `cbind()` so that the resulting data frame has one column named "Subject", one column named "Activity", then one column per mean or standard deviation variable extracted in step 5.
8. (line 35) Create final dataframe of the mean of each variable per subject and activity.
  - This is done with the `ddply()` function.
  - The `numcolwise()` function is used to specify that we want the mean function applied to every column other than the category columns "Subject" and "Activity"
