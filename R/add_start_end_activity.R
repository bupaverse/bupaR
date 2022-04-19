#' Add artificial start/end activities to case
#'
#' @param log Log
#' @param eventlog Deprecated; please use \code{log} instead.
#' @param label Start/end activity label
#'
#' @name add_end_activity
#'
#' @importFrom forcats fct_expand
#' @export add_end_activity
add_end_activity <- function(log, label, eventlog = deprecated()) {
	UseMethod("add_end_activity")
}

#' @rdname add_end_activity
#' @export
add_start_activity <- function(log, label, eventlog = deprecated()) {
 	UseMethod("add_start_activity")
}

#' @describeIn add_end_activity Add end activity to event log
#' @export
add_end_activity.eventlog <- function(log, label = "End", eventlog = deprecated()) {

	eventlog <- lifecycle_warning_eventlog(log, eventlog)

	eventlog %>%
		group_by_case() %>%
		arrange(desc(!!timestamp_(eventlog))) %>%
		slice_events(1) %>%
		ungroup_eventlog() %>%
		mutate(!!timestamp_(eventlog) := !!timestamp_(eventlog) + 1,
			   !!activity_id_(eventlog) := factor(label, levels = c(as.character(activity_labels(eventlog)), label)),
			   !!activity_instance_id_(eventlog) := paste0(!!case_id_(eventlog), "-end")) -> end_states


	eventlog %>%
		mutate(!!activity_id_(eventlog) := fct_expand(!!activity_id_(eventlog), label)) %>%
	 	bind_rows(end_states) %>%
	 	re_map(mapping(eventlog))

}

#' @describeIn add_end_activity Add end activity to activity log
#' @export
#'
add_end_activity.activitylog <- function(log, label = "End", eventlog = deprecated()) {
	log <- lifecycle_warning_eventlog(log, eventlog)

	log %>%
		to_eventlog %>%
		add_end_activity.eventlog(label)

}


#' @describeIn add_end_activity Add end activity to grouped event log
#' @export
add_end_activity.grouped_log <- function(log, label = "End", eventlog = deprecated()) {

	log <- lifecycle_warning_eventlog(log, eventlog)

	apply_grouped_fun(log, add_end_activity, label, .ignore_groups = TRUE, .keep_groups = TRUE, .returns_log = TRUE)

}

#' @describeIn add_end_activity Add start activity to event log
#' @export
add_start_activity.eventlog <- function(log, label = "Start", eventlog = deprecated()) {

	eventlog <- lifecycle_warning_eventlog(log, eventlog)

	eventlog %>%
		group_by_case() %>%
		arrange(!!timestamp_(eventlog)) %>%
		slice_events.grouped_eventlog(1) %>%
		ungroup_eventlog() %>%
		mutate(!!timestamp_(eventlog) := !!timestamp_(eventlog) - 1,
			   !!activity_id_(eventlog) := factor(label, levels = c(as.character(activity_labels(eventlog)), label)),
			   !!activity_instance_id_(eventlog) := paste0(!!case_id_(eventlog), "-start")) -> end_states

	eventlog %>%
		mutate(!!activity_id_(eventlog) := fct_expand(!!activity_id_(eventlog), label)) %>%
		bind_rows(end_states) %>%
		re_map(mapping(eventlog))

}

#' @describeIn add_end_activity Add start activity to activity log
#' @export
#'
add_start_activity.activitylog <- function(log, label = "Start", eventlog = deprecated()) {
	log <- lifecycle_warning_eventlog(log, eventlog)

	log %>%
		to_eventlog %>%
		add_start_activity.eventlog(label)
}

#' @describeIn add_end_activity Add start activity to grouped event log
#' @export
add_start_activity.grouped_log <- function(log, label = "Start", eventlog = deprecated()) {

	log <- lifecycle_warning_eventlog(log, eventlog)

	apply_grouped_fun(log, add_start_activity, label, .ignore_groups = TRUE, .keep_groups = TRUE, .returns_log = TRUE)

}

