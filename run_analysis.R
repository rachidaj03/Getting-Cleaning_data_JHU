library("dplyr")

# Reading all the files from the testion and training directories, the current working directory is the unzipped file from the dataset 

test_files<-list.files("UCI HAR Dataset/test",recursive=TRUE)
train_files<-list.files("UCI HAR Dataset/train",recursive=TRUE)

# 2 loops that will assign to each string which is the name of the file, the data corresponding to it whitout needing to name each variable ==> Automated pipeline
for (file in test_files){
	c<-paste("UCI HAR Dataset/test/",file,sep="")
	data<-read.table(c)
	assign(file,data)
}

for (file in train_files){
	c<-paste("UCI HAR Dataset/train/",file,sep="")
	data<-read.table(c)
	assign(file,data)
}

# Creating a variable that will have the same features that the variables test_files and train_files have already below 
final_data<-list.files("UCI HAR Dataset/test",recursive=TRUE)
final_data<-gsub("test.txt","",final_data)
final_data<-gsub("Inertial Signals","",final_data)

# Looping so we can merge the two datasets and store them in variables that names are stored in final_data, only the get function will help restore them
for (name in final_data){
	name_test<-gsub("/","Inertial Signals/",name)
	name_train<-gsub("/","Inertial Signals/",name)
	name_test<-paste(name_test,"test.txt",sep="")
	name_train<-paste(name_train,"train.txt",sep="")
	data_test<-get(name_test)
	data_train<-get(name_train)
	data_final<-full_join(data_test,data_train)
	assign(name,data_final)
	}
	
# Solving an error of full_join of y occuring to match the data set
y_ <- rbind(get("y_test.txt"), get("y_train.txt"))
# Merged data in final with data sets and data labels
X_<-get("X_")
subject_<-get("subject_")
merged_data<-cbind(subject_,y_,X_)
#Extracting mean and standard deviation measurements
features<-read.table("UCI HAR Dataset/features.txt")
features<-features[,-1]
names(merged_data)<-c("subject","code",features)
merged_data <- merged_data %>% select(subject, code, contains("mean"), contains("std"))

#Activities searching
activities<-read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
merged_data$code<-activities[merged_data$code,2]

#Labeling the dataset
names(merged_data)[2]<-"Activity"
names(merged_data)<-gsub("Acc", "Accelerometer", names(merged_data))
names(merged_data)<-gsub("Gyro", "Gyroscope", names(merged_data))
names(merged_data)<-gsub("BodyBody", "Body", names(merged_data))
names(merged_data)<-gsub("Mag", "Magnitude", names(merged_data))
names(merged_data)<-gsub("^t", "Time", names(merged_data))
names(merged_data)<-gsub("^f", "Frequency", names(merged_data))
names(merged_data)<-gsub("tBody", "TimeBody", names(merged_data))
names(merged_data)<-gsub("-mean()", "Mean", names(merged_data), ignore.case = TRUE)
names(merged_data)<-gsub("-std()", "STD", names(merged_data), ignore.case = TRUE)
names(merged_data)<-gsub("-freq()", "Frequency", names(merged_data), ignore.case = TRUE)
names(merged_data)<-gsub("angle", "Angle", names(merged_data))
names(merged_data)<-gsub("gravity", "Gravity", names(merged_data))

result<-merged_data %>% group_by(subject, Activity) %>% summarise(across(everything(), mean))
# If you do not want to save the data in a txt file make the comment 
write.table(result, "Data_summarized.txt", row.name=FALSE)
