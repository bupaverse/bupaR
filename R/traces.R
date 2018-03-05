#' @title Traces
#'
#' @description \code{traces} computes the different activity sequences of an event log
#' together with their absolute and relative frequencies.
#' Activity sequences are based on the start timestamp of activities.
#'
#' @param eventlog The event log to be used. An object of class
#' \code{eventlog}.
#'
#' @param ... Deprecated arguments
#'
#' @seealso \code{\link{cases}}, \code{\link{eventlog}}
#'


#' @export traces

traces <- function(eventlog,...) {
	UseMethod("traces")
}

#' @describeIn traces Construct traces list for eventlog
#' @export

traces.eventlog <- function(eventlog, ...){

	if (exists("output_cases")) {
		warning("argument output_cases is deprecated, please use function cases instead",
				call. = FALSE)
	}
	if (exists("output_traces")) {
		warning("argument output_traces is deprecated",
				call. = FALSE)
	}

	trace_list(eventlog)
#
# 	eDT <- data.table::as.data.table(eventlog)
# 	cases <- eDT[,
# 				 list("timestamp_classifier" = min(get(timestamp(eventlog))), "min_order" = min(.order)),
# 				 by = list("A" = get(case_id(eventlog)), "B" = get(activity_instance_id(eventlog)), "C" = get(activity_id(eventlog)))]
# 	cases <- cases[order(get("timestamp_classifier"), get("min_order")),
# 				   list(trace = paste(get("C"), collapse = ",")),
# 				   by = list("CASE" = get("A"))]
# 	cases <- cases %>% mutate(trace_id = as.numeric(factor(!!as.symbol("trace")))) %>%
# 		rename(!!as.symbol(case_id(eventlog)) := "CASE")
# 	#	cases <- eventlog %>%
# 	#		group_by(case_classifier, activity_instance_classifier, event_classifier) %>%
# 	#		summarize(timestamp_classifier = min(timestamp_classifier)) %>%
# 	#		group_by(case_classifier) %>%
# 	#		arrange(timestamp_classifier) %>%
# 	#		summarize(trace = paste(event_classifier, collapse = ",")) %>%
# 	#		mutate(trace_id = as.numeric(factor(trace)))
#
#
# 	.N <- NULL
# 	absolute_frequency <- NULL
# 	relative_frequency <- NULL
# 	trace_id <- NULL
#
# 	casesDT <- data.table(cases)
# 	cases <- cases %>% data.frame
# 	traces <- casesDT[, .(absolute_frequency = .N), by = .(trace, trace_id)]
# 	traces <- traces[order(absolute_frequency, decreasing = T),relative_frequency:=absolute_frequency/sum(absolute_frequency)]
# 	traces <- tbl_df(traces)
# 	#traces <- cases %>%
# 	#	group_by(trace, trace_id) %>%
# 	#	summarize(absolute_frequency = n()) %>%
# 	#	ungroup() %>%
# 	#	arrange(desc(absolute_frequency)) %>%
# 	#	mutate(relative_frequency = absolute_frequency/sum(absolute_frequency))
#
# 	return(traces)
}

#' @describeIn traces Construct list of traces for grouped eventlog
#' @export
#'
traces.grouped_eventlog <- function(eventlog, ...) {
	mapping <- mapping(eventlog)

	eventlog %>%
		nest() %>%
		mutate(data = map(data, re_map, mapping)) %>%
		mutate(data = map(data, traces)) %>%
		unnest() %>%
		return()
}



