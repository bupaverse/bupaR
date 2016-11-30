#' @title n_events
#'
#' @description Returns the number of events in an event log
#' @param eventlog The event log to be used. An object of class
#' \code{eventlog}.
#' @export n_events

n_events <- function(eventlog) {
	stop_eventlog(eventlog)
	return(nrow(eventlog))
}
