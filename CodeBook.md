# The Code Book for the working directory
The run_analysis.R script is based on the steps that have been indicated at the Coursera instructions
1. Merges the training and the test sets to create one data set
   - test_files and train_files : lists that contains the name of the files in the train and test directories and subdirectories. Each element is already been read as a dataset
     to retrieve the data, the get() function is needed
   - final_data is a file that contains all the merges of all the files existing in the directories and sub-directories of train and test
   - X_ and y_ and subject_ were used as variable to make it easy for people reading the code to understand the principles
   - merged_data is what interests us it is the measurements along with the subject and the activity he is doing
2. Extracts only the measurements on the mean and standard deviation for each measurement
   - merged_data has also been filtered to have only mean and standard deviation for each measurement
   - I prefered to use the contains("") function other than the grepl because the second one gave me some errors that I could not detect why 
3. Uses descriptive activity names to name the activities in the data set
   - merged_data has been labeled to activities rather than a code number
4. Appropriately labels the data set with descriptive variable names
   - Some labels has been used to make it easy for the user to see the columns : "Acc" to "Accelerometer", "Gyro" to "Gyroscope","BodyBody" to "Body" ,"Mag" to "Magnitude",
     "^t" to "Time","^f"to "Frequency","tBody" to "TimeBody","-mean()" to "Mean","-std()" to "STD","-freq()" to "Frequency","angle" to "Angle" ,"gravity" to "Gravity"
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
   - result is the variable that contains all the data that has been cleaned in the processed along with setting the average for each activity and subject
