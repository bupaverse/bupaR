
#' Set activity id of log
#'
#' @inheritParams act_collapse
#' @param activity_id New activity id
#' @family Classifiers

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
