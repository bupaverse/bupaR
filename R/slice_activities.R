#' @title Slice Activities
#' @description Take a slice of activity instances from event log
#' @param .data Eventlog
#' @param ... Slice index
#' @export slice_activities
slice_activities <- function(.data, ...) {
  UseMethod("slice_activities")
}
#' @describeIn slice Take a slice of activity instances from event log
#' @export

slice_activities.eventlog <- function(.data, ...) {
  mapping <- mapping(.data)
  .data %>%
    slice_activities_raw(activity_instance_id(.data), ...) %>%
    re_map(mapping)
}

#' @describeIn slice Take a slice of activity instances from grouped event log
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


slice_activities_raw <- function(.data, .activity_instance_id, ...) {
  .data %>%
    pull(!!sym(.activity_instance_id)) %>%
    unique() %>%
    .[...] -> selection
  .data %>%
    filter(!!sym(.activity_instance_id) %in% selection)
}