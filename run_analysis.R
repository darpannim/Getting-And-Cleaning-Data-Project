library(dplyr)

#### Step 1
#### Merge the training and test sets 
###############################################################################
x_train_data <- read.table("UCI HAR Dataset/train/X_train.txt")
y_train_data <- read.table("UCI HAR Dataset/train/y_train.txt")
subject_train_data <- read.table("UCI HAR Dataset/train/subject_train.txt")

x_test_data <- read.table("UCI HAR Dataset/test/X_test.txt")
y_test_data <- read.table("UCI HAR Dataset/test/y_test.txt")
subject_test_data <- read.table("UCI HAR Dataset/test/subject_test.txt")

# Apply RBind on x_train_data and x_test_data to create the x_data
x_data <- rbind(x_train_data, x_test_data)

# Apply RBind on y_train_data and y_test_data to create the y_data
y_data <- rbind(y_train_data, y_test_data)

# Apply RBind on subject_train_data and subject_test_data to create the subject_data
subject_data <- rbind(subject_train_data, subject_test_data)

#### Step 2
#### Extract only the measurements on the mean and standard deviation for each measurement
###############################################################################

features_data <- read.table("UCI HAR Dataset/features.txt")

# get only columns with mean() or std() in their names
mean_and_std_features <- grep("-(mean|std)\\(\\)", features_data[, 2])

# subset the desired columns
x_data <- x_data[, mean_and_std_features]

# correct the column names
names(x_data) <- features[mean_and_std_features, 2]

# Step 3
# Use descriptive activity names to name the activities in the data set
###############################################################################

activities_data <- read.table("UCI HAR Dataset/activity_labels.txt")

# update values with correct activity names
y_data[, 1] <- activities_data[y_data[, 1], 2]

# Set the correct column name
names(y_data) <- "activity"

# Step 4
# Appropriately label the data set with descriptive variable names
###############################################################################

# Set the correct column name
names(subject_data) <- "subject"

# bind all the data in a single data set
all_data <- cbind(x_data, y_data, subject_data)

# Step 5
# Create a second, independent tidy data set with the average of each variable
# for each activity and each subject
###############################################################################

# 66 <- 68 columns but last two (activity & subject)
averages_data <- ddply(all_data, .(subject, activity), function(x) colMeans(x[, 1:66]))

write.table(averages_data, "averages_data.txt", row.name=FALSE)