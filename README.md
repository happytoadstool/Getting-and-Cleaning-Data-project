# Analyis description

The analysis script is contained in run_analysis.R and is commented.

Initial code lines read in data using read.table

Merge lines merge the test and train data for each of:
- x files, containing the measured variables
- y files, containing the activity codes for each of the rows of the measured variables
- subject files, containing the subject code for each of the measured variables

We then apply the names from the features data file as the variable names in the merged_x dataframe.

Then, we use the named activities from the activity_labels file to provide descriptive names to the rows in the merged y dataframe

Then, we extract just the columns with variable names containing 'mean' or 'std' (regardless of case).  The resultant dataframe is called full_data.

We then combine the full_data, subject and activity files so we have a single dataframe with all variables of interest.

We then use functions from the dplyr package to group the data by subject and activity, and calculate the mean
of each column for each group of subject and activity.  The resultant dataframe is tidy in the wide format, with one row for each observation, and one column for each variable.

Finally, we export this dataframe for submission.

The exported file can be read using read.table("tidydata.txt", header=TRUE)