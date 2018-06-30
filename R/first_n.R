
#' Select first n activity instances
#'
#' @param eventlog Eventlog object
#' @param n Integer value
#'
#' @export
first_n <- function(eventlog, n) {
	UseMethod("first_n")
}

#' @describeIn first_n Select first n activity instances in event log
#' @export
first_n.eventlog <- function(eventlog, n) {
	eventlog %>%
		first_n_raw( timestamp(eventlog), activity_instance_id(eventlog), n) %>%
		re_map(mapping(eventlog))
}

first_n_raw <- function(.data, .timestamp, .activity_instance_id,  n) {
	.order <- NULL
	.data %>%
		arrange(!!sym(.timestamp), .order) %>%
		slice_activities_raw(.activity_instance_id, 1:n)
}

#' @describeIn first_n Select first n activity instances  in grouped event log
#' @export
#'
first_n.grouped_eventlog <- function(eventlog, n) {
	.order <- NULL

	groups <- groups(eventlog)
	mapping <- mapping(eventlog)
	eventlog %>%
		arrange(!!timestamp_(eventlog), .order) %>%
		slice_activities(1:n)

}
