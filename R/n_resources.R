#' @title n_resources
#'
#' @description Returns the number of resources in an event log
#' @inheritParams act_collapse
#' @family Counters
#' @export

n_resources <- function(log, eventlog = deprecated()) {
	UseMethod("n_resources")
}


#' @describeIn n_resources Count number of resources in log
#' @export

n_resources.log <- function(log, eventlog = deprecated()) {
	log <- lifecycle_warning_eventlog(log, eventlog)

	length(unique(log[[resource_id(log)]]))
}

#' @describeIn n_resources Count number of resources in grouped log
#' @export
n_resources.grouped_log <- function(log, eventlog = deprecated()) {
	log <- lifecycle_warning_eventlog(log, eventlog)

	log %>%
		summarize(n_resources = n_distinct(.data[[resource_id(log)]])) %>%
		return()
}

