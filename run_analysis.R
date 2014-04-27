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

read_data <- function(group) {
	read.table(paste("UCI HAR Dataset/",group,"/X_",group,".txt", sep=""), sep="", col.names=get_features())
}