#' @title Timestamp classifier
#' @description Get the  timestamp classifier of an object of class \code{eventlog}
#' @param x An \code{eventlog} of \code{eventlog_mapping}
#' @seealso \code{\link{eventlog}}, \code{\link{mapping}}
#' @family Eventlog classifiers
#' @export
timestamp <- function(x) {
	UseMethod("timestamp")
}
#' @describeIn timestamp Retrieve timestamp identifier from eventlog
#' @export
timestamp.eventlog <- function(x){
	return(attr(x, "timestamp"))
}
#' @describeIn timestamp Retrieve timestamp identifier from eventlog mapping
#' @export
timestamp.eventlog_mapping <- function(x) {
	return(x$timestamp)
}
