
#' Set lifecycle id of log
#'
#' @inheritParams act_collapse
#' @param lifecycle_id New lifecycle id. Can be multiple in case of activitylog
#' @family Classifiers

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
