#' @title n_cases
#'
#' @description Returns the number of cases in an event log.
#' @inheritParams act_collapse
#' @family Counters
#' @export
n_cases <- function(log, eventlog = deprecated()) {
	UseMethod("n_cases")
}

#' @describeIn n_cases Count number of cases in a \code{\link{log}}.
#' @export
n_cases.log <- function(log, eventlog = deprecated()) {

	log <- lifecycle_warning_eventlog(log, eventlog)

	n_distinct(log[[case_id(log)]])
}

#' @describeIn n_cases Count number of cases in a \code{\link{grouped_log}}.
#' @export
n_cases.grouped_log <- function(log, eventlog = deprecated()) {

	log <- lifecycle_warning_eventlog(log, eventlog)

	log %>%
		summarize(n_cases = n_distinct(.data[[case_id(.)]]))
}
