#' @title n_resources
#'
#' @description Returns the number of resources in an event log
#' @param eventlog The event log to be used. An object of class
#' \code{eventlog}.
#' @export n_resources

n_resources <- function(eventlog) {
	stop_eventlog(eventlog)
	colnames(eventlog)[colnames(eventlog) == resource_id(eventlog)] <- "resource_classifier"

	return(length(unique(eventlog$resource_classifier)))}
