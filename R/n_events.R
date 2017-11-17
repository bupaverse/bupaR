#' @title n_events
#'
#' @description Returns the number of events in an event log
#' @param eventlog The event log to be used. An object of class
#' \code{eventlog}.
#' @family Eventlog count functions
#' @export

n_events <- function(eventlog) {
	UseMethod("n_events")
}


#' @describeIn n_events Count number of resources in eventlog
#' @export

n_events.eventlog <- function(eventlog) {
	return(nrow(eventlog))
}

#' @describeIn n_events Count number of resource in eventlog
#' @export
n_events.grouped_eventlog <- function(eventlog) {
	eventlog %>%
		summarize(n_events = n()) %>%
		return()
}

