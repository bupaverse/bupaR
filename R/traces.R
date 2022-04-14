#' @title Traces
#'
#' @description \code{traces} computes the different activity sequences of an event log
#' together with their absolute and relative frequencies.
#' Activity sequences are based on the start timestamp of activities.
#'
#' @param log \code{\link{log}}: Object of class \code{\link{log}}, \code{\link{eventlog}}, or \code{\link{activitylog}}.
#' @param eventlog Deprecated; please use \code{log} instead.
#'
#'
#' @param ... Deprecated arguments
#'
#' @seealso \code{\link{cases}}, \code{\link{eventlog}}
#'


#' @export traces

traces <- function(log, eventlog = deprecated(), ...) {
	UseMethod("traces")
}

#' @describeIn traces Construct traces list for eventlog
#' @export

traces.log <- function(log, eventlog = deprecated(), ...){
	eventlog <- lifecycle_warning_eventlog(log, eventlog)

	trace_list(eventlog)

}

#' @describeIn traces Construct list of traces for grouped log
#' @export
#'
traces.grouped_log <- function(log, eventlog = deprecated(), ...){
	eventlog <- lifecycle_warning_eventlog(log, eventlog)

	eventlog %>%
		apply_grouped_fun(traces, ...)
}



