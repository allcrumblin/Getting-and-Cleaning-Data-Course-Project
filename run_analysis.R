library(reshape2)

filename <- "getdata_dataset.zip"

## Download and unzip the dataset:
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
  download.file(fileURL, filename, method="curl")
}  
if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}

#Load train data
train <- read.table("UCI HAR Dataset/train/X_train.txt")
trainActivities <- read.table("UCI HAR Dataset/train/Y_train.txt")
trainSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")

#Load test data
test <- read.table("UCI HAR Dataset/test/X_test.txt")
testActivities <- read.table("UCI HAR Dataset/test/Y_test.txt")
testSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")

#Load activty labels
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
#convert 2nd column to to characters
activityLabels[,2] <- as.character(activityLabels[,2])

#Load features
features <- read.table("UCI HAR Dataset/features.txt")
features[,2] <- as.character(features[,2])
#select only desired features
featuresStat <- grep(".*mean.*|.*std.*", features[,2])
#Get names
featuresStat.names <- features[featuresStat,2]
#Make names more readable
featuresStat.names <- gsub('-mean', 'Mean', featuresStat.names)
featuresStat.names <- gsub('-std', 'Std', featuresStat.names)
featuresStat.names <- gsub('[-()]', '', featuresStat.names)

#Subset data to previously selected features
test <- test[featuresStat]
train <- train[featuresStat]

#columnbind the data to one dataframe
train <- cbind(trainSubjects, trainActivities, train)
test <- cbind(testSubjects, testActivities, test)

# Merge Dataframes
UCI <- rbind(train, test)
# Add Labels
colnames(UCI) <- c("subject", "activity", featuresStat.names)

# sub factors in actiity column by the descriptive variable names found in activityLabels
UCI$activity <- factor(UCI$activity, levels = activityLabels[,1], labels = activityLabels[,2])
# turn subject variables into factors
UCI$subject <- as.factor(UCI$subject)

# melt data frame to subject and activity
UCI <- melt(UCI, id = c("subject", "activity"))

# cast molten dataframe into dataframe
UCI <- dcast(UCI, subject + activity ~ variable, mean)

# write dataframe to file
write.table(UCI, "tidy.txt", row.names = FALSE, quote = FALSE)