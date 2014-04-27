downloadfiles <- function() {
	## inspired by http://stackoverflow.com/a/3053883/344143
	t <- tempfile()
	download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", t, method="curl")
	unzip(t)
	unlink(t)
}

f <- NULL
get_features <- function() {
	load_features <- function() {
		f <<- read.table("UCI HAR Dataset/features.txt", sep="", row.names=1, stringsAsFactors=FALSE)[,1]
	}
	if (is.null(f)) {
		message("loading features")
		load_features()
	}
	f
}

al <- NULL
get_labels <- function() {
	load_labels <- function() {
		al <<- read.table("UCI HAR Dataset/activity_labels.txt", sep="", row.names=1, stringsAsFactors=FALSE)[,1]
	}
	if (is.null(al)) {
		message("loading activity levels")
		load_labels()
	}
	al
}

read_data <- function(group) {
	X <- read.table(paste("UCI HAR Dataset/",group,"/X_",group,".txt", sep=""), sep="", col.names=get_features())
	activity <- as.factor(read.table(paste("UCI HAR Dataset/",group,"/y_",group,".txt", sep=""), sep="")[,1])
	levels(activity) <- get_labels()
	cbind(X, activity)
}

merged_data <- function() {
	do.call(rbind, lapply(c("test", "train"), read_data))
}

mean_and_std_colindices <- function() {
	colnames <- get_features()
	which(str_detect(colnames, "(mean|std)\\(\\)$"))
}
