#' @title last_n
#'
#' @description Select last n activity instances
#'
#' @param log \code{\link{log}}: Object of class \code{\link{log}}, \code{\link{eventlog}}, or \code{\link{activitylog}}.
#' @param eventlog Deprecated; please use \code{log} instead.
#' @param n \code{\link{integer}}: The number of activity instances to select.
#'
#' @export
last_n <- function(log,  n, eventlog = deprecated()) {
	UseMethod("last_n")
}

#' @describeIn last_n Select last n activity instances of an \code{\link{eventlog}}.
#' @export
last_n.eventlog <- function(log, n, eventlog = deprecated()) {

	log <- lifecycle_warning_eventlog(log, eventlog)

	log %>%
		arrange(desc(.data[[timestamp(log)]]), -.data[[".order"]]) %>%
		slice_activities(1:n) %>%
		arrange(.data[[timestamp(log)]], .data[[".order"]])
}

#' @describeIn last_n Select last n activity instances of an \code{\link{activitylog}}.
#' @export
last_n.activitylog <- function(log, n, eventlog = deprecated()) {

	log <- lifecycle_warning_eventlog(log, eventlog)

	log %>%
		rowwise() %>%
		mutate("min_timestamp" = min(c_across(lifecycle_ids(log)), na.rm = TRUE)) %>%
		ungroup() %>%
		re_map(mapping(log)) %>%
		arrange(desc(.data[["min_timestamp"]]), -.data[[".order"]]) %>%
		slice_activities(1:n) %>%
		arrange(.data[["min_timestamp"]], .data[[".order"]]) %>%
		select(-"min_timestamp")
}

#' @describeIn last_n Select last n activity instances of a \code{\link{grouped_log}}.
#' @export
last_n.grouped_log <- function(log, n, eventlog = deprecated()) {

	log <- lifecycle_warning_eventlog(log, eventlog)

	log %>%
		apply_grouped_fun(last_n, n, .keep_groups = TRUE, .returns_log = TRUE)
}

