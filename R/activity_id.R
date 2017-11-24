#' @title Activity classifier
#' @description Get the activity classifier of an object of class \code{eventlog}.
#' @param x An \code{eventlog} of \code{eventlog_mapping}
#' @seealso \code{\link{eventlog}}, \code{\link{mapping}}
#' @family Eventlog classifiers
#' @export activity_id
activity_id <- function(x) {
	UseMethod("activity_id")
}

#' @describeIn activity_id Retrieve activity identifier from eventlog
#' @export
activity_id.eventlog <- function(x){
	return(attr(x, "activity_id"))
}
#' @describeIn activity_id Retrieve activity identifier from eventlog mapping
#' @export
activity_id.eventlog_mapping <- function(x) {
	return(x$activity_id)
}

