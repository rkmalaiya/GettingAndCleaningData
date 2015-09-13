library(data.table)
library(dplyr)
library(plyr)

# Read Features.txt file
features <- read.table("UCI HAR Dataset\\features.txt", col.names = c("ids","features"))
activity <- read.table("UCI HAR Dataset\\activity_labels.txt", col.names = c("ids","activities"))
activity$activities <- as.character(activity$activities)

read_data <- function(sub_loc, x_loc, y_loc) {

  # Read Subject file
subject <- read.table(paste0("UCI HAR Dataset", sub_loc), col.names = "subjects")

# Read X_ file
x_train <- read.table(paste0("UCI HAR Dataset", x_loc), col.names = features$features, colClasses = rep("numeric",length(features$ids)))

# Read y_ file
y_train <- read.table(paste0("UCI HAR Dataset", y_loc), col.names = "predictions", colClasses = "factor")

levels(y_train$predictions) <- activity$activities
train <- cbind(subject, x_train, y_train)
}


har_data <- rbind(read_data("\\train\\subject_train.txt" , "\\train\\X_train.txt", "\\train\\y_train.txt"),
                  read_data("\\test\\subject_test.txt" , "\\test\\X_test.txt", "\\test\\y_test.txt")
                  )

names(har_data)<-gsub("^t", "time", names(har_data))
names(har_data)<-gsub("^f", "frequency", names(har_data))
names(har_data)<-gsub("Acc", "Accelerometer", names(har_data))
names(har_data)<-gsub("Gyro", "Gyroscope", names(har_data))
names(har_data)<-gsub("Mag", "Magnitude", names(har_data))
names(har_data)<-gsub("BodyBody", "Body", names(har_data))

str(har_data$predictions)

# Extracting measurements only on mean and standard deviation for each measurement

har_data_mean_Std <- har_data %>% dplyr::select(contains("subjects"), contains(".mean."), contains(".std."), contains("predictions")) 

head(har_data_mean_Std)

har_data_avg <- ddply(har_data_mean_Std, ~ subjects ~ predictions, 
                      function(x) 
                        {
                        colMeans(dplyr::select(x, -contains("subjects"), -contains("predictions")))
                        }
                      )
write.table(har_data_avg, file = "har_avg.csv", row.names = F)
