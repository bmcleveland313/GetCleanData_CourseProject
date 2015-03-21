## README

This is a description of the run_analysis.R script used to create the dataset "tidy_data.txt".

First, the following data files were imported using read.table(<filename>, header = FALSE) and assigned the names for the data.frame in paranthesis:

X_train.txt (xtrain)
Y_train.txt (ytrain)
X_test.txt (xtest)
Y_test.txt (ytest)
subject_test.txt (sub_test)
activity_labels.txt (activity_labels)
features.txt (features)

The columns of "activity_labels" were renamed to "Act_Number" and "Act_Label", and the one column in ytrain and
ytest were renamed to "Act_Number".

Using "Act_Number" as a primary key, a left join was performed on both ytrain and ytest with activity_labels
to assign a descriptive activity name to the activity number originally in ytrain and ytest. 

sub_train was merged with ytrain to create a dataframe called sub_ytrain that included the subject and activity description of each row.
sub_ytrain column names were changed to ""Subject", "Activity_Number", "Activity_Label".

features was melted and the column descriptors for the xtrain and xtests were extracted in column 3. A vector named "b" was created
that contained the transposed column descriptors. The column names on xtrain and xtest were renamed using the vector b.

sub_ytrain and xtrain are merged to create a dataset called "train" with subject identifiers, activity labels, and experimental measurement data.  

sub_train was merged with ytest to create a dataframe called sub_ytest that included the subject and activity description of each row.
sub_ytest column names were changed to ""Subject", "Activity_Number", "Activity_Label".

sub_ytest and xtest are merged to create a dataset called "test" with subject identifiers, activity labels, and experimental measurement data.  

train and test are combined into a dataframe called "comb".

Only columns containing the strings "mean" or "std" are extracted using grepl functions.

Activity_Number is dropped from the dataframe.

The final dataset is created by subsetting comb by Subject and Activity_Label and computing the mean of each experimental measurement column.