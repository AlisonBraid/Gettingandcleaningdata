library(reshape2)

filename <- "gettingdata.zip"

## Download and unzip:
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
  download.file(fileURL, filename, method="curl")
}  
if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}

# Load activity labels and features
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
activityLabels[,2] <- as.character(activityLabels[,2])
features <- read.table("UCI HAR Dataset/features.txt")
features[,2] <- as.character(features[,2])

# Extract mean and standard deviation
featuresdes <- grep(".*mean.*|.*std.*", features[,2])
featuresdes.names <- features[featuresdes,2]
featuresdes.names = gsub('-mean', 'Mean', featuresdes.names)
featuresdes.names = gsub('-std', 'Std', featuresdes.names)
featuresdes.names <- gsub('[-()]', '', featuresdes.names)


# Load data
train <- read.table("UCI HAR Dataset/train/X_train.txt")[featuresdes]
trainactivities <- read.table("UCI HAR Dataset/train/Y_train.txt")
trainsubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
train <- cbind(trainsubjects, trainactivities, train)

test <- read.table("UCI HAR Dataset/test/X_test.txt")[featuresdes]
testactivities <- read.table("UCI HAR Dataset/test/Y_test.txt")
testsubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
test <- cbind(testsubjects, testactivities, test)

# combine datasets and add labels
all <- rbind(train, test)
colnames(all) <- c("subject", "activity", featuresdes.names)

# convert activities and subjects to factors
all$activity <- factor(all$activity, levels = activityLabels[,1], labels = activityLabels[,2])
all$subject <- as.factor(all$subject)

all.melt <- melt(all, id = c("subject", "activity"))
all.mean <- dcast(all.melt, subject + activity ~ variable, mean)

write.table(all.mean, "tidyset.txt", row.names = FALSE, quote = FALSE)