---
title: "CodeBook.md"
output: html_document
---

This is an R Markdown document. Markdown is a simple formatting syntax for authoring HTML, PDF, and MS Word documents. For more details on using R Markdown see <http://rmarkdown.rstudio.com>.

#Description of the algorithm

1. All the similar data (i.e. Train, Test, Subject) is merged using the rbind() function.
2. In the second test, only the columns with the mean and SD measures are extracted from the whole dataset. These columns are then assigned the correct names, using the features.txt.
3.  Activity data is addressed with values 1:6, activity names and IDs are retrieved from activity_labels.txt and they are substituted in the dataset.
4. On the whole dataset, those columns with non descriptive column names are corrected.
5. The final sep is to generate a new dataset with all the average measures for each subject and activity type (30 subjects x 6 activities = 180 rows). The output file is called averages_data.txt, and uploaded to the GitHub repository.

#Variables Description

1. x_train_data, y_train_data, x_test_data, y_test_data, subject_train_data and subject_test_data data tables contains the data from the downloaded files.
2. x_data, y_data and subject_data merge the previous datasets for further analysis.
features contains the correct names for the x_data dataset, which are applied to the column names stored in mean_and_std_features, a numeric vector used to extract the desired data.
3 A similar approach is taken with activity names through the activities variable.
4. all_data is merged into a big data set using information present in x_data, y_data and subject_data.
5. averages_data contains the averages which will be later stored in a .txt file. ddply() from the dplyr package is used to apply colMeans().