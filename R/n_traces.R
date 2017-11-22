#' @title n_traces
#' @description Returns the number of traces in an event log
#' @param eventlog The event log to be used. An object of class
#' \code{eventlog}.
#' @family Eventlog count functions
#' @export n_traces

n_traces <- function(eventlog) {
	UseMethod("n_traces")
}

#' @describeIn n_traces Count number of traces for eventlog
#' @export

n_traces.eventlog <- function(eventlog) {
	return(nrow(trace_list(eventlog)))
}

#' @describeIn n_traces Count number of traces for grouped eventlog
#' @export
n_traces.grouped_eventlog <- function(eventlog) {
	mapping <- mapping(eventlog)
	eventlog %>%
		nest %>%
		mutate(n_traces = purrr::map_dbl(data, ~n_traces(re_map(.x, mapping)))) %>%
		select(-data) %>%
		return()
}

