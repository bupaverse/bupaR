#' @title Get vector of activity labels
#' @description Retrieve a vector containing all unique activity labels
#' @param eventlog Eventlog
#' @export
activity_labels <- function(eventlog) {
	UseMethod("activity_labels")
}

#' @describeIn activity_labels Retrieve activity labels
#' @export
activity_labels.log <- function(eventlog) {
	eventlog %>%
		ungroup() %>%
		pull(!!activity_id_(eventlog)) %>%
		unique()
}
