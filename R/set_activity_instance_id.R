
#' Set activity instance id of log
#'
#' @param log \code{\link{log}}: Object of class \code{\link{eventlog}}.
#' @param eventlog Deprecated; please use \code{log} instead.
#' @param activity_instance_id New activity_instance id
#'
#'
#' @export
#'
set_activity_instance_id <- function(log, activity_instance_id, eventlog = deprecated()) {
	UseMethod("set_activity_instance_id")
}
#'
#' @describeIn set_activity_instance_id Set activity_instance_id of eventlog
#' @export
set_activity_instance_id.eventlog <- function(log, activity_instance_id, eventlog = deprecated()) {
	log <- lifecycle_warning_eventlog(log, eventlog)
	set_id(log, "activity_instance_id", activity_instance_id)
}
