setwd("~/datascience/datasciencecoursera/GettingCleaningData/Course_Project")
#
xtrain <- read.table("X_train.txt", header = FALSE)
#Numeric Labels for Activities
ytrain <- read.table("Y_train.txt", header = FALSE)
#Numeric Labels for Individuals
sub_train <-read.table("subject_train.txt", header = FALSE) 

xtest <- read.table("X_test.txt", header = FALSE)
ytest <- read.table("Y_test.txt", header = FALSE)
sub_test <-read.table("subject_test.txt", header = FALSE) 


activity_labels <- read.table("activity_labels.txt", header = FALSE)
#Column Labels for xtrain and ytrain
features <- read.table("features.txt", header = FALSE)

#Add activity labels to ytrain and y test so you have descriptive labels instead of numbers
colnames(activity_labels) <- c("Act_Number", "Act_Label")
colnames(ytrain) <- c("Act_Number")
colnames(ytest) <- c("Act_Number")

library(plyr)
activity_labels$Act_Label <- as.character(activity_labels$Act_Label)
ytrain <- join(ytrain, activity_labels, "Act_Number")
ytest <- join(ytest, activity_labels, "Act_Number")

#Merge subject datasets for train and test to activity datasets
sub_ytrain <- cbind(sub_train, ytrain)

#Reshape and Add feature names, merge subject/activities with data points
library(reshape2)
fs <- melt(features, id.vars = c("V1"))
b <- as.vector(t(fs[,3]))
colnames(xtrain) <- b
colnames(xtest) <- b
colnames(sub_ytrain) <- c("Subject", "Activity_Number", "Activity_Label")
train <- cbind(sub_ytrain,xtrain)

#Merge test sets
#Merge subject datasets for train and test to activity datasets
sub_ytest <- cbind(sub_test, ytest)
colnames(sub_ytest) <- c("Subject", "Activity_Number", "Activity_Label")
test <- cbind(sub_ytest,xtest)

comb <- rbind(train, test)
extract <- which(grepl("mean()",b) | grepl("std()",b))
comb <- comb[,extract]
comb <- subset(comb, select=-c(Activity_Number))
comb$Subject <- as.factor(comb$Subject)

library(dplyr)
final <- comb %>% group_by(Subject, Activity_Label) %>% summarise_each(funs(mean))

write.table(final, file = "tidy_data.txt",quote = FALSE,row.name = FALSE)

