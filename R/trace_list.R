#' Trace list
#'
#' Construct trace list
#'
#' @inheritParams act_collapse
#' @param ... Other arguments. Currently not used.
#' @export
#'

trace_list <- function(log, ...){
	UseMethod("trace_list")
}

#' @describeIn trace_list Construct trace list for event log
#' @export

trace_list.eventlog <- function(log, ...){

	min_order <- NULL
	trace_id <- NULL

	if(nrow(log) == 0) {
		return(data.frame(trace = numeric(), absolute_frequency = numeric(), relative_frequency = numeric()))
	}


	eDT <- data.table::data.table(log)

	# this is roughly 3x faster than grouping and relies on unique taking the first distinct value
	# which corresponds to the event with the minimum timestamp and minimum .order
  	data.table::setorderv(eDT, cols = c(case_id(log), timestamp(log), ".order"))
	cases <- unique(eDT, by = c(case_id(log), activity_instance_id(log), activity_id(log)))

	cases <- cases[order(get(timestamp(log)), get(".order")),
				   list(trace = paste(get(activity_id(log)), collapse = ",")),
				   by = c(case_id(log))][,
				   	trace_id := as.numeric(factor(get("trace")))
				   ]

	.N <- NULL
	absolute_frequency <- NULL
	relative_frequency <- NULL

	traces <- cases[, .(absolute_frequency = .N), by = .(trace)]
	traces <- traces[order(absolute_frequency, decreasing = T)][
		, relative_frequency:=absolute_frequency/sum(absolute_frequency)]
	traces %>%
		as_tibble %>%
		arrange(-absolute_frequency)

}
#' @describeIn trace_list Construct trace list for activity log
#' @export
#'
trace_list.activitylog <- function(log, ...) {
  
	trace_id <- NULL
	absolute_frequency <- NULL
	relative_frequency <- NULL

	if(nrow(log) == 0) {
		return(data.frame(trace = numeric(), absolute_frequency = numeric(), relative_frequency = numeric()))
	}
	cases <- data.table::data.table(log)
	cases <- cases[order(get("start"), get("complete")),
				   list(trace = paste(get(activity_id(log)), collapse = ",")),
				   by = c(case_id(log))][,
				   						   trace_id := as.numeric(factor(get("trace")))
				   ]

	traces <- cases[, .(absolute_frequency = .N), by = .(trace)]
	traces <- traces[order(absolute_frequency, decreasing = T)][
		, relative_frequency:=absolute_frequency/sum(absolute_frequency)]
	traces %>%
		as_tibble %>%
		arrange(-absolute_frequency)

}

#' @describeIn trace_list Construct list of traces for grouped log
#' @export
#'
trace_list.grouped_log <- function(log, ...){

  log %>%
		apply_grouped_fun(trace_list, ...)
}
