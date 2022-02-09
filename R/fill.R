#' @title Fill event log
#' @param eventlog Eventlog
#' @param ... options for fill
#' @name fill
#' @importFrom tidyr fill
#' @export
tidyr::fill
#' @describeIn fill Fill eventlog
#' @export
fill.eventlog <- function(eventlog, ..., .direction = c("down", "up", "downup", "updown")) {

  mapping <- mapping(eventlog)

  eventlog %>%
    as.data.frame() %>%
    tidyr::fill(..., .direction = .direction) %>%
    re_map(mapping)
}

#' @describeIn fill Fill grouped eventlog
#' @export

fill.grouped_eventlog <- function(eventlog, ..., .direction = c("down", "up", "downup", "updown")) {

  mapping <- mapping(eventlog)

  eventlog %>%
    as.data.frame() %>%
    tidyr::fill(..., .direction = .direction) %>%
    re_map(mapping) %>%
    dplyr::group_by_at(mapping$groups)
}
