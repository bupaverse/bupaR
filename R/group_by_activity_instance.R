

#' @title Group event log on activity instance id
#' @description Group an event log by activity instance identifier
#' @inheritParams group_by_case
#' @export group_by_activity_instance
group_by_activity_instance <- function(.log) {
	UseMethod("group_by_activity_instance")
}


#' @export
group_by_activity_instance.eventlog <- function(.log) {
	group_by(.log, !!activity_instance_id_(.log))
}

#' @export
group_by_activity_instance.activitylog <- function(.log) {
	group_by(.log, !!activity_instance_id_(.log))
}
