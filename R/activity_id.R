#' @title Activity classifier
#' @description Get the activity classifier of an object of class \code{eventlog}.
#' @inheritParams case_id
#' @seealso \code{\link{eventlog}}, \code{\link{activitylog}}, \code{\link{mapping}}
#' @family Classifiers
#' @export activity_id
activity_id <- function(x) {
	UseMethod("activity_id")
}

#' @describeIn activity_id Retrieve activity identifier from log
#' @export
activity_id.default <- function(x){
	return(attr(x, "activity_id"))
}
#' @describeIn activity_id Retrieve activity identifier from  mapping
#' @export
activity_id.log_mapping <- function(x) {
	return(x$activity_identifier)
}

