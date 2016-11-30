#' @title n_activities
#'
#' @description Returns the number of activities in an event log
#'
#' @param eventlog The event log to be used. An object of class
#' \code{eventlog}.
#'
#' @export n_activities

n_activities <- function(eventlog){
	stop_eventlog(eventlog)
	colnames(eventlog)[colnames(eventlog) == activity_id(eventlog)] <- "event_classifier"
	return(length(unique(eventlog$event_classifier)))
}
