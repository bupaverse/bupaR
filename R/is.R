#' @title Test if the Object is a Log
#'
#' @description This function returns `TRUE` if `x` inherits from the specified class, and `FALSE` for all other objects.
#'
#' @param x Any `R` object.
#'
#' @return
#' `is.log` returns `TRUE` if the object inherits from the \code{\link{log}} class, otherwise `FALSE`.
#'
#' `is.eventlog` returns `TRUE` if the object inherits from the \code{\link{eventlog}} class, otherwise `FALSE`.
#'
#' `is.actvitylog` returns `TRUE` if the object inherits from the \code{\link{activitylog}} class, otherwise `FALSE`.
#'
#' `is.grouped_log` returns `TRUE` if the object inherits from the \code{\link{grouped_log}} class, otherwise `FALSE`.
#'
#' `is.grouped_eventlog` returns `TRUE` if the object inherits from the \code{\link{grouped_eventlog}} class, otherwise `FALSE`.
#'
#' `is.grouped_activitylog` returns `TRUE` if the object inherits from the \code{\link{grouped_activitylog}} class, otherwise `FALSE`.
#'
#' @seealso \code{\link{log}},\code{\link{eventlog}},\code{\link{activitylog}},\code{\link{grouped_log}},\code{\link{grouped_eventlog}},\code{\link{grouped_activitylog}}

#' @rdname is
#' @export
is.log <- function(x) {
  inherits(x, "log")
}

#' @rdname is
#' @export
is.eventlog <- function(x) {
  inherits(x, "eventlog")
}

#' @rdname is
#' @export
is.activitylog <- function(x) {
  inherits(x, "activitylog")
}

#' @rdname is
#' @export
is.grouped_log <- function(x) {
  inherits(x, "grouped_log")
}

#' @rdname is
#' @export
is.grouped_eventlog <- function(x) {
  inherits(x, "grouped_eventlog")
}

#' @rdname is
#' @export
is.grouped_activitylog <- function(x) {
  inherits(x, "grouped_activitylog")
}