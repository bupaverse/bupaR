#' @title Case classifier
#' @description Get the case classifier of an object of class \code{eventlog}
#' @param x \code{\link{log}}: Object of class \code{\link{eventlog}} or \code{\link{activitylog}}, or \code{\link{mapping}}.
#'
#' @seealso \code{\link{eventlog}}, \code{\link{activitylog}}, \code{\link{mapping}}
#' @family Classifiers
#' @export case_id
case_id <- function(x){
	UseMethod("case_id")
}
#
#' @describeIn case_id Retrieve case identifier from eventlog
#' @export
case_id.eventlog <- function(x) {
	return(attr(x, "case_id"))
}
#' @describeIn case_id Retrieve case identifier from eventlog mapping
#' @export
case_id.eventlog_mapping <- function(x) {
	return(x$case_identifier)
}

#' @describeIn case_id Retrieve case identifier from activitylog
#' @export
case_id.activitylog <- function(x) {
	return(attr(x, "case_id"))
}

#' @describeIn case_id Retrieve case identifier from activitylog mapping
#' @export
case_id.activitylog_mapping <- function(x) {
	return(x$case_identifier)
}
