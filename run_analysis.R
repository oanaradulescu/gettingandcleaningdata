# The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. 
# The goal is to prepare tidy data that can be used for later analysis. 
# You will be graded by your peers on a series of yes/no questions related to the project. 
# You will be required to submit: 
# 1) a tidy data set as described below, 
# 2) a link to a Github repository with your script for performing the analysis, 
# and 3) a code book that describes the variables, the data, 
# and any transformations or work that you performed to clean up the data called CodeBook.md. 
# You should also include a README.md in the repo with your scripts. 
# This repo explains how all of the scripts work and how they are connected.  
# 
# One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 
#         
#         http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
# 
# Here are the data for the project: 
#         
#         https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

# You should create one R script called run_analysis.R that does the following. 
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive activity names. 
# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

library(data.table)

# training

# training set
# - Features are normalized and bounded within [-1,1].
# - Each feature vector is a row on the text file.

x.train <- read.table("UCI HAR Dataset/train/X_train.txt")

# training labels
y.train <- read.table("UCI HAR Dataset/train/y_train.txt")
names(y.train) <- c("Activity")

# each row identifies the subject who performed the activity for each window sample
subj.train <- read.table("UCI HAR Dataset/train/subject_train.txt")
names(subj.train) <- c("Subject")

# summary(subj.train)
# summary(x.train)
# str(x.train)
# 
# summary(y.train)

# test
x.test <- read.table("UCI HAR Dataset/test/X_test.txt")
y.test <- read.table("UCI HAR Dataset/test/y_test.txt")
names(y.test) <- c("Activity")
subj.test <- read.table("UCI HAR Dataset/test/subject_test.txt")
names(subj.test) <- c("Subject")

f <- read.table("UCI HAR Dataset/features.txt")
a <- read.table("UCI HAR Dataset/activity_labels.txt")

df.train <- data.frame(x.train, y.train, subj.train)
df.test <- data.frame(x.test, y.test, subj.test)

# head(df.train, 10)
# head(df.test, 10)

# 1. Merges the training and the test sets to create one data set.

df <- rbind(df.train, df.test)
# df <- do.call(rbind, list(df.train, df.test))

# head(df)
# head(f)
# nrow(f[grep('mean|std', f[,"V2"]),])

# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 

colnum <- paste("V", f[grep('mean|std', f[,"V2"]),]$V1, sep = "")
colnum[length(colnum) + 1] <- "Activity"
colnum[length(colnum) + 1] <- "Subject"

df.mstd <- data.frame(subset(df, select=colnum))

# 3. Uses descriptive activity names to name the activities in the data set

colname <- as.character(f[grep('mean|std', f[,"V2"]),]$V2)
colname[length(colname) + 1] <- "Activity"
colname[length(colname) + 1] <- "Subject"

names(df.mstd) <- colname

# colnames(df.mstd)

# 4. Appropriately labels the data set with descriptive activity names

df.mstd <- merge(df.mstd, a, by.x = "Activity", by.y = 1)
df.mstd <- select(df.mstd, -(Activity))
names(df.mstd)[81] <- "Activity"

# head(df.mstd)

# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

tidy.data <- data.table(df.mstd)
tidy.data <- tidy.data[, lapply(.SD, mean(na.rm = TRUE)), by = c("Activity", "Subject")]

write.table(tidy.data, file = "tidydata.txt")

# tt <- read.table("tidydata.txt")

# head(tidy.data)
# str(tidy.data)

