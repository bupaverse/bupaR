#' @title Slice Activities
#' @description Take a slice of activity instances from event log
#' @param .data \code{\link{log}}: Object of class \code{\link{eventlog}} or \code{\link{activitylog}}.
#' @param ... Slice index
#' @export slice_activities
slice_activities <- function(.data, ...) {
  UseMethod("slice_activities")
}
#' @describeIn slice Take a slice of activity instances from event log
#' @export

slice_activities.eventlog <- function(.data, ...) {
	.data %>%
		filter(.data[[activity_instance_id(.data)]] %in% unique(.data[[activity_instance_id(.data)]])[...] )
}

#' @describeIn slice Take a slice of activity instances from activity log
#' @export

slice_activities.activitylog <- function(.data, ...) {
	.data[...,]
}

#' @describeIn slice Take a slice of activity instances from grouped event log
#' @export
slice_activities.grouped_log <- function(.data, ...) {
	.data %>%
		apply_grouped_fun(slice_activities, ..., .keep_groups = TRUE, .returns_log = TRUE)
}

