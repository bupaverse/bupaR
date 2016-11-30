#' @title n_activity_instances
#'
#' @description Returns the number of activity instances in an event log
#'
#' @param eventlog The event log to be used. An object of class
#' \code{eventlog}.
#'
#' @export n_activity_instances

n_activity_instances <- function(eventlog) {
	stop_eventlog(eventlog)
	colnames(eventlog)[colnames(eventlog) == activity_instance_id(eventlog)] <- "activity_instance_classifier"
	return(length(unique(eventlog$activity_instance_classifier)))
}
