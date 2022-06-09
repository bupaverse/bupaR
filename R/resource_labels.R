#' @title Get vector of resource labels
#' @description Retrieve a vector containing all unique resource labels
#' @param log Object of class eventlog or activitylog.
#' @param eventlog Deprecated; please use log instead.
#' @param ... Unused.
#' @export
resource_labels <- function(log, eventlog, ...) {
	UseMethod("resource_labels")
}

#' @describeIn resource_labels Retrieve resource labels from eventlog
#' @export
resource_labels.default <- function(log, eventlog, ...) {

	log <- lifecycle_warning_eventlog(log, eventlog)

	unique(log[[resource_id(log)]])
}
