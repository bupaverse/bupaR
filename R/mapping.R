#' @title Mapping
#'
#' @description Prints the mapping of an event log object.
#'
#' @param eventlog The event log to be used. An object of class
#' \code{eventlog}.
#' @family Eventlog classifiers
#' @export
mapping <- function(eventlog) {
	UseMethod("mapping")
}
#' @describeIn mapping Retrieve identifier mapping from eventlog
#' @export
mapping.eventlog <- function(eventlog) {
	mapping <- list()

	mapping$case_identifier <- case_id(eventlog)
	mapping$activity_identifier <- activity_id(eventlog)
	mapping$activity_instance_identifier <- activity_instance_id(eventlog)
	mapping$timestamp_identifier <- timestamp(eventlog)
	mapping$lifecycle_identifier <- lifecycle_id(eventlog)
	mapping$resource_identifier <- resource_id(eventlog)

	class(mapping) <- c("eventlog_mapping",class(mapping))

	return(mapping)
	}

