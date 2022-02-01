
#' @title Group event log on resource and activity id
#' @description Group an event log by resource and activity identifier
#' @inheritParams group_by_case
#'
#' @export group_by_resource_activity
group_by_resource_activity <- function(.log) {
	UseMethod("group_by_resource_activity")
}

#' @export
group_by_resource_activity.eventlog <- function(.log) {
	group_by(.log, !!resource_id_(eventlog), !!activity_id_(.log))
}

#' @export
group_by_resource_activity.activitylog <- function(.log) {
	group_by(.log, !!resource_id_(eventlog), !!activity_id_(.log))
}
