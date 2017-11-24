#' @title Cases
#'
#' @description Provides a fine-grained summary of an event log with characteristics for each case:  the number of events,
#' the number of activity types, the timespan, the trace, the duration and the first and last event type.
#'
#'
#' @param eventlog An eventlog object.
#' \code{eventlog}.
#'
#'
#' @export
cases <- function(eventlog) {
	UseMethod("cases")
}

#' @describeIn cases Constructy list of cases in an eventlog
#' @export
cases.eventlog <- function(eventlog){

	traces_per_case <- case_list(eventlog)
	durations <- durations(eventlog)


	summary <- eventlog %>%
		group_by(!!as.symbol(case_id(eventlog))) %>%
		summarize(trace_length = n_distinct(!!as.symbol(activity_instance_id(eventlog))),
				  number_of_activities = n_distinct(!!as.symbol(activity_id(eventlog))),
				  start_timestamp = min(!!as.symbol(timestamp(eventlog))),
				  complete_timestamp = max(!!as.symbol(timestamp(eventlog))))

	summary <- inner_join(summary, traces_per_case, by = case_id(eventlog))
	summary <- inner_join(summary, durations, by = case_id(eventlog))

	summary$first_activity <- NA_character_
	summary$last_activity  <- NA_character_

	for(i in 1:nrow(summary)){
		summary$first_activity[i] <- strsplit(summary$trace[i], split = ",")[[1]][1]
		summary$last_activity[i] <- strsplit(summary$trace[i], split = ",")[[1]][length(strsplit(summary$trace[i], split =",")[[1]])]
	}
	summary$first_activity <- as.factor(summary$first_activity)
	summary$last_activity <- as.factor(summary$last_activity)


	summary <- tbl_df(summary)
	return(summary)


}

#' @title Get vector of case labels
#' @description Retrieve a vector containing all unique case labels
#' @param eventlog Eventlog
#' @export
case_labels <- function(eventlog) {
	UseMethod("case_labels")
}

#' @describeIn case_labels Retrieve case labels from eventlog
#' @export
case_labels.eventlog <- function(eventlog) {
	eventlog %>%
		ungroup() %>%
		pull(!!case_id_(eventlog)) %>%
		unique()
}

