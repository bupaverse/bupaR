#' @title Timestamp classifier
#' @description Get the  timestamp classifier of an object of class \code{eventlog}
#' @param x Object of class \code{\link{eventlog}}, or \code{\link{mapping}}.
#' @seealso \code{\link{eventlog}}, \code{\link{mapping}}
#' @family Classifiers
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

#' @describeIn timestamp Retrieve timestamp identifier from activitylog
#' @export
timestamp.activitylog <- function(x){
	warning(glue::glue("Object is activity log. Timestamps are stored in {length(attr(x, 'lifecycle_ids'))} columns."))
	return(attr(x, "lifecycle_ids"))
}
#' @describeIn timestamp Retrieve timestamp identifier from activitylog mapping
#' @export
timestamp.activitylog_mapping <- function(x) {

	warning(glue::glue("Object is activity log. Timestamps are stored in {length(x$lifecycle_identifiers)} columns."))
	return(x$lifecycle_identifiers)
}
