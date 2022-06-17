#' @title Timestamp classifiers
#' @description Get the  timestamps classifier of an object of class \code{activitylog}
#' @param x An \code{activitylog} or \code{activitylog_mapping}
#' @seealso \code{\link{activitylog}}, \code{\link{mapping}}
#' @family Activitylog classifiers
#' @export
timestamps <- function(x) {
	UseMethod("timestamps")
}
#' @describeIn timestamps Retrieve timestamp identifier from eventlog
#' @export
timestamps.eventlog <- function(x){
	warning("Eventlog: only one timestamp. Use timestamp() instead.")
	return(attr(x, "timestamp"))
}
#' @describeIn timestamps Retrieve timestamp identifier from eventlog mapping
#' @export
timestamps.eventlog_mapping <- function(x) {
	warning("Eventlog: only one timestamp. Use timestamp() instead.")
	return(x$timestamp)
}

#' @describeIn timestamps Retrieve timestamp identifier from activitylog
#' @export
timestamps.activitylog <- function(x){
	return(attr(x, "timestamps"))
}
#' @describeIn timestamps Retrieve timestamp identifier from activitylog mapping
#' @export
timestamps.activitylog_mapping <- function(x) {

	return(x$timestamps)
}
