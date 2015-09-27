library(dplyr)

# read test data
x_test <- read.table("project/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("project/UCI HAR Dataset/test/Y_test.txt")
subject_test <- read.table("project/UCI HAR Dataset/test/subject_test.txt")

# read train data
x_train <- read.table("project/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("project/UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("project/UCI HAR Dataset/train/subject_train.txt")

activity_labels <- read.table("project/UCI HAR Dataset/activity_labels.txt")
features <- read.table("project/UCI HAR Dataset/features.txt")

# merge
merged_x <- bind_rows(x_test, x_train)
merged_y <- bind_rows(y_test, y_train)
merged_subject <- bind_rows(subject_test, subject_train) %>% rename(subject = V1)

# apply names to variables
names(merged_x) <- features[,2]

# add activity labels
named_activities <- left_join(merged_y, activity_labels, by=c("V1" = "V1") ) %>% 
  rename(activity = V1, activitylabel = V2) %>% select(-activity)

# extract variables of mean and std deviation
full_data <- merged_x[, grep("mean|std",names(merged_x), ignore.case = TRUE)]

# add subjects and activities
full_data <- bind_cols(full_data,merged_subject,named_activities)

# created tidy data set
tidydata <- full_data %>% group_by(subject, activitylabel) %>% summarise_each(funs(mean))

#export data
write.table(tidydata, "project/tidydata.txt", row.names = FALSE)

