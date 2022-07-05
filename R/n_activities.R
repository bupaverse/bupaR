#' @title n_activities
#'
#' @description Returns the number of activities in an event log
#' @inheritParams act_collapse
#' @family Counters
#' @export

n_activities <- function(log, eventlog = deprecated()) {
	UseMethod("n_activities")
}

#' @describeIn n_activities Count the number of activities in a log
#' @export


n_activities.log <- function(log, eventlog = deprecated()){
	eventlog <- lifecycle_warning_eventlog(log, eventlog)

	length(unique(eventlog[[activity_id(eventlog)]]))
}

#' @describeIn n_activities Count the number of activities for a grouped  log
#' @export
n_activities.grouped_log <- function(log, eventlog = deprecated()) {
	eventlog <- lifecycle_warning_eventlog(log, eventlog)

	eventlog %>%
		summarize(n_activities = n_distinct(.data[[activity_id(eventlog)]]))
}


