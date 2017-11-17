#' @title Resource classifier
#' @description Get the resource classifier of an object of class \code{eventlog}.
#' @param x An \code{eventlog} of \code{eventlog_mapping}
#' @seealso \code{\link{eventlog}}, \code{\link{mapping}}
#' @family Eventlog classifiers
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
	return(x$resource_id)
}
