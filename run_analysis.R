## You will need to set the working directory accordingly
## This is the only place where changes are needed
setwd("~/Dropbox/Files/ds/getting_and_cleaning_data/proj")

## Read in the datasets
## Train dataset
trainSub <- read.table("./UCI HAR Dataset/train/subject_train.txt", header = FALSE)
trainX <- read.table("./UCI HAR Dataset/train/X_train.txt", header = FALSE)
trainY <- read.table("./UCI HAR Dataset/train/Y_train.txt", header = FALSE)
train <- cbind(trainSub, trainY, trainX)
## Test dataset
testSub <- read.table("./UCI HAR Dataset/test/subject_test.txt", header = FALSE)
testX <- read.table("./UCI HAR Dataset/test/X_test.txt", header = FALSE)
testY <- read.table("./UCI HAR Dataset/test/Y_test.txt", header = FALSE)
test <- cbind(testSub, testY, testX)

## Combine test and train datasets
df <- rbind(train,test)

## Add column names
featureNames <- c("Subject","Activity",as.vector(read.table("./UCI HAR Dataset/features.txt", header = FALSE)[,2]))
names(df) <- featureNames
## Only keep the variables on the mean and standard deviation
## Do not forget the Subject and the dependent variable though
## ignore.case is set to FALSE to ignore some angle variables with Mean in the name
dfKeep <- df[,grepl("(Subject)|(Activity)|(mean)|(std)", names(df), ignore.case = FALSE)]

## Use descriptive activity names to name the activities in the data
activityNames <- read.table("./UCI HAR Dataset/activity_labels.txt", header = FALSE)
names(activityNames) <- c("Activity", "Activity Description")
## Merge the dataset and then drop the Activity column
dfKeep <- merge(dfKeep, activityNames, by.x = "Activity", by.y = "Activity", all = TRUE)
dfKeep$Activity <- NULL

## Label the dataset with descriptive variable names
names(dfKeep) <- gsub("(","",names(dfKeep),fixed = TRUE)
names(dfKeep) <- gsub(")","",names(dfKeep),fixed = TRUE)
names(dfKeep) <- gsub("^t","Time",names(dfKeep))
names(dfKeep) <- gsub("Acc","Accelerometer",names(dfKeep))
names(dfKeep) <- gsub("Gyro","Gyroscope",names(dfKeep))
names(dfKeep) <- gsub("Mag","Magnitude",names(dfKeep))
names(dfKeep) <- gsub("^f","Frequency",names(dfKeep))
names(dfKeep) <- gsub("meanFreq","meanFrequency",names(dfKeep))

## Create a tidy dataset
tidy <- aggregate(. ~ dfKeep$Subject + dfKeep$`Activity Description`, data = dfKeep, FUN = mean)
tidy$Subject <- NULL
tidy$`Activity Description` <- NULL
names(tidy) <- c("Subject", "Activity", as.vector(names(tidy))[-(1:2)])

## Save to a file
write.table(tidy, file = "./tidy.txt", row.names = FALSE)