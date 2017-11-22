#' @title n_activity_instances
#'
#' @description Returns the number of activity instances in an event log
#'
#' @param eventlog The event log to be used. An object of class
#' \code{eventlog}.
#' @family Eventlog count functions
#' @export

n_activity_instances <- function(eventlog) {
	UseMethod("n_activity_instances")
}


#' @rdname n_activity_instances
#' @method n_activity_instances eventlog
#' @export

n_activity_instances.eventlog <- function(eventlog) {
	colnames(eventlog)[colnames(eventlog) == activity_instance_id(eventlog)] <- "activity_instance_classifier"
	return(length(unique(eventlog$activity_instance_classifier)))
}

#' @rdname n_activity_instances
#' @method n_activity_instances grouped_eventlog
#' @export
n_activity_instances.grouped_eventlog <- function(eventlog) {
	eventlog %>%
		summarize(n_activity_instances = n_distinct(!!as.symbol(activity_instance_id(eventlog)))) %>%
		return()
}

