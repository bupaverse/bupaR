#' @title Slice function for event log
#' @param .data Eventlog
#' @param ... Additional Arguments
#' @name slice
#' @importFrom dplyr slice
#' @export
dplyr::slice

#' @describeIn slice Slice n cases of an eventlog
#' @export

slice.eventlog <- function(.data, ...) {

	.data %>%
		pull(!!as.symbol(case_id(.data))) %>%
		unique() %>%
		.[...] -> selection
	.data %>%
		filter((!!as.symbol(case_id(.data))) %in% selection)
}

#' @describeIn slice Slice grouped eventlog: take slice of cases from each group.
#' @export

slice.grouped_eventlog <- function(.data, ...) {

	mapping <- mapping(.data)

	.data %>%
		nest() %>%
		mutate(data = map(data, re_map, mapping)) %>%
		mutate(data = map(data, slice, ...)) %>%
		unnest() %>%
		re_map(mapping) %>%
		return()
}

#' @title Slice Events
#' @description Take a slice of events from event log
#' @param .data Eventlog
#' @param ... Slice index
#' @export slice_events
slice_events <- function(.data, ...) {
	UseMethod("slice_events")
}
#' @describeIn slice_events Take a slice of events from event log
#' @export

slice_events.eventlog <- function(.data, ...) {
	mapping <- mapping(.data)
	.data %>%
		as.data.frame %>%
		dplyr::slice(...) %>%
		re_map(mapping)
}
#' @describeIn slice_events Take a slice of events from grouped event log
#' @export
slice_events.grouped_eventlog <- function(.data, ...) {
	groups <- groups(.data)
	mapping <- mapping(.data)
	.data %>%
		nest() %>%
		mutate(data = map(data, as.data.frame)) %>%
		mutate(data = map(data, dplyr::slice, ...)) %>%
		unnest() %>%
		re_map(mapping) %>%
		group_by_at(vars(one_of(paste(groups))))
}


#' @title Slice Activities
#' @description Take a slice of activity instances from event log
#' @param .data Eventlog
#' @param ... Slice index
#' @export slice_activities
slice_activities <- function(.data, ...) {
	UseMethod("slice_activities")
}
#' @describeIn slice_activities Take a slice of activity instances from event log
#' @export

slice_activities.eventlog <- function(.data, ...) {
	mapping <- mapping(.data)
	.data %>%
		slice_activities_raw(activity_instance_id(.data), ...) %>%
		re_map(mapping)
}

slice_activities_raw <- function(.data, .activity_instance_id, ...) {
	.data %>%
		pull(!!sym(.activity_instance_id)) %>%
		unique() %>%
		.[...] -> selection
	.data %>%
		filter(!!sym(.activity_instance_id) %in% selection)
}



#' @describeIn slice_activities Take a slice of activity instances from grouped event log
#' @export
slice_activities.grouped_eventlog <- function(.data, ...) {
	groups <- groups(.data)
	mapping <- mapping(.data)
	aid <- activity_instance_id(.data)
	.data %>%
		nest() %>%
		mutate(data = map(data, slice_activities_raw, aid, ...)) %>%
		unnest() %>%
		re_map(mapping) %>%
		group_by_at(vars(one_of(paste(groups))))
}
