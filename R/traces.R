#' @title Traces
#'
#' @description \code{traces} computes the different activity sequences of an event log
#' together with their absolute and relative frequencies.
#' Activity sequences are based on the start timestamp of activities.
#'
#' @inheritParams act_collapse
#' @param ... Deprecated arguments
#'
#' @seealso \code{\link{cases}}, \code{\link{eventlog}}
#'


#' @export traces

traces <- function(log, ...) {
	UseMethod("traces")
}

#' @describeIn traces Construct traces list for eventlog
#' @export

traces.log <- function(log, ...){
	trace_list(log)
}

#' @describeIn traces Construct list of traces for grouped log
#' @export
#'
traces.grouped_log <- function(log, ...){
  log %>%
		apply_grouped_fun(traces, ...)
}



