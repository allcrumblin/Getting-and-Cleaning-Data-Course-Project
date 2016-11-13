# Getting-and-Cleaning-Data-Course-Project

This repository contains the solution to the Getting and Cleaning Data Course Project. The script gets, cleans and analyzes the data collected from the accelerometers from the Samsung Galaxy S smartphone from volunteers that performed six different activites.

The data set can be found here:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

# Files

* Codebook.md - data that indicates all the variables and summaries calculated and any other relevant information.
* run_analysis.R - performes necessary getting, cleaning and analysis steps to produce a tidy data set

# How the analysis is performed

The following steps are supposed to be solved by the analysis script

* Merges the training and the test sets to create one data set.
* Extracts only the measurements on the mean and standard deviation for each measurement.
* Uses descriptive activity names to name the activities in the data set
* Appropriately labels the data set with descriptive variable names.
* From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

First the train and test data sets and the corresponding activity, and subject files are loaded into R. Next the activity labels and features are read. Then only the measurements on the mean and standard deviations are selected and the features names are cleaned so that they are more easily to read and that they are descriptive. The dataframes are then accordingly subsetted. Afterwards the train and test datasets are each columbound to their corresponding Subject and Activities IDs. Next the data is merged by rowbinding and the feature names are added to the column names. Then the dataframe is molten to the subject and the activity until it is casted into a dataframe. Finally the dataframe is written to a *.txt file*.
