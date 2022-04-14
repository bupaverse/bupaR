#' @title first_n
#'
#' @description Select first n activity instances.
#'
#' @param log \code{\link{log}}: Object of class \code{\link{log}}, \code{\link{eventlog}}, or \code{\link{activitylog}}.
#' @param eventlog Deprecated; please use \code{log} instead.
#' @param n \code{\link{integer}}: The number of activity instances to select.
#'
#' @export
first_n <- function(log, eventlog = deprecated(), n) {
	UseMethod("first_n")
}

#' @describeIn first_n Select first n activity instances of an \code{\link{eventlog}}.
#' @export
first_n.eventlog <- function(log, eventlog = deprecated(), n) {



	log <- lifecycle_warning_eventlog(log, eventlog)

	log %>%
		first_n_raw(timestamp(log), activity_instance_id(log), n) %>%
		re_map(mapping(log))
}

#' @describeIn first_n Select first n activity instances of a \code{\link{grouped_eventlog}}.
#' @export
first_n.grouped_eventlog <- function(log, eventlog = deprecated(), n) {

	log <- lifecycle_warning_eventlog(log, eventlog)

	.order <- NULL

	log %>%
		arrange(!!timestamp_(log), .order) %>%
		slice_activities(1:n)
}

#' @describeIn first_n Select first n activity instances of an \code{\link{activitylog}}.
#' @export
first_n.activitylog <- function(log, eventlog = deprecated(), n) {
	min_timestamp <- NULL
	.order = NULL

	log <- lifecycle_warning_eventlog(log, eventlog)

	log %>%
		mutate("min_timestamp" := rlang::invoke(pmin, dplyr::across(lifecycle_ids(.)), na.rm = TRUE)) %>%		# rlang::invoke is deprecated, should be replaced by rlang::exec
		dplyr::slice_min(order_by = .data[["min_timestamp"]] + .data[[".order"]], n = n) %>%
		dplyr::arrange(.data[["min_timestamp"]], .data[[".order"]]) %>%
		select(-.data[["min_timestamp"]]) %>%
		re_map(mapping(log))
}

#' @describeIn first_n Select first n activity instances of a \code{\link{grouped_activitylog}}.
#' @export
first_n.grouped_activitylog <- function(log, eventlog = deprecated(), n) {

	log <- lifecycle_warning_eventlog(log, eventlog)

	mapping <- mapping(log)

	log %>%
		first_n.activitylog(n = n) %>%
		dplyr::group_by_at(mapping$groups)
}


first_n_raw <- function(.data, .timestamp, .activity_instance_id,  n) {
	.order <- NULL
	.data %>%
		arrange(!!sym(.timestamp), .order) %>%
		slice_activities_raw(.activity_instance_id, 1:n)
}
