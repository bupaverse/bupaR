#' @title n_events
#'
#' @description Returns the number of events in an event log.
#'
#' @param log \code{\link{log}}: Object of class \code{\link{log}}, \code{\link{eventlog}}, or \code{\link{activitylog}}.
#' @param eventlog Deprecated; please use \code{log} instead.
#'
#' @family Eventlog count functions
#' @export
n_events <- function(log, eventlog = deprecated()) {
	UseMethod("n_events")
}

#' @describeIn n_events Count number of events in an \code{\link{eventlog}}.
#' @export
n_events.eventlog <- function(log, eventlog = deprecated()) {

	log <- lifecycle_warning_eventlog(log, eventlog)

	return(nrow(log))
}

#' @describeIn n_events Count number of events in a \code{\link{grouped_eventlog}}.
#' @export
n_events.grouped_eventlog <- function(log, eventlog = deprecated()) {

	log <- lifecycle_warning_eventlog(log, eventlog)

	log %>%
		summarize(n_events = n()) %>%
		return()
}

#' @describeIn n_events Count number of events in an \code{\link{activitylog}}.
#' @export
n_events.activitylog <- function(log, eventlog = deprecated()) {
	log <- lifecycle_warning_eventlog(log, eventlog)

	sum(!is.na(select_ids(log, lifecycle_ids)))
}

#' @describeIn n_events Count number of events in an \code{\link{grouped_activitylog}}.
#' @export
n_events.grouped_activitylog <- function(log, eventlog = deprecated()) {

	log <- lifecycle_warning_eventlog(log, eventlog)

	log %>%
		summarize(n_events = sum(across(lifecycle_ids(.), ~length(which(!is.na(.x))))))
}