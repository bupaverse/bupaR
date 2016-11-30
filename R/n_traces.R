#' @title n_traces
#' @description Returns the number of traces in an event log
#' @param eventlog The event log to be used. An object of class
#' \code{eventlog}.
#' @export n_traces

n_traces <- function(eventlog) {
	stop_eventlog(eventlog)
	return(nrow(traces_light(eventlog)))
}
