#' @title last_n
#'
#' @description Select last n activity instances
#'
#' @param log \code{\link{log}}: Object of class \code{\link{log}}, \code{\link{eventlog}}, or \code{\link{activitylog}}.
#' @param eventlog Deprecated; please use \code{log} instead.
#' @param n \code{\link{integer}}: The number of activity instances to select.
#'
#' @export
last_n <- function(log, eventlog = deprecated(), n) {
	UseMethod("last_n")
}

#' @describeIn last_n Select last n activity instances of an \code{\link{eventlog}}.
#' @export
last_n.eventlog <- function(log, eventlog = deprecated(), n) {

	log <- lifecycle_warning_eventlog(log, eventlog)

	log %>%
		last_n_raw(timestamp(log), activity_instance_id(log), n) %>%
		re_map(mapping(log))
}

#' @describeIn last_n Select last n activity instances of a \code{\link{grouped_eventlog}}.
#' @export
last_n.grouped_eventlog <- function(log, eventlog = deprecated(), n) {

	log <- lifecycle_warning_eventlog(log, eventlog)

	mapping <- mapping(log)

	aid <- activity_instance_id(log)
	ts <- timestamp(log)

	log %>%
		nest() %>%
		mutate(data = map(data, last_n_raw, ts, aid, n)) %>%
		unnest() %>%
		re_map(mapping) %>%
		group_by_at(mapping$groups)

}

#' @describeIn last_n Select last n activity instances of an \code{\link{activitylog}}.
#' @export
last_n.activitylog <- function(log, eventlog = deprecated(), n) {

	log <- lifecycle_warning_eventlog(log, eventlog)

	log %>%
		mutate("min_timestamp" := rlang::invoke(pmin, dplyr::across(lifecycle_ids(.)), na.rm = TRUE)) %>%		# rlang::invoke is deprecated, should be replaced by rlang::exec
		dplyr::slice_max(order_by = .data[["min_timestamp"]] + .data[[".order"]], n = n) %>%
		dplyr::arrange(.data[["min_timestamp"]], .data[[".order"]]) %>%
		select(-.data[["min_timestamp"]]) %>%
		re_map(mapping(log))
}

#' @describeIn last_n Select last n activity instances of a \code{\link{grouped_activitylog}}.
#' @export
last_n.grouped_activitylog <- function(log, eventlog = deprecated(), n) {

	log <- lifecycle_warning_eventlog(log, eventlog)

	mapping <- mapping(log)

	log %>%
		last_n.activitylog(n = n) %>%
		dplyr::group_by_at(mapping$groups)
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