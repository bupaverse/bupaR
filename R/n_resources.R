#' @title n_resources
#'
#' @description Returns the number of resources in an event log
#' @param eventlog The event log to be used. An object of class
#' \code{eventlog}.
#' @family Eventlog count functions
#' @export

n_resources <- function(eventlog) {
	UseMethod("n_resources")
}


#' @describeIn n_resources Count number of resources in eventlog
#' @export

n_resources.eventlog <- function(eventlog) {
	colnames(eventlog)[colnames(eventlog) == resource_id(eventlog)] <- "resource_classifier"
	return(length(unique(eventlog$resource_classifier)))
}

#' @describeIn n_resources Count number of resources in grouped eventlog
#' @export
n_resources.grouped_eventlog <- function(eventlog) {
	eventlog %>%
		summarize(n_resources = n_distinct(!!as.symbol(resource_id(eventlog)))) %>%
		return()
}

