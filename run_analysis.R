## install.packages("reshape2")
library("reshape2")

main <- function (MaxRows = -1) {
  if (MaxRows <= 0)
    MaxRows <- -1
  
  ## Reading Train Files into Data frames
  subjects <- read.table("Data Science/UCI HAR Dataset/train/subject_train.txt",nrows=MaxRows)
  subjects <- rbind(subjects,read.table("Data Science/UCI HAR Dataset/test/subject_test.txt",nrows=MaxRows))
  
  names(subjects)<-"subjectID"
  
  X <- read.table("Data Science/UCI HAR Dataset/train/X_train.txt",sep="",nrows=MaxRows)
  X <- rbind(X,read.table("Data Science/UCI HAR Dataset/test/X_test.txt",sep="",nrows=MaxRows))
  names(X)<-1:ncol(X)
  
  y <- read.table("Data Science/UCI HAR Dataset/train/y_train.txt",nrows=MaxRows)
  y <- rbind(y,read.table("Data Science/UCI HAR Dataset/test/y_test.txt",nrows=MaxRows))
  names(y)<-"ActivityID"
  
  activity_labels <- read.table("Data Science/UCI HAR Dataset/activity_labels.txt")
  names(activity_labels)<-c("ActivityID","ActivityDesc")
  
  features <- read.table("Data Science/UCI HAR Dataset/features.txt")
  names(features)<-c("FeatureID","FeatureDesc")
  
  ## flag the feature as being a mean or std or not, useful for subsetting accordingly
  features$isMeanStd<- ifelse(grepl("-mean()",features$FeatureDesc),"MEAN",
                              ifelse(grepl("-std()",features$FeatureDesc),"STD",
                                     "NONE"))
  
  
  ## create an autonumber sequence and bind it to the dataframe
  #MasterData<-cbind("train",as.data.frame(1:nrow(X_train)))
  #names(MasterData)<-c("FileType","LineID")
  #MasterData<-cbind(MasterData, subject_train)
  MasterData<-cbind(subjects, y)
  MasterData<-cbind(MasterData, X)
  
  MasterMelt <- melt(MasterData, id = c("subjectID","ActivityID"), measure.vars=as.character(c(1:561)),variable.name="FeatureID",value.name="FeatureValue")
  mergedData <- merge(MasterMelt, activity_labels)
  mergedData <- merge(mergedData, features)
  return (subset(x=mergedData,isMeanStd!="NONE")[,c(1,6,2,5,3,4)])
}