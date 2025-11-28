#' @title Case list
#'
#' @description Construct list of cases
#'
#' @inheritParams act_collapse
#' @param .keep_trace_list Logical (default is \code{FALSE}): If \code{TRUE}, keeps the trace as a \code{list}.
#' If \code{FALSE}, only the concatenated string representation of the trace is kept.
#'
#' @importFrom stringi stri_join
#'
#' @export
case_list <- function(log, .keep_trace_list) {
	UseMethod("case_list")
}

#' @describeIn case_list Return case list
#' @export
case_list.eventlog <- function(log, .keep_trace_list = FALSE) {

	cases <- case_list_dt(log, .keep_trace_list)

	cases %>%
		as_tibble()
}
#' @describeIn case_list Return case list
#' @export
case_list.activitylog <- function(log, .keep_trace_list = FALSE) {
	case_list.eventlog(to_eventlog(log), .keep_trace_list = .keep_trace_list)
}



case_list_dt <- function (log, .keep_trace_list = FALSE) {

	trace_id <- NULL

	dt <- data.table::data.table(log)
	by_case <- case_id(log)

	# This is roughly 3x faster than grouping and relies on unique taking the first distinct value,
	# which corresponds to the event with the minimum timestamp and minimum .order
	data.table::setorderv(dt, cols = c(case_id(log), timestamp(log), ".order"))
	cases <- unique(dt, by = c(case_id(log), activity_instance_id(log), activity_id(log)))

	cases <- cases[order(get(timestamp(log)), get(".order")), .SD, by = by_case][,
		 						 .(trace_list = .(as.character(get(activity_id(log)))),
								   trace = stringi::stri_join(get(activity_id(log)), collapse = ",")), by = by_case][,
								 trace_id := as.numeric(factor(trace))]

	if (!.keep_trace_list) {
		# Remove the trace_list
		cases[, trace_list := NULL]
	}

	return(cases)
}
