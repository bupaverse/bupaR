#' Trace list
#'
#' Construct trace list
#'
#' @param eventlog Eventlog object
#'
#' @export
#'

trace_list <- function(eventlog){
	UseMethod("trace_list")
}

#' @describeIn trace_list Construct trace list for event log
#' @export

trace_list.eventlog <- function(eventlog){
	min_order <- NULL
	trace_id <- NULL

	if(nrow(eventlog) == 0) {
		return(data.frame(trace = numeric(), absolute_frequency = numeric(), relative_frequency = numeric()))
	}


	eDT <- data.table::data.table(eventlog)

	# this is roughly 3x faster than grouping and relies on unique taking the first distinct value
	# which corresponds to the event with the minimum timestamp and minimum .order
  	data.table::setorderv(eDT, cols = c(case_id(eventlog), timestamp(eventlog), ".order"))
	cases <- unique(eDT, by = c(case_id(eventlog), activity_instance_id(eventlog), activity_id(eventlog)))

	cases <- cases[order(get(timestamp(eventlog)), get(".order")),
				   list(trace = paste(get(activity_id(eventlog)), collapse = ",")),
				   by = c(case_id(eventlog))][,
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
trace_list.activitylog <- function(eventlog) {
	if(nrow(eventlog) == 0) {
		return(data.frame(trace = numeric(), absolute_frequency = numeric(), relative_frequency = numeric()))
	}
	cases <- data.table::data.table(eventlog)
	cases <- cases[order(get("start"), get("complete")),
				   list(trace = paste(get(activity_id(eventlog)), collapse = ",")),
				   by = c(case_id(eventlog))][,
				   						   trace_id := as.numeric(factor(get("trace")))
				   ]

	traces <- cases[, .(absolute_frequency = .N), by = .(trace)]
	traces <- traces[order(absolute_frequency, decreasing = T)][
		, relative_frequency:=absolute_frequency/sum(absolute_frequency)]
	traces %>%
		as_tibble %>%
		arrange(-absolute_frequency)

}

