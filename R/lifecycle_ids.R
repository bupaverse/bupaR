#' @title Life cycle classifiers
#' @description Get the life_cycle_id of an object of class \code{activitylog}
#' @param x An \code{eventlog} of \code{eventlog_mapping}
#' @family Eventlog classifiers
#' @export lifecycle_ids
lifecycle_ids <- function(x) {
	UseMethod("lifecycle_ids")
}

#' @describeIn lifecycle_ids Retrieve lifecycle identifier from eventlog
#' @export
lifecycle_ids.eventlog <- function(x) {
	warning(glue::glue("Object is eventlog. Lifecycle is stored in {lifecycle_id(x)} and timestamps in {timestamp(x)}"))
	return(attr(x, "lifecycle_id"))

}
#' @describeIn lifecycle_ids Retrieve lifecycle identifier from eventlog mapping
#' @export
lifecycle_ids.eventlog_mapping <- function(x) {
	warning(glue::glue("Object is eventlog. Lifecycle is stored in {lifecycle_id(x)} and timestamps in {timestamp(x)}"))
	return(x$lifecycle_identifier)
}

#' @describeIn lifecycle_ids Retrieve lifecycle identifier from activitylog
#' @export
lifecycle_ids.activitylog <- function(x) {
	return(attr(x, "lifecycle_ids"))
}

#' @describeIn lifecycle_ids Retrieve lifecycle identifier from activitylog mapping
#' @export
lifecycle_ids.activitylog_mapping <- function(x) {
	return(x$lifecycle_identifiers)
}


