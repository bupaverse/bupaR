#' @title Fill event log
#' @param data Eventlog
#' @param ... options for fill
#' @name fill
#' @importFrom tidyr fill
#' @export
tidyr::fill
#' @describeIn fill Fill eventlog
#' @export
fill.eventlog <- function(data, ...) {

  mapping <- mapping(data)

  data %>%
    as.data.table() %>%
    tidyr::fill(...) %>%
    re_map(mapping)
}

#' @describeIn fill Fill grouped eventlog
#' @export

fill.grouped_eventlog <- function(data, ...) {

  mapping <- mapping(data)

  data %>%
    as.grouped.data.frame(mapping$groups) %>%
    tidyr::fill(...) %>%
    re_map(mapping) %>%
    dplyr::group_by_at(mapping$groups)
}
