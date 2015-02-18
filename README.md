This repository includes a script and codebook for tidying the Human Activity Recognition Using Smartphones Data Set from the UCI Machine Learning Repository.

The script (run_analysis.R) tidies the data set by averaging the mean and standard deviation of each feature for each activity by each subject. Specifically, it first sets up the workspace, then subsets only the mean and standard deviation variables for each feature, combines the training and test data sets into one, (re)names the subject, activity, and feature variables of the set, and lastly, exports the resulting (wide) tidy data set.

Setting up the workspace, the script loads the "dplyr" package and imports then converts all the data (including the activity and feature lists) into "dplyr" data frames.

Subsetting only the mean and standard deviation variables for each feature, it binds the "X" training and test frames, renames the feature variables with syntactically valid names, and then subsets accordingly.

Combining the training and test data sets into one, it first binds the "subject" training and test frames together, the "y" training and test frames, and finally, the "X" training and test frames altogether.

(Re)naming the subject, activity, and feature variables of the set, it names the subject and activity variables accordingly, renames some features variables which duplicate "Body," and renames the activity factors in correspondence to the activity labels list.

Lastly, exporting the resulting (wide) tidy data set, the script first arranges and groups the data set by subject and activity, then summarizes the mean of each feature variable by the groupings, and finally, outputs the tidy data set.
