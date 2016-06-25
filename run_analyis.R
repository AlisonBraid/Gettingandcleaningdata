##Load train files
x_train <- read.table("./train/X_train.txt")
y_train <- read.table("./train/Y_train.txt")
subject_train <- read.table("./train/subject_train.txt")

##Load test files
x_test <- read.table(".//test/X_test.txt")
y_test <- read.table(".//test/Y_test.txt")
subject_test <-read.table("./test/subject_test.txt")

##Load activityLabels file
activitylabels <- read.table("./activity_labels.txt")

##Load features file
features <- read.table("./features.txt")

##Assign names to column
colnames(x_train) <- features[,2]
colnames(y_train) <- "activityId"
colnames(subject_train) <- "subjectId"
colnames(x_test) <- features[,2]
colnames(y_test) <- "activityId"
colnames(subject_test) <- "subjectId"
colnames(activitylabels) <- c("activityId", "activitylabels")

##Merge data
mergetrain <- cbind(x_train, subject_train, y_train)
mergetest <- cbind(x_test, subject_test, y_test)
all <- rbind(mergetrain, mergetest)
NameCol <-colnames(all)

##Define mean, SD with vector and subset
meansd <- (grepl("activityId", NameCol) | grepl("subjectId", NameCol) | grepl("mean", NameCol) | grepl("sd", NameCol))
subsetmeansd <- all[ , meansd ==TRUE]

##Name with descriptions
activitynames <-merge(subsetmeansd, activitylabels, by = "activityId", all.x= TRUE)

##Dataset by subject and activity 
secondset <- aggregate(. ~subjectId + activityId, activitynames, mean)
secondset <- secondset[order(secondset$subjectId, secondset$activityId), ]

## Write second data set
write.table(secondset, "secondset.txt", row.name = FALSE)

