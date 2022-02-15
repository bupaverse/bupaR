#' @title Group event log on case id
#' @description Group an event log by case identifier
#' @param log Object of classes eventlog or activitylog


#' @export group_by_case
group_by_case <- function(log) {
	UseMethod("group_by_case")
}

#' @export
group_by_case.eventlog <- function(log) {
	group_by(log, !!case_id_(log))
}

#' @export
group_by_case.activitylog <- function(log) {
	group_by(log, !!case_id_(log))
}
