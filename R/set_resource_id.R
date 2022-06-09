
#' Set resource id of log
#'
#' @param log \code{\link{log}}: Object of class \code{\link{log}}, \code{\link{eventlog}}, or \code{\link{activitylog}}.
#' @param eventlog Deprecated; please use \code{log} instead.
#' @param resource_id New resource id
#'
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
