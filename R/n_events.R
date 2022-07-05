#' @title n_events
#'
#' @description Returns the number of events in an event log.
#'
#' @inheritParams act_collapse
#' @family Counters
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

	sum(!is.na(select_ids(log, timestamps)))
}

#' @describeIn n_events Count number of events in an \code{\link{grouped_activitylog}}.
#' @export
n_events.grouped_activitylog <- function(log, eventlog = deprecated()) {

	log <- lifecycle_warning_eventlog(log, eventlog)

	log %>%
		summarize(n_events = sum(across(timestamps(.), ~length(which(!is.na(.x))))))
}
