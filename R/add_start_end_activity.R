#' Add artificial start/end activities to
#'
#' @param eventlog Event log
#' @param label Start/end activity label
#'
#' @name add_end_activity
#'
#' @importFrom forcats fct_expand
#' @export add_end_activity
add_end_activity <- function(eventlog, label) {
	UseMethod("add_end_activity")
}

#' @rdname add_end_activity
#' @export
add_start_activity <- function(eventlog, label) {
 	UseMethod("add_start_activity")
}

#' @describeIn add_end_activity Add end activity to event log
#' @export
add_end_activity.eventlog <- function(eventlog, label = "End") {

	eventlog %>%
		group_by_case() %>%
		arrange(desc(!!timestamp_(eventlog))) %>%
		slice_events.grouped_eventlog(1) %>%
		ungroup_eventlog() %>%
		mutate(!!timestamp_(eventlog) := !!timestamp_(eventlog) + 1,
			   !!activity_id_(eventlog) := factor(label, levels = c(as.character(activity_labels(eventlog)), label)),
			   !!activity_instance_id_(eventlog) := paste0(!!case_id_(eventlog), "-end")) -> end_states



	eventlog %>%
		mutate(!!activity_id_(eventlog) := fct_expand(!!activity_id_(eventlog), label)) %>%
	 	bind_rows(end_states) %>%
	 	re_map(mapping(eventlog))

}

#' @describeIn add_end_activity Add end activity to grouped event log
#' @export
add_end_activity.grouped_eventlog <- function(eventlog, label = "End") {

	groups <- groups(eventlog)
	mapping <- mapping(eventlog)
	eventlog %>%
		as.data.frame() %>%
		re_map(mapping) %>%
		add_end_activity.eventlog(label = label) %>%
		group_by_at(vars(one_of(paste(groups))))

}

#' @describeIn add_end_activity Add start activity to event log
#' @export
add_start_activity.eventlog <- function(eventlog, label = "Start") {

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

#' @describeIn add_end_activity Add start activity to grouped event log
#' @export
add_start_activity.grouped_eventlog <- function(eventlog, label = "Start") {

	groups <- groups(eventlog)
	mapping <- mapping(eventlog)
	eventlog %>%
		as.data.frame() %>%
		re_map(mapping) %>%
		add_start_activity.eventlog(label = label) %>%
		group_by_at(vars(one_of(paste(groups))))

}

