#' @title Cases
#'
#' @description Provides a fine-grained summary of an event log with characteristics for each case: the number of events,
#' the number of activity types, the timespan, the trace, the duration, and the first and last event type.
#'
#' @param log Object of class \code{\link{eventlog}} or \code{\link{activitylog}}.
#' @param eventlog Deprecated; please use \code{log} instead.
#' @param ... Other arguments passed on to methods. See \code{\link{durations()}} for more options.
#'
#' @seealso \code{\link{case_list()}},\code{\link{durations()}}
#'
#' @export
cases <- function(log, eventlog, ...) {
	UseMethod("cases")
}

#' @describeIn cases Constructy list of cases in an eventlog
#' @export
cases.eventlog <- function(log, eventlog = deprecated(), ...){

	if(lifecycle::is_present(eventlog)) {
		lifecycle::deprecate_warn("0.5.0", "cases(eventlog)", "cases(log)")
		log <- eventlog
	}

	traces_per_case <- case_list_dt(log, .keep_trace_list = TRUE)
	durations <- data.table::data.table(durations(log, ...))
	#durations <- data.table::data.table(durations(log))

	dt <- data.table::data.table(log) # Unfortunately, we can't use setDT (which is much faster) as this transforms the log into a data.table by reference.

	by_case <- case_id(log)

	# Summarise data.
	#trace_length 					<- dt[, .(trace_length = data.table::uniqueN(get(activity_instance_id(log)))), by = by_case]
	#number_of_activities	<- dt[, .(number_of_activities = data.table::uniqueN(get(activity_id(log)))), by = by_case]
	#start_timestamp				<- dt[, .(start_timestamp = min(get(timestamp(log)))), by = by_case]
	#complete_timestamp		<- dt[, .(complete_timestamp = max(get(timestamp(log)))), by = by_case]

	summary <- dt[, .(trace_length = data.table::uniqueN(get(activity_instance_id(log))),
									  number_of_activities = data.table::uniqueN(get(activity_id(log))),
	                  start_timestamp = min(get(timestamp(log))),
                    complete_timestamp = max(get(timestamp(log)))),
									by = by_case]

	# Setting keys improves joining performance.
	#data.table::setkeyv(trace_length, by_case)
	#data.table::setkeyv(number_of_activities, by_case)
	#data.table::setkeyv(start_timestamp, by_case)
	#data.table::setkeyv(complete_timestamp, by_case)
	data.table::setkeyv(summary, by_case)
	data.table::setkeyv(traces_per_case, by_case)
	data.table::setkeyv(durations, by_case)

	# Inner join with summarised data, traces_per_case and durations.
	#summary <- trace_length[number_of_activities, on = by_case, nomatch = NA][
	#												start_timestamp, on = by_case, nomatch = NA][
	#												complete_timestamp, on = by_case, nomatch = NA][
	#												traces_per_case, on = by_case, nomatch = NA][
	#												durations, on = by_case, nomatch = NA]

	summary <- summary[traces_per_case, on = by_case, nomatch = NA][
										 durations, on = by_case, nomatch = NA]

	summary[, ":="(first_activity = as.factor(vapply(trace_list, "[", 1L, FUN.VALUE = character(1))),
	               last_activity = as.factor(vapply(trace_list, function (x) x[length(x)], FUN.VALUE = character(1))))][,
						trace_list := NULL]

	summary %>%
		as.data.frame()
}

#' @title Get vector of case labels
#' @description Retrieve a vector containing all unique case labels
#' @param log Object of class \code{\link{eventlog}} or \code{\link{activitylog}}.
#' @param eventlog Deprecated; please use \code{log} instead.
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

#' @describeIn case_labels Retrieve case labels from activitylog
#' @export
case_labels.activitylog <- function(eventlog) {
	eventlog %>%
		ungroup() %>%
		pull(!!case_id_(eventlog)) %>%
		unique()
}