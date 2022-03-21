#' @title Activities
#'
#' @description Returns a \code{tibble}  containing a list of all activity types in the event log, with their absolute and relative frequency
#'
#' @param log Object of class eventlog or activitylog.
#' @param eventlog Deprecated; please use log instead.
#'
#' @seealso \code{\link{activity_id}},\code{\link{activity_instance_id}}, \code{\link{eventlog}}
#'
#' @export activities
#'
activities <- function(log, eventlog) {
	UseMethod("activities")
}

#' @export

activities.eventlog <- function(log, eventlog = deprecated()) {

	if(lifecycle::is_present(eventlog)) {
		lifecycle::deprecate_warn("0.5.0", "activities(eventlog)", "activities(log)")
		log <- eventlog
	}
	log %>%
		group_by(.data[[activity_id(log)]]) %>%
		summarize(absolute_frequency = n_distinct(.data[[activity_instance_id(log)]])) %>%
		arrange(-.data$absolute_frequency) %>%
		mutate("relative_frequency" = (.data$absolute_frequency)/sum(.data$absolute_frequency))
}


#' @export

activities.activitylog <- function(log, eventlog = deprecated()) {

	if(lifecycle::is_present(eventlog)) {
		lifecycle::deprecate_warn("0.5.0", "activities(eventlog)", "activities(log)")
		log <- eventlog
	}
	log %>%
		group_by(.data[[activity_id(log)]]) %>%
		summarize("absolute_frequency" = n()) %>%
		arrange(.data$absolute_frequency) %>%
		mutate("relative_frequency" = .data$absolute_frequency/sum(.data$absolute_frequency))
}
#' @export
activities.grouped_log <- function(log, eventlog = deprecated()) {

	log <- lifecycle_warning_eventlog(log, eventlog)

	apply_grouped_fun(log, activities)
}








