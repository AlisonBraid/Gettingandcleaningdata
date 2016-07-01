Getting and cleaningdata assignment README.

The R script called run_analysis.R does the following:

-Download the dataset if it does not already exist in the working directory.

-Loads the activity and feature information.

-Loads training and test data. It maintains columns that reflect a mean or standard deviation only.

-Loads the activity and subject data for each set of data, and combines the columns with the dataset.

-Merges the two sets of data.

-Converts into factors the activity and subject columns.

-Creates a tidy data file that contains the mean value of each variable for each subject and activity combination.

Result is in the tidyset.txt file.
