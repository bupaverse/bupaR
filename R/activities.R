#' @title Activities
#'
#' @description Returns a \code{tibble}  containing a list of all activity types in the event log, with their absolute and relative frequency
#'
#' @param log Object of class eventlog or activitylog.
#' @param eventlog Deprecated; please use log instead.
#' @param ... Unused.
#'
#' @seealso \code{\link{activity_id}},\code{\link{activity_instance_id}}, \code{\link{eventlog}}
#'
#' @export activities
#'
activities <- function(log, eventlog, ...) {
	UseMethod("activities")
}

#' @export

activities.eventlog <- function(log, eventlog = deprecated(), ...) {

	log <- lifecycle_warning_eventlog(log, eventlog)

	log %>%
		group_by(.data[[activity_id(log)]]) %>%
		summarize(absolute_frequency = n_distinct(.data[[activity_instance_id(log)]])) %>%
		arrange(-.data$absolute_frequency) %>%
		mutate("relative_frequency" = (.data$absolute_frequency)/sum(.data$absolute_frequency))
}
#' @describeIn activities Compute activity frequencies
#' @export

activities.activitylog <- function(log, eventlog = deprecated(), ...) {
	log <- lifecycle_warning_eventlog(log, eventlog)

	activities.eventlog(to_eventlog(log))
}
#' @describeIn activities Compute activity frequencies
#' @export
activities.grouped_log <- function(log, eventlog = deprecated(), ...) {
	log <- lifecycle_warning_eventlog(log, eventlog)

	apply_grouped_fun(log, activities)
}








