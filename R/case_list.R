

#' Case list
#'
#' Construct list of cases
#'
#' @param eventlog Eventlog object
#'
#' @export
#'
case_list <- function(eventlog) {
	UseMethod("case_list")
}

#' @describeIn case_list Return case list
#' @export


case_list.eventlog <- function(eventlog){
	min_order <- NULL

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

	cases %>%
		as_tibble
}
