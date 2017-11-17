#' @title Case classifier
#' @description Get the case classifier of an object of class \code{eventlog}
#' @param x An \code{eventlog} of \code{eventlog_mapping}
#'
#' @seealso \code{\link{eventlog}}, \code{\link{mapping}}
#' @family Eventlog classifiers
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
	return(x$case_id)
}
