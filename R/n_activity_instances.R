#' @title n_activity_instances
#'
#' @description Returns the number of activity instances in an event log
#'
#' @inheritParams act_collapse
#' @family Counters
#' @export

n_activity_instances <- function(log) {
	UseMethod("n_activity_instances")
}


#' @describeIn  n_activity_instances eventlog
#' @export

n_activity_instances.eventlog <- function(log) {
	length(unique(log[[activity_instance_id(log)]]))
}

#' @describeIn n_activity_instances grouped_eventlog
#' @export
n_activity_instances.grouped_eventlog <- function(log) {
  log %>%
		summarize(n_activity_instances = n_distinct(.data[[activity_instance_id(log)]])) %>%
		return()
}

#' @describeIn  n_activity_instances activitylog
#' @export

n_activity_instances.activitylog <- function(log) {
	nrow(log)
}

#' @describeIn n_activity_instances grouped_activitylog
#' @export
n_activity_instances.grouped_activitylog <- function(log) {
  log %>%
		summarize(n_activity_instances = n())
}
