#' @title Group event log on activity id
#' @description Group an event log by activity identifier
#' @inheritParams group_by_case

#' @export group_by_activity
group_by_activity <- function(log) {
	UseMethod("group_by_activity")
}

#' @export
group_by_activity.eventlog <- function(log) {
	group_by(log, !!activity_id_(log))
}

#' @export
group_by_activity.activitylog <- function(log) {
	group_by(log, !!activity_id_(log))
}
