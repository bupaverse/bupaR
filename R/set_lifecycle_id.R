
#' Set lifecycle id of log
#'
#' @param log \code{\link{log}}: Object of class \code{\link{log}}, \code{\link{eventlog}}, or \code{\link{activitylog}}.
#' @param eventlog Deprecated; please use \code{log} instead.
#' @param lifecycle_id New lifecycle id. Can be multiple in case of activitylog
#'
#'
#' @export
#'
set_lifecycle_id <- function(log, lifecycle_id, eventlog = deprecated()) {
	UseMethod("set_lifecycle_id")
}
#'
#' @describeIn set_lifecycle_id Set lifecycle id
#' @export
set_lifecycle_id.default <- function(log, lifecycle_id, eventlog = deprecated()) {
	log <- lifecycle_warning_eventlog(log, eventlog)
	set_id(log, "lifecycle_id", lifecycle_id)
}
