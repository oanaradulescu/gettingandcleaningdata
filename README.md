gettingandcleaningdata
======================

This analysis code takes Human Activity Recognition using Smartphones (HAR) data and produces a tidy data set 
of measurements per subject (30 subjects in all) per activity (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, 
SITTING, STANDING, LAYING).

The raw data set:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here is the algorithm the script follows to get from raw data to tidy data.

* The training and test data sets of measurements are read in
* The training and test activity classes are read in
* The training and test subjects are read in
* Each row - in the training and test data sets - is tagged with the activity class that produced the measurements
* Each row - in the training and test data sets - is tagged with the subject from whom the measurements came
* The annotated training and test data sets are merged; we'll call this the master (measurement) data set
* Read in features and activity labels reference files 
* Extract the column numbers and column names of interest - variables related to mean and standard deviation - 
from the features file; these column numbers and names map exacty to our master measurement data set
column numbers and names
* Subset the master data set using the column numbers calculated at the previous step; we'll call this the m-std data set
* Rename the columns in the m-std data set with descriptive measurement names obtained from the features file
* Tag each row with the activity label, drop the activity class
* From m-std, create a second, independent tidy data set with the average of each variable for each activity and each subject
* Write the tidy data set out to a text file
