#' @title Fill event log
#' @param .data Eventlog
#' @param ... options for fill
#' @name fill
#' @importFrom tidyr fill
#' @export
tidyr::fill
#' @describeIn fill Fill eventlog
#' @export
fill.eventlog <- function(data, ..., .direction) {
  mapping <- mapping(data)
  x <- NextMethod(data, ..., .direction)
  x %>%
    re_map(mapping) -> x
  return(x)

}

#' @describeIn fill Fill grouped eventlog
#' @export

fill.grouped_eventlog <- function(data, ..., .direction) {
  mapping <- mapping(data)
  groups <- groups(data)
  x <- NextMethod(data, ..., .direction)
  x <- re_map(x, mapping)
  x <- group_by_at(x, vars(one_of(paste(groups))))
  return(x)

}
