#' @title n_cases
#'
#' @description  Returns the number of cases in an event log
#'
#' @param eventlog The event log to be used. An object of class
#' \code{eventlog}.
#'
#' @export n_cases

n_cases <- function(eventlog) {

	stop_eventlog(eventlog)

	colnames(eventlog)[colnames(eventlog) == case_id(eventlog)] <- "case_classifier"

	return(length(unique(eventlog$case_classifier)))
}
