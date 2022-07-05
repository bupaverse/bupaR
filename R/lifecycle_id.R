#' @title Life cycle classifier
#' @description Get the life_cycle_id of an object of class \code{eventlog}
#' @param x \code{\link{eventlog}}: Object of class \code{\link{eventlog}}, or \code{\link{mapping}}.
#' @family Classifiers
#' @export lifecycle_id
lifecycle_id <- function(x) {
	UseMethod("lifecycle_id")
}

#' @describeIn lifecycle_id Retrieve lifecycle identifier from eventlog
#' @export
lifecycle_id.eventlog <- function(x) {
	return(attr(x, "lifecycle_id"))
}
#' @describeIn lifecycle_id Retrieve lifecycle identifier from eventlog mapping
#' @export
lifecycle_id.eventlog_mapping <- function(x) {
	return(x$lifecycle_identifier)
}




