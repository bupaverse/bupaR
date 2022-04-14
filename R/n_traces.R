#' @title n_traces
#' @description Returns the number of traces in an event log
#' @param log \code{\link{log}}: Object of class \code{\link{log}}, \code{\link{eventlog}}, or \code{\link{activitylog}}.
#' @param eventlog Deprecated; please use \code{log} instead.
#'
#' @family Eventlog count functions
#' @export n_traces

n_traces <- function(log, eventlog = deprecated(), ...) {
	UseMethod("n_traces")
}

#' @describeIn n_traces Count number of traces for eventlog
#' @export

n_traces.log <- function(log, eventlog = deprecated(), ...) {
	eventlog <- lifecycle_warning_eventlog(log, eventlog)

	nrow(trace_list(eventlog))
}

#' @describeIn n_traces Count number of traces for grouped eventlog
#' @export
n_traces.grouped_log <- function(log, eventlog = deprecated(), ...) {
	eventlog <- lifecycle_warning_eventlog(log, eventlog)

	mapping <- mapping(eventlog)

	log %>%
		# remove grouping
		ungroup() %>%
		# group_by + nest (has option to keep group-vars in nested data)
		nest_by(across(mapping$groups), .keep = TRUE) %>%
		# nest_by returns rowwise data.frame, which we don't need
		ungroup() %>%
		# make sure data is event log
		mutate(data = map(data, re_map, mapping)) %>%
		# compute output of function, taking over any arguments
		mutate(n_traces = map_dbl(data, n_traces)) %>%
		select(-data)
}

