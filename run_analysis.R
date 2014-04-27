downloadfiles <- function() {
	## inspired by http://stackoverflow.com/a/3053883/344143
	t <- tempfile()
	download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", t, method="curl")
	unzip(t)
	unlink(t)
}