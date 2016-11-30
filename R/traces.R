#' @title Traces
#'
#' @description \code{traces} computes the different activity sequences of an event log
#' together with their absolute and relative frequencies.
#' Activity sequences are based on the start timestamp of activities.
#'
#' @param eventlog The event log to be used. An object of class
#' \code{eventlog}.
#'
#' @param output_traces,output_cases Logicals specifying what should be
#' returned, a list of traces or a list of cases. If both are TRUE, a list of
#' both is returned.
#'
#' @seealso \code{\link{cases}}, \code{\link{eventlog}}
#' @examples
#'
#' data(example_log)
#' traces(example_log)
#'
#' @export traces

traces <- function(eventlog,
				   output_traces = TRUE,
				   output_cases = FALSE){
	colnames(eventlog)[colnames(eventlog) == case_id(eventlog)] <- "case_classifier"
	colnames(eventlog)[colnames(eventlog) == activity_id(eventlog)] <- "event_classifier"
	colnames(eventlog)[colnames(eventlog) == timestamp(eventlog)] <- "timestamp_classifier"
	colnames(eventlog)[colnames(eventlog) == activity_instance_id(eventlog)] <- "activity_instance_classifier"

	eDT <- data.table::as.data.table(eventlog)

	cases <- eDT[,
				 .(timestamp_classifier = min(timestamp_classifier)),
				 by = .(case_classifier, activity_instance_classifier,  event_classifier)]

	cases <- cases[order(timestamp_classifier), .(trace = paste(event_classifier, collapse = ",")),
				   by = .(case_classifier)]

	cases <- cases %>% mutate(trace_id = as.numeric(factor(trace)))

	#	cases <- eventlog %>%
	#		group_by(case_classifier, activity_instance_classifier, event_classifier) %>%
	#		summarize(timestamp_classifier = min(timestamp_classifier)) %>%
	#		group_by(case_classifier) %>%
	#		arrange(timestamp_classifier) %>%
	#		summarize(trace = paste(event_classifier, collapse = ",")) %>%
	#		mutate(trace_id = as.numeric(factor(trace)))


	colnames(cases)[colnames(cases) == "case_classifier"] <- case_id(eventlog)

	casesDT <- data.table(cases)
	cases <- cases %>% data.frame

	traces <- casesDT[, .(absolute_frequency = .N), by = .(trace, trace_id)]

	traces <- traces[order(absolute_frequency, decreasing = T),relative_frequency:=absolute_frequency/sum(absolute_frequency)]
	traces <- tbl_df(traces)
	#traces <- cases %>%
	#	group_by(trace, trace_id) %>%
	#	summarize(absolute_frequency = n()) %>%
	#	ungroup() %>%
	#	arrange(desc(absolute_frequency)) %>%
	#	mutate(relative_frequency = absolute_frequency/sum(absolute_frequency))

	if(output_traces == TRUE && output_cases == TRUE)
		return(list(traces,cases))
	else if(output_traces == TRUE && output_cases == FALSE)
		return(traces)
	else if(output_traces == FALSE && output_cases == TRUE)
		return(cases)
	else
		return(nrow(traces))

}


