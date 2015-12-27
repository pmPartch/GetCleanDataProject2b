#programming assignment for Coursera class 'Getting and Cleaning Data'

#check if the raw data exists locally, download and unzip if not
if (file.exists("UCI HAR Dataset") == FALSE)
{
    fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    
    temp <- tempfile()
    
    download.file(fileUrl,temp)
    
    print(paste("DateTime of raw file download is:",Sys.time()))
    
    unzip(temp)    #unzip file to local working directory

    unlink(temp)   #remove temp file since no longer needed
}

#############
#load data global

#activity_labels.txt
fileUrl <- file.path("UCI HAR Dataset","activity_labels.txt")

data_activityLabels <- read.table(fileUrl, header = FALSE)

#features.txt
fileUrl <- file.path("UCI HAR Dataset","features.txt")

data_features <- read.table(fileUrl, header = FALSE)

#############
#load data test

#test/subject_test.txt
fileUrl <- file.path("UCI HAR Dataset","test","subject_test.txt")

data_test.subject <- read.table(fileUrl, header = FALSE)

#test/X_test.txt
fileUrl <- file.path("UCI HAR Dataset","test","X_test.txt")

data_test.x <- read.table(fileUrl, header = FALSE)

#test/y_test.txt
fileUrl <- file.path("UCI HAR Dataset","test","y_test.txt")

data_test.y <- read.table(fileUrl, header = FALSE)

#############
#load data train

#test/subject_test.txt
fileUrl <- file.path("UCI HAR Dataset","train","subject_train.txt")

data_train.subject <- read.table(fileUrl, header = FALSE)

#test/X_test.txt
fileUrl <- file.path("UCI HAR Dataset","train","X_train.txt")

data_train.x <- read.table(fileUrl, header = FALSE)

#test/y_test.txt
fileUrl <- file.path("UCI HAR Dataset","train","y_train.txt")

data_train.y <- read.table(fileUrl, header = FALSE)

rm(fileUrl)

######################
# verify that no data is missing (search for possible NA's)

sum(complete.cases(data_activityLabels)) == nrow(data_activityLabels)
sum(complete.cases(data_features)) == nrow(data_features)
sum(complete.cases(data_test.subject)) == nrow(data_test.subject)
sum(complete.cases(data_test.x)) == nrow(data_test.x)
sum(complete.cases(data_test.y)) == nrow(data_test.y)
sum(complete.cases(data_train.subject)) == nrow(data_train.subject)
sum(complete.cases(data_train.x)) == nrow(data_train.x)
sum(complete.cases(data_train.y)) == nrow(data_train.y)

#####
#start to merge together the data sets

#first combine the test data with columns: Subject, Activity, features...
combined.test <- cbind(data_test.y,data_test.x) #attached the y data to the x data (new first column)
combined.test$V1 <- data_activityLabels[,2][match(combined.test$V1,data_activityLabels[,1] )] #replace the y data with its labels
combined.test <- cbind(data_test.subject, combined.test) #now attach the subject column (new first column)
names(combined.test) <- c("SubjectID", "Activity", as.character(data_features[,2])) #add column headers

#next combine the training data with columns: Subject, Activity, features...
combined.train <- cbind(data_train.y,data_train.x) #attached the y data to the x data (new first column)
combined.train$V1 <- data_activityLabels[,2][match(combined.train$V1,data_activityLabels[,1] )] #replace the y data with its labels
combined.train <- cbind(data_train.subject, combined.train) #now attach the subject column (new first column)
names(combined.train) <- c("SubjectID", "Activity", as.character(data_features[,2])) #add column headers

#now combine both test and train into a single data set
combined.all <- rbind(combined.test,combined.train)

####
# clean up old data 
rm(combined.test, combined.train)

####
# now strip off the columns that are not needed (we are only looking for mean and stddev data)

#regex expression to find variable column names with either 'mean(' or 'std' as a substring
#tfColumns <- grepl("(^.*mean\\(.*$)|(^.*std.*$)", names(combined.all) ) #returns logical vector
#tfColumns[1:2] <- TRUE; #keep the first 2 columns (SubjectID and Activity)

#onlyMeanStd <- combined.all[,tfColumns]

#rm(tfColumns)

#reshape to final form
if (require("reshape2") == FALSE)
{
    install.packages("reshape2")
    library(reshape2)
}

#mdf <- melt(onlyMeanStd,id=c("SubjectID","Activity"))
mdf <- melt(combined.all,id=c("SubjectID","Activity"))

finaldf <- dcast(mdf, SubjectID+Activity~variable,mean)

#now need to cleanup the variable lables
# replace .BodyBody. with just .Body.
# change names trailing with () by removing the parenthesis
# generate new var names using Regex as shown below:

#now relabel (expland) the variable names
#leading 't' goes to 'Time' and leading 'f' goes to Frequency
#Body goes to Body
#Acc goes to Acceleration
#-mean()- goes to .Mean.
#-std()- goes to .StdDev.
#so, basically, remove the () and hyphens, expand names and separate with dot to make more readable (but long)
#add post fix Mean

newNames <- sub("^t","Time.",names(finaldf))
newNames <- sub("^f","Frequency.",newNames)
newNames <- sub("Acc",".Acceleration", newNames)
newNames <- sub("\\-mean\\()\\-",".Mean.", newNames)
newNames <- sub("\\-std\\()\\-",".StdDev.", newNames)
newNames <- sub("Gyro",".Gyro", newNames)
newNames <- sub("Jerk",".Jerk", newNames)
newNames <- sub("\\()","",newNames)
save <- newNames[1:2] #keep first two column names as-is (SubjectID and Activity)
newNames <- sub("$", " Mean", newNames)
newNames[1:2] <- save #keep first two column names as-is (SubjectID and Activity)

names(finaldf) <- make.names(newNames) #replace names (take one more final swing to clean up column names using make.names)

#nearZeroVar used to see if there exist zero data features
if (require("caret") == FALSE)
{
    install.packages("caret")
    library(caret)
}

nzv <- nearZeroVar(finaldf,saveMetrics=TRUE)
sumnzv = sum(nzv$nzv)

#now write out the tidy table to the current working directory
write.table(finaldf,"Tidy UCI HAR Dataset.txt", row.names=FALSE)

sessionInfo() #report out the current session info for this processing 