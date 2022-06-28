#' @title Slice Events
#' @description Take a slice of events from event log
#' @param .data \code{\link{log}}: Object of class \code{\link{eventlog}} or \code{\link{activitylog}}
#' @param ... Slice index
#' @export slice_events
slice_events <- function(.data, ...) {
  UseMethod("slice_events")
}
#' @describeIn slice Take a slice of events from event log
#' @export

slice_events.eventlog <- function(.data, ...) {
  .data[...,]
}

#' @describeIn slice Take a slice of events from grouped event log
#' @export
slice_events.grouped_eventlog <- function(.data, ...) {
	.data %>%
		apply_grouped_fun(slice_events, ..., .keep_groups = TRUE, .returns_log = TRUE)
}

