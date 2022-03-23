#' @title Slice Events
#' @description Take a slice of events from event log
#' @param .data Eventlog
#' @param ... Slice index
#' @export slice_events
slice_events <- function(.data, ...) {
  UseMethod("slice_events")
}
#' @describeIn slice Take a slice of events from event log
#' @export

slice_events.eventlog <- function(.data, ...) {
  mapping <- mapping(.data)
  .data %>%
    as.data.frame %>%
    dplyr::slice(...) %>%
    re_map(mapping)
}
#' @describeIn slice Take a slice of events from grouped event log
#' @export
slice_events.grouped_eventlog <- function(.data, ...) {
  groups <- groups(.data)
  mapping <- mapping(.data)
  .data %>%
    nest() %>%
    mutate(data = map(data, as.data.frame)) %>%
    mutate(data = map(data, dplyr::slice, ...)) %>%
    unnest(data) %>%
    re_map(mapping) %>%
    group_by_at(vars(one_of(paste(groups))))
}