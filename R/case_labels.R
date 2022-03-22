#' @title Case labels
#'
#' @description Retrieve a vector containing all unique case labels
#'
#' @param log \code{\link{log}}: Object of class \code{\link{eventlog}} or \code{\link{activitylog}}.
#' @param eventlog Deprecated; please use \code{log} instead.
#'
#' @export
case_labels <- function(log, eventlog = deprecated()) {
  UseMethod("case_labels")
}

#' @describeIn case_labels Retrieve case labels from log
#' @export
case_labels.log <- function(log, eventlog = deprecated()) {

  log <- lifecycle_warning_eventlog(log, eventlog)

  log %>%
    pull(.data[[case_id(log)]]) %>%
    unique()
}

