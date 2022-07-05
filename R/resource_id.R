#' @title Resource classifier
#' @description Get the resource classifier of an object of class \code{eventlog}.
#' @inheritParams case_id
#' @seealso \code{\link{eventlog}}, \code{\link{mapping}}
#' @family Classifiers
#' @export

resource_id <- function(x) {
	UseMethod("resource_id")
}

#' @describeIn resource_id Retrieve resource identifier from eventlog
#' @export
resource_id.eventlog <- function(x) {
	return(attr(x, "resource_id"))
}
#' @describeIn resource_id Retrieve resource identifier from eventlog mapping
#' @export
resource_id.eventlog_mapping <- function(x) {
	return(x$resource_identifier)
}
#' @describeIn resource_id Retrieve resource identifier from activitylog
#' @export
resource_id.activitylog <- function(x) {
	return(attr(x, "resource_id"))
}
#' @describeIn resource_id Retrieve resource identifier from activitylog mapping
#' @export
resource_id.activitylog_mapping <- function(x) {
	return(x$resource_identifier)
}
