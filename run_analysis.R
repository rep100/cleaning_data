# Include libraries
print("Loading libraries")
library(data.table)
library(plyr)
library(dplyr)

# Read data from files
print("Reading data from files")
x_train <- fread("UCI HAR Dataset/train/X_train.txt")
x_test <- fread("UCI HAR Dataset/test/X_test.txt")
train_label <- fread("UCI HAR Dataset/train/y_train.txt")
test_label <- fread("UCI HAR Dataset/test/y_test.txt")
train_subject <- fread("UCI HAR Dataset/train/subject_train.txt")
test_subject <- fread("UCI HAR Dataset/test/subject_test.txt")
column_names <- fread("UCI HAR Dataset/features.txt")
activity_labels <- fread("UCI HAR Dataset/activity_labels.txt")

print("Transforming data...")

# Add index to catalogs
train_label <- mutate(train_label, x_id = seq.int(nrow(train_label)))
test_label <- mutate(test_label, x_id = seq.int(nrow(test_label)))
train_subject <- mutate(train_subject, x_id = seq.int(nrow(train_subject)))
test_subject <- mutate(test_subject, x_id = seq.int(nrow(test_subject)))

# Rename columns in catalog datasets
train_label <- dplyr::rename(train_label, label_id = V1)
test_label <- dplyr::rename(test_label, label_id = V1)
train_subject <- dplyr::rename(train_subject, subject_id = V1)
test_subject <- dplyr::rename(test_subject, subject_id = V1)
column_names <- dplyr::rename(column_names, id = V1, col_name = V2)
activity_labels <- dplyr::rename(activity_labels, label_id = V1, activity = V2)

# Rename columns in data (descriptive variable names)
setnames(x_test, names(x_test), column_names[,column_names$col_name])
setnames(x_train, names(x_train), column_names[, column_names$col_name])

# Filter columns, get only mean and standar deviation.
x_test_filt <- select(x_test, matches("(mean\\(\\))|(std\\(\\))"))
x_train_filt <- select(x_train, matches("(mean\\(\\))|(std\\(\\))"))

# Add index to data
x_test_filt <- mutate(x_test_filt, x_id = seq.int(nrow(x_test_filt)))
x_train_filt <- mutate(x_train_filt, x_id = seq.int(nrow(x_train_filt)))

# Merge data with label and subject
train_dfList <- list(x_train_filt, train_label, train_subject)
test_dfList <- list(x_test_filt, test_label, test_subject)
merged_train <- join_all(train_dfList)
merged_test <- join_all(test_dfList)

#Include descriptive activity names
merged_test <- join(merged_test, activity_labels, by = "label_id")
merged_train <- join(merged_train, activity_labels, by = "label_id")

#Merge train and test data
final_data <- bind_rows(merged_test, merged_train)

# Create new dataset with the average of each variable for each activity and each subject.
summarized_data <- final_data %>% select(-matches("(x_id)|(label_id)")) %>% group_by(activity, subject_id) %>% summarise_each(funs(mean))

# Save final dataset to disk
write.table(summarized_data, file = "summarized_datax.txt", row.names = FALSE)

print("The final dataset (summarized_datax.txt) has been saved in your workspace.")
