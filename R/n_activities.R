#' @title n_activities
#'
#' @description Returns the number of activities in an event log
#'
#' @param eventlog The event log to be used. An object of class
#' \code{eventlog}.
#' @family Eventlog count functions
#' @export

n_activities <- function(eventlog) {
	UseMethod("n_activities")
}

#' @describeIn n_activities Count the number of activities in an event log
#' @export


n_activities.eventlog <- function(eventlog){
	colnames(eventlog)[colnames(eventlog) == activity_id(eventlog)] <- "event_classifier"
	return(length(unique(eventlog$event_classifier)))
}

#' @describeIn n_activities Count the number of activities for a grouped event log
#' @export
n_activities.grouped_eventlog <- function(eventlog) {
	eventlog %>%
		summarize(n_activities = n_distinct(!!as.symbol(activity_id(eventlog)))) %>%
		return()
}


