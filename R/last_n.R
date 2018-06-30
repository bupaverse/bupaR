
#' Select last n activity instances
#'
#' @param eventlog Eventlog object
#' @param n Integer value
#'
#' @export
last_n <- function(eventlog, n) {
	UseMethod("last_n")
}

#' @describeIn last_n Select first n activity instances in event log
#' @export
last_n.eventlog <- function(eventlog, n) {
	eventlog %>%
		last_n_raw( timestamp(eventlog), activity_instance_id(eventlog), n) %>%
		re_map(mapping(eventlog))
}

last_n_raw <- function(.data, .timestamp, .activity_instance_id,  n) {

	.order <- NULL
	.data %>%
		pull(!!sym(.activity_instance_id)) %>%
		unique %>%
		length -> n_instances

	.data %>%
		arrange(!!sym(.timestamp), .order) %>%
		slice_activities_raw(.activity_instance_id, (n_instances + 1 - n):n_instances)
}

#' @describeIn last_n Select first n activity instances  in grouped event log
#' @export
#'
last_n.grouped_eventlog <- function(eventlog, n) {
	groups <- groups(eventlog)
	mapping <- mapping(eventlog)

	aid <- activity_instance_id(eventlog)
	ts <- timestamp(eventlog)

	eventlog %>%
		nest() %>%
		mutate(data = map(data, last_n_raw, ts, aid, n)) %>%
		unnest() %>%
		re_map(mapping) %>%
		group_by_at(vars(one_of(paste(groups))))

}
