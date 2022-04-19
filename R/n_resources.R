#' @title n_resources
#'
#' @description Returns the number of resources in an event log
#' @param log \code{\link{log}}: Object of class \code{\link{log}}, \code{\link{eventlog}}, or \code{\link{activitylog}}.
#' @param eventlog Deprecated; please use \code{log} instead.
#' @family Eventlog count functions
#' @export

n_resources <- function(log, eventlog = deprecated()) {
	UseMethod("n_resources")
}


#' @describeIn n_resources Count number of resources in log
#' @export

n_resources.log <- function(log, eventlog = deprecated()) {
	log <- lifecycle_warning_eventlog(log, eventlog)

	length(unique(log[[resource_id(log)]]))
}

#' @describeIn n_resources Count number of resources in grouped log
#' @export
n_resources.grouped_log <- function(log, eventlog = deprecated()) {
	log <- lifecycle_warning_eventlog(log, eventlog)

	log %>%
		summarize(n_resources = n_distinct(.data[[resource_id(log)]])) %>%
		return()
}

