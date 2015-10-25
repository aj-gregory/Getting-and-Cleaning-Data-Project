run_analysis <- function() {
  library(plyr)
  #read in data
  x.train         <- read.table('UCI HAR Dataset/train/X_train.txt')
  y.train         <- read.table('UCI HAR Dataset/train/Y_train.txt')
  subject.train   <- read.table('UCI HAR Dataset/train/subject_train.txt')
  x.test          <- read.table('UCI HAR Dataset/test/X_test.txt')
  y.test          <- read.table('UCI HAR Dataset/test/Y_test.txt')
  subject.test    <- read.table('UCI HAR Dataset/test/subject_test.txt')
  activity_labels <- read.table('UCI HAR Dataset/activity_labels.txt')
  features        <- read.table('UCI HAR Dataset/features.txt')
  
  #add x.test to the end of x.train, y.test to the end of y.train, subject.test to the end of subject.train
  x.all <- rbind(x.train, x.test)
  y.all <- rbind(y.train, y.test)
  subject.all <- rbind(subject.train, subject.test)

  #rename x.all columns based on features list
  names(x.all) <- features[,2]
  #appropriately rename y.all and subject.all columns
  names(y.all) <- c('Activity')
  names(subject.all) <- ('Subject')

  #extract mean and standard deviation measurements based on column names
  x.all <- x.all[,grepl("mean\\(\\)|std\\(\\)", names(x.all))]

  #convert y.all into a factor of activity names and rename column
  y.all[,1] <- as.factor(y.all[,1])
  levels(y.all[,1]) <- activity_labels[,2]
  
  #combine x.all and y.all and subject.all
  complete.data <- cbind(subject.all, y.all, x.all)
  
  #get mean of each column per subject and activity
  ddply(complete.data, c('Subject', 'Activity'), numcolwise(mean))
}