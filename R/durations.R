#' @title Durations
#'
#' @description Computes the throughput times of each case.
#' Throughput time is defined as the interval between the start of the first event and the completion of the last event.
#'
#' @param log \code{\link{log}}: Object of class \code{\link{log}}, \code{\link{eventlog}}, or \code{\link{activitylog}}.
#' @param eventlog Deprecated; please use \code{log} instead.
#' @param units \code{\link{character}}: The time unit in which the throughput times should be reported. Should be one of the following values:
#' "auto" (default), "secs", "mins", "hours", "days", "weeks". See also the \code{units} argument of \code{\link{difftime}}.
#' @export durations
durations <- function(log, eventlog = deprecated(), units = c("auto", "secs", "mins", "hours", "days", "weeks")) {
	UseMethod("durations")
}

#' @export
durations.log <- function(log, eventlog = deprecated(), units = c("auto", "secs", "mins", "hours", "days", "weeks")) {

	log <- lifecycle_warning_eventlog(log, eventlog)
	units <- rlang::arg_match(units)

	durations <- durations_dt(log, units)

	data.table::setorderv(durations, cols = "duration", order = -1)

	durations %>%
		tibble::as_tibble()
}

#' @export
durations.eventlog <- function(log, eventlog = deprecated(), units = c("auto", "secs", "mins", "hours", "days", "weeks")) {

	log <- lifecycle_warning_eventlog(log, eventlog)
	units <- rlang::arg_match(units)

	durations.log(log, units = units)
}

#' @export
durations.activitylog <- function(log, eventlog = deprecated(), units = c("auto", "secs", "mins", "hours", "days", "weeks")) {

	log <- lifecycle_warning_eventlog(log, eventlog)
	units <- rlang::arg_match(units)

	durations.log(activitylog_to_eventlog(log), units = units)
}


durations_dt <- function(log, units = "auto") {

	dt <- data.table::data.table(log)
	by_case <- case_id(log)

	# Summarise data by case
	durations <- dt[, .(start = min(get(timestamp(log))),
	                    end = max(get(timestamp(log)))),
										by = by_case]

	# Calculate durations
	durations[, duration := difftime(end, start, units = units)][,
							":="(start = NULL,
							     end = NULL)]

	# Rename column 'duration' to 'duration_in_{units}'
	#data.table::setnames(durations, old = "duration", new = glue::glue("duration_in_{units}"))

	return(durations)
}