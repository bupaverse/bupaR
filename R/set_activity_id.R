
#' Set activity id of log
#'
#' @param log \code{\link{log}}: Object of class \code{\link{log}}, \code{\link{eventlog}}, or \code{\link{activitylog}}.
#' @param eventlog Deprecated; please use \code{log} instead.
#' @param activity_id New activity id
#'
#'
#' @export
#'
set_activity_id <- function(log, activity_id, eventlog = deprecated()) {
	UseMethod("set_activity_id")
}
#'
#' @describeIn set_activity_id Set activity id
#' @export
set_activity_id.default <- function(log, activity_id, eventlog = deprecated()) {
	log <- lifecycle_warning_eventlog(log, eventlog)
	set_id(log, "activity_id", activity_id)
}
