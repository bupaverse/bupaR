#' @title Mapping
#'
#' @description Prints the mapping of an event log object.
#'
#' @inheritParams act_collapse

#' @family Eventlog classifiers
#' @export
mapping <- function(log) {
	UseMethod("mapping")
}
#' @describeIn mapping Retrieve identifier mapping from eventlog
#' @export
mapping.eventlog <- function(log) {

	mapping <- list()

	mapping$case_identifier <- case_id(log)
	mapping$activity_identifier <- activity_id(log)
	mapping$activity_instance_identifier <- activity_instance_id(log)
	mapping$timestamp_identifier <- timestamp(log)
	mapping$lifecycle_identifier <- lifecycle_id(log)
	mapping$resource_identifier <- resource_id(log)

	# Optional groups info for grouped_eventlog
	mapping$groups <- dplyr::group_vars(log)

	class(mapping) <- c("eventlog_mapping", "log_mapping", class(mapping))

	return(mapping)
}

#' @describeIn mapping Retrieve identifier mapping from activitylog
#' @export
mapping.activitylog <- function(log) {

	mapping <- list()

	mapping$case_identifier <- case_id(log)
	mapping$activity_identifier <- activity_id(log)
	mapping$timestamps <- timestamps(log)
	mapping$resource_identifier <- resource_id(log)

	# Optional groups info for grouped_activitylog
	mapping$groups <- dplyr::group_vars(log)

	class(mapping) <- c("activitylog_mapping", "log_mapping", class(mapping))

	return(mapping)
}
