
#' Set resource id of log
#'
#' @inheritParams act_collapse
#' @param resource_id New resource id
#' @family Classifiers

#'
#' @export
#'
set_resource_id <- function(log, resource_id, eventlog = deprecated()) {
	UseMethod("set_resource_id")
}
#'
#' @describeIn set_resource_id Set resource id
#' @export
set_resource_id.default <- function(log, resource_id, eventlog = deprecated()) {
	log <- lifecycle_warning_eventlog(log, eventlog)
	set_id(log, "resource_id", resource_id)
}
