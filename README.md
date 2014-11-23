Readme 
====================

Script run_analysis.R merges train data and test data [collected] (http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) from the accelerometers from the Samsung Galaxy S smartphone

##### 1. Merge the training and the test sets to create one data set.


Script downloads the [UCI HAR Dataset](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip ) from URL provided in the assignment description, unzips it to working directory and merges together train data and test data. Variable names were taken from 'feature.txt' file.
 

##### 2. Extract only the measurements on the mean and standard deviation for each measurement. 

'sparevect' is vector that contains indices of each measurement mean and standard deviation columns, and manually added 'Subject ID' and 'Activity' columns. Using this vector, 'smallframe' subset was extracted.

##### 3. Use descriptive activity names to name the activities in the data set

'Activity' column was converted to factor with labels corresponding to six activities and taken from 'activity_labels.txt' file.

##### 4. Appropriately labels the data set with descriptive variable names. 

Names were edited using 'sub' function to the best of my aesthetic judgement: redundant "Body" cleaned up, names expanded to be more understandable

##### 5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

'smallframe' was converted to table to use 'tapply' function. Average for each variable for each activity and each subject was calculated, and then all the averages were written in a form of a textfile 'tidydata.txt'
