#' @title Group event log on resource id
#' @description Group an event log by resource identifier
#' @inheritParams group_by_case

#' @export group_by_resource
group_by_resource <- function(log) {
	UseMethod("group_by_resource")
}

#' @export
group_by_resource.eventlog <- function(log) {
	group_by(log, !!resource_id_(log))
}

#' @export
group_by_resource.activitylog <- function(log) {
	group_by(log, !!resource_id_(log))
}
