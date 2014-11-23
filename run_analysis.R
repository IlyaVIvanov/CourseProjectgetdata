library(data.table)


#download and unzip the data using URL provided in assignment

fileurl = "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
archname = "UCI HAR Dataset.zip"
download.file(fileurl, destfile=archname)
unzip(archname)


#Moving to data directory and grabbing variables name list on the way

setwd("UCI HAR Dataset")
varnames <- fread("features.txt")
varnames <- varnames$V2


#merging the test data, subjects identifiers from test group, and activities together

setwd("test")
x_test <- read.table("X_test.txt")
y_test <- fread("y_test.txt")
subj_test <- fread("subject_test.txt")
testframe <-  cbind(x_test, subj_test, y_test)


#merging together data for train group in the same way

setwd("..")
setwd("train")
x_train <- read.table("X_train.txt")
y_train <- fread("y_train.txt")
subj_train <- fread("subject_train.txt")
trainframe <-  cbind(x_train, subj_train, y_train)


#returning to work directory and merging train and test data together. 
#Preliminary naming them with varnames, taken from "features.txt" before

setwd("..")
setwd("..")
mergedframe <- rbind(trainframe,testframe)
varnames <- c(varnames,"SubjectID", "Activity")
colnames(mergedframe) <- varnames


#picking what columns to extract, we use columns containing mean, std, and manually added variables "ClientID" and "Activity"
#extracted data is in the "smallframe"

sparevect <- c(grep("mean\\(", varnames), grep("std\\(", varnames), 562, 563)
sparevect <- sort(sparevect)
smallframe <- mergedframe[,sparevect]


#Labeling "Activity" column with actual activity names

act <- smallframe$"Activity"
act<-factor(act, labels=c("WALKING","WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING"))
smallframe$"Activity" <- act


#Making variable names more readable

newnames <- names(smallframe)
newnames <- sub("BodyBody", "Body", newnames)
newnames <- sub("\\(\\)", "", newnames)
newnames <- sub("f","Fourier", newnames)
newnames <- sub ("tB","RawSignalB", newnames)
newnames <- sub ("tG","RawSignalG", newnames)
colnames(smallframe) <- newnames


#calculating averages by subject and activity via lapply function. Writing result data to table.

smalltable <- data.table(smallframe)
tidydata <- smalltable[, lapply(.SD, mean), by = c("SubjectID","Activity")]
write.table(tidydata, "tidydata.txt", row.name=FALSE)
