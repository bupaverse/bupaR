#' @title Cases
#'
#' @description Provides a fine-grained summary of an event log with characteristics for each case: the number of events,
#' the number of activity types, the timespan, the trace, the duration, and the first and last event type.
#'
#' @inheritParams act_collapse
#' @param ... Other (optional) arguments passed on to methods. See \code{\link{durations}} for more options.
#'
#' @seealso \code{\link{case_list}},\code{\link{durations}}
#'
#' @export
cases <- function(log, ..., eventlog = deprecated()) {
	UseMethod("cases")
}

#' @describeIn cases Construct list of cases in a \code{\link{log}}.
#' @export
cases.log <- function(log, ..., eventlog = deprecated()) {

	log <- lifecycle_warning_eventlog(log, eventlog)

	traces_per_case <- case_list_dt(log, .keep_trace_list = TRUE)
	durations <- durations_dt(log, ...)
	#durations <- data.table::data.table(durations(log))

	dt <- data.table::data.table(log) # Unfortunately, we can't use setDT (which is much faster) as this transforms the log into a data.table by reference.

	by_case <- case_id(log)

	# Summarise data by case.
	summary <- dt[, .(trace_length = data.table::uniqueN(get(activity_instance_id(log))),
									  number_of_activities = data.table::uniqueN(get(activity_id(log))),
	                  start_timestamp = min(get(timestamp(log))),
                    complete_timestamp = max(get(timestamp(log)))),
									by = by_case]

	# Setting keys improves joining performance.
	data.table::setkeyv(summary, by_case)
	data.table::setkeyv(traces_per_case, by_case)
	data.table::setkeyv(durations, by_case)

	# Inner join with summarised data, traces_per_case and durations.
	summary <- summary[traces_per_case, on = by_case, nomatch = NA][
										 durations, on = by_case, nomatch = NA]

	# Get first and last activity from trace_list, and remove trace_list
	summary[, ":="(first_activity = as.factor(vapply(trace_list, "[", 1L, FUN.VALUE = character(1))),
	               last_activity = as.factor(vapply(trace_list, function (x) x[length(x)], FUN.VALUE = character(1))))][,
						trace_list := NULL]

	summary %>%
		as.data.frame() %>%
		as_tibble()
}

#' @describeIn cases Construct list of cases in an \code{\link{eventlog}}.
#' @export
cases.eventlog <- function(log, ..., eventlog = deprecated()) {

	log <- lifecycle_warning_eventlog(log, eventlog)

	cases.log(log)
}

#' @describeIn cases Construct list of cases in a \code{\link{activitylog}}.
#' @export
cases.activitylog <- function(log, ..., eventlog = deprecated()) {

	log <- lifecycle_warning_eventlog(log, eventlog)

	cases.log(to_eventlog(log))
}
