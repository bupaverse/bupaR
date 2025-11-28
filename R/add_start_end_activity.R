#' @title Add Artificial Start/End Activities
#'
#' @description Adds an artificial start or end activity to each case with the specified `label`.
#'
#' @param label [`character`]: Start (default `"Start"`) or end (default `"End"`) activity label. This must be an activity
#' label that is not already present in `log`.
#'
#' @inheritParams act_collapse
#'
#' @export add_end_activity
add_end_activity <- function(log, label = "End") {
	UseMethod("add_end_activity")
}

#' @rdname add_end_activity
#' @export add_start_activity
add_start_activity <- function(log, label = "Start") {
 	UseMethod("add_start_activity")
}

#' @describeIn add_end_activity Adds end activity to an [`eventlog`].
#' @export
add_end_activity.eventlog <- function(log, label = "End") {

	add_start_end_activity_check_label(log, label)

	log %>%
		group_by_case() %>%
		arrange(desc(.data[[timestamp(log)]])) %>%
		slice_events(1) %>%
		ungroup_eventlog() %>%
		mutate(!!timestamp(log) := .data[[timestamp(log)]] + 1,
			     !!activity_id(log) := factor(label, levels = c(as.character(activity_labels(log)), label)),
			     !!activity_instance_id(log) := stri_c(.data[[case_id(log)]], "end", sep = "-")) -> end_states

	return(add_start_end_activity_bind_logs(log, end_states, label))
}

#' @describeIn add_end_activity Adds end activity to an [`activitylog`].
#' @export
add_end_activity.activitylog <- function(log, label = "End") {
  last_timestamp <- NULL
	add_start_end_activity_check_label(log, label)
	log %>%
		mutate("last_timestamp" = pmax(!!!syms(timestamps(log)), na.rm = TRUE)) %>%
		group_by_case() %>%
		arrange(desc(last_timestamp)) %>%
		slice_activities(1) %>%
		ungroup_eventlog() %>%
		mutate("complete" := last_timestamp + 1,
					 !!activity_id(log) := factor(label, levels = c(as.character(activity_labels(log)), label))) %>%
		select(-last_timestamp) -> end_states

	return(add_start_end_activity_bind_logs(log, end_states, label))
}

#' @describeIn add_end_activity Adds end activity to a [`grouped_log`].
#' @export
add_end_activity.grouped_log <- function(log, label = "End") {
	apply_grouped_fun(log, add_end_activity, label, .ignore_groups = TRUE, .keep_groups = TRUE, .returns_log = TRUE)
}

#' @describeIn add_end_activity Adds start activity to an [`eventlog`].
#' @export
add_start_activity.eventlog <- function(log, label = "Start") {

	add_start_end_activity_check_label(log, label)

	log %>%
		group_by_case() %>%
		arrange(.data[[timestamp(log)]]) %>%
		slice_events(1) %>%
		ungroup_eventlog() %>%
	  mutate(across(timestamp(log), ~.x-1)) %>%
		mutate(!!activity_id(log) := factor(label, levels = c(as.character(activity_labels(log)), label)),
					 !!activity_instance_id(log) := stri_c(.data[[case_id(log)]], "start", sep = "-")) -> start_states

	return(add_start_end_activity_bind_logs(log, start_states, label))
}

#' @describeIn add_end_activity Adds start activity to an [`activitylog`].
#' @export
add_start_activity.activitylog <- function(log, label = "Start") {
	add_start_end_activity_check_label(log, label)
  first_timestamp <- NULL
	log %>%
		mutate("first_timestamp" = pmin(!!!syms(timestamps(log)), na.rm = TRUE)) %>%
		group_by_case() %>%
		arrange(first_timestamp) %>%
		slice_activities(1) %>%
		ungroup_eventlog() %>%
		mutate("start" := first_timestamp - 1,
					 !!activity_id(log) := factor(label, levels = c(as.character(activity_labels(log)), label))) %>%
		select(-first_timestamp) -> start_states

	return(add_start_end_activity_bind_logs(log, start_states, label))
}

#' @describeIn add_end_activity Adds start activity to a [`grouped_log`].
#' @export
add_start_activity.grouped_log <- function(log, label = "Start") {
	apply_grouped_fun(log, add_start_activity, label, .ignore_groups = TRUE, .keep_groups = TRUE, .returns_log = TRUE)
}


add_start_end_activity_check_label <- function(log, label, arg = caller_arg(label), call = caller_env()) {

	if (!is_character(label, n = 1L)) {
		cli_abort(c("{.arg {arg}} must be a {.cls {class({arg})}}.",
								"x" = "You supplied a {.cls {class(label)}}: {.val {label}}"),
							call = call)
	}

	if (label %in% activity_labels(log)) {
		cli_abort(c("Invalid {.arg {arg}}.",
								"x" = "Activity {.val {label}} is already present in log. Please use another label."),
							call = call)
	}
}

add_start_end_activity_bind_logs <- function(log1, log2, label) {

	# Merge the two logs and make sure the eventlog mapping is retained.
	log1 %>%
		mutate(!!activity_id(log1) := fct_expand(.data[[activity_id(log1)]], label)) %>%
		bind_rows(log2) %>%
		re_map(mapping(log1))
}