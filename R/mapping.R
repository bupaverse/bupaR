#' @title Mapping
#'
#' @description Prints the mapping of an event log object.
#'
#' @inheritParams act_collapse

#' @family Eventlog classifiers
#' @export
mapping <- function(log, eventlog = deprecated()) {
	UseMethod("mapping")
}
#' @describeIn mapping Retrieve identifier mapping from eventlog
#' @export
mapping.eventlog <- function(log, eventlog = deprecated()) {

	eventlog <- lifecycle_warning_eventlog(log, eventlog)

	mapping <- list()

	mapping$case_identifier <- case_id(eventlog)
	mapping$activity_identifier <- activity_id(eventlog)
	mapping$activity_instance_identifier <- activity_instance_id(eventlog)
	mapping$timestamp_identifier <- timestamp(eventlog)
	mapping$lifecycle_identifier <- lifecycle_id(eventlog)
	mapping$resource_identifier <- resource_id(eventlog)

	# Optional groups info for grouped_eventlog
	mapping$groups <- dplyr::group_vars(eventlog)

	class(mapping) <- c("eventlog_mapping", "log_mapping", class(mapping))

	return(mapping)
}

#' @describeIn mapping Retrieve identifier mapping from activitylog
#' @export
mapping.activitylog <- function(log, eventlog = deprecated()) {

	eventlog <- lifecycle_warning_eventlog(log, eventlog)

	mapping <- list()

	mapping$case_identifier <- case_id(eventlog)
	mapping$activity_identifier <- activity_id(eventlog)
	mapping$timestamps <- timestamps(eventlog)
	mapping$resource_identifier <- resource_id(eventlog)

	# Optional groups info for grouped_activitylog
	mapping$groups <- dplyr::group_vars(eventlog)

	class(mapping) <- c("activitylog_mapping", "log_mapping", class(mapping))

	return(mapping)
}
