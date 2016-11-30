#' @title Re map
#'
#' @description Construct and eventlog using an existing mapping.
#'
#' @param eventlog The event log data to be used.
#'
#' @param eventlog_mapping An existing eventlog mapping created by the mapping function
#'
#' @export re_map

re_map <- function(eventlog, eventlog_mapping) {

	eventlog(eventlog,
			case_id = eventlog_mapping$case_identifier,
			activity_id = eventlog_mapping$activity_identifier,
			activity_instance_id = eventlog_mapping$activity_instance_identifier,
			lifecycle_id = eventlog_mapping$lifecycle_identifier,
			timestamp = eventlog_mapping$timestamp_identifier,
			resource_id = eventlog_mapping$resource_identifier) %>%
		return()

}
