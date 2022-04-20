#' @title n_cases
#'
#' @description Returns the number of cases in an event log.
#'
#' @param log \code{\link{log}}: Object of class \code{\link{log}}, \code{\link{eventlog}}, or \code{\link{activitylog}}.
#' @param eventlog Deprecated; please use \code{log} instead.
#'
#' @family Eventlog count functions
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