#' @title first_n
#'
#' @description Select first n activity instances.
#'
#' @param log \code{\link{log}}: Object of class \code{\link{log}}, \code{\link{eventlog}}, or \code{\link{activitylog}}.
#' @param eventlog Deprecated; please use \code{log} instead.
#' @param n \code{\link{integer}}: The number of activity instances to select.
#'
#' @export
first_n <- function(log, n, eventlog = deprecated()) {
	UseMethod("first_n")
}

#' @describeIn first_n Select first n activity instances of an \code{\link{eventlog}}.
#' @export
first_n.eventlog <- function(log, n, eventlog = deprecated()) {

	log <- lifecycle_warning_eventlog(log, eventlog)

	log %>%
		arrange(.data[[timestamp(log)]], .order) %>%
		slice_activities(1:n)
}

#' @describeIn first_n Select first n activity instances of an \code{\link{activitylog}}.
#' @export
first_n.activitylog <- function(log, n, eventlog = deprecated()) {

	log <- lifecycle_warning_eventlog(log, eventlog)

	log %>%
		rowwise() %>%
		mutate("min_timestamp" = min(c_across(lifecycle_ids(log)), na.rm = TRUE)) %>%
		re_map(mapping(log)) %>%
		arrange(min_timestamp, .order) %>%
		slice_activities(1:n) %>%
		select(-min_timestamp)
}

#' @describeIn first_n Select first n activity instances of a \code{\link{grouped_log}}.
#' @export
first_n.grouped_log <- function(log, n, eventlog = deprecated()) {

	log <- lifecycle_warning_eventlog(log, eventlog)

	log %>%
		apply_grouped_fun(first_n, n, .keep_groups = TRUE, .returns_log = TRUE)
}



