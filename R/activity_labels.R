#' @title Get vector of activity labels
#' @description Retrieve a vector containing all unique activity labels
#' @param eventlog Eventlog
#' @export
activity_labels <- function(eventlog) {
	UseMethod("activity_labels")
}

#' @describeIn activity_labels Retrieve activity labels from eventlog
#' @export
activity_labels.eventlog <- function(eventlog) {
	eventlog %>%
		ungroup() %>%
		pull(!!activity_id_(eventlog)) %>%
		unique()
}
#' @export
activity_labels.activitylog <- function(eventlog) {
	eventlog %>%
		ungroup() %>%
		pull(!!activity_id_(eventlog)) %>%
		unique()
}
