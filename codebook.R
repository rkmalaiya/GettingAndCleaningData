library(memisc)
har_data_avg <- read.table("har_avg.csv", header = T)


Data <- data.set(
  har_data_avg
)

columns <- names(har_data_avg)

columns_body <- columns[grep("Body", columns)]
columns_gravity <- columns[grep("Gravity", columns)]

columns_body_acc <- columns_body[grep("Acc", columns)]
columns_body_Gyro <- columns_body[grep("Gyro", columns)]

columns_gravity_acc <- columns_gravity[grep("Acc", columns)]
columns_gravity_Gyro <- columns_gravity[grep("Gyro", columns)]

Data <- within(Data,{
  
  wording(fBodyBodyGyroJerkMag.std..) <- "Hiiiiiiiiiiiiii"
  
  for(x in columns_body) {
    
    wording(x) <- "the acceleration signal was separated into body acceleration signals using low pass Butterworth filter with a corner frequency of 0.3 Hz. "
  }
  
  for(x in columns_gravity) {
    wording(x) <- "the acceleration signal was separated into gravity acceleration signals using low pass Butterworth filter with a corner frequency of 0.3 Hz. "
  }
  
})


for(x in columns_body) {
  
  print(x)
}



codebook(Data)
