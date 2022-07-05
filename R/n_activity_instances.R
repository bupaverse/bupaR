#' @title n_activity_instances
#'
#' @description Returns the number of activity instances in an event log
#'
#' @inheritParams act_collapse
#' @family Counters
#' @export

n_activity_instances <- function(log, eventlog = deprecated()) {
	UseMethod("n_activity_instances")
}


#' @describeIn  n_activity_instances eventlog
#' @export

n_activity_instances.eventlog <- function(log, eventlog = deprecated()) {

	eventlog <- lifecycle_warning_eventlog(log, eventlog)

	length(unique(eventlog[[activity_instance_id(eventlog)]]))
}

#' @describeIn n_activity_instances grouped_eventlog
#' @export
n_activity_instances.grouped_eventlog <- function(log, eventlog = deprecated()) {
	eventlog <- lifecycle_warning_eventlog(log, eventlog)

	eventlog %>%
		summarize(n_activity_instances = n_distinct(.data[[activity_instance_id(eventlog)]])) %>%
		return()
}

#' @describeIn  n_activity_instances eventlog
#' @export

n_activity_instances.activitylog <- function(log, eventlog = deprecated()) {
	log <- lifecycle_warning_eventlog(log, eventlog)

	nrow(log)
}

#' @describeIn n_activity_instances grouped_activitylog
#' @export
n_activity_instances.grouped_activitylog <- function(log, eventlog = deprecated()) {
	eventlog <- lifecycle_warning_eventlog(log, eventlog)

	eventlog %>%
		summarize(n_activity_instances = n())
}
