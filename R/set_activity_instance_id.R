
#' Set activity instance id of log
#'
#' @inheritParams act_collapse
#' @param activity_instance_id New activity_instance id
#' @family Classifiers

#'
#' @export
#'
set_activity_instance_id <- function(log, activity_instance_id) {
	UseMethod("set_activity_instance_id")
}
#'
#' @describeIn set_activity_instance_id Set activity_instance_id of eventlog
#' @export
set_activity_instance_id.eventlog <- function(log, activity_instance_id) {
	set_id(log, "activity_instance_id", activity_instance_id)
}
