#' @title n_cases
#'
#' @description  Returns the number of cases in an event log
#'
#' @param eventlog The event log to be used. An object of class
#' \code{eventlog}.
#' @family Eventlog count functions
#' @export

n_cases <- function(eventlog) {
	UseMethod("n_cases")
}


#' @describeIn n_cases Count number of cases for eventlog
#' @export
n_cases.eventlog <- function(eventlog) {
	return(length(unique(eventlog[[case_id(eventlog)]])))
}

#' @describeIn n_cases Count number of cases for grouped eventlog
#' @export
n_cases.grouped_eventlog <- function(eventlog) {
	eventlog %>%
		summarize(n_cases = n_distinct(!!as.symbol(case_id(eventlog)))) %>%
		return()
}

