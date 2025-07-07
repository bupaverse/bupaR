#' @title Fill event log
#' @param data \code{\link{log}}: Object of class \code{\link{eventlog}} or \code{\link{activitylog}}.
#' @inheritDotParams tidyr::fill
#' @inheritParams tidyr::fill
#' @name fill
#' @importFrom tidyr fill
#' @export
tidyr::fill

#' @export
fill.log <- function(data, ...) {

  mapping <- mapping(data)

  data %>%
    as.data.table() %>%
    tidyr::fill(...) %>%
    re_map(mapping)
}

#' @export
fill.grouped_eventlog <- function(data, ...) {

  mapping <- mapping(data)

  data %>%
    as.grouped.data.frame(mapping$groups) %>%
    tidyr::fill(...) %>%
    re_map(mapping) %>%
    dplyr::group_by_at(mapping$groups)
}
