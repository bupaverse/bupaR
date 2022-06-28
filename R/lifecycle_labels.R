#' @title Get vector of lifecycle labels.
#'
#' @description Retrieve a vector containing all unique lifecycle labels.
#'
#' @inheritParams act_collapse

#'
#' @seealso \code{\link{lifecycle_id}}
#'
#' @export
lifecycle_labels <- function(log, eventlog = deprecated()) {
  UseMethod("lifecycle_labels")
}

#' @describeIn lifecycle_labels Retrieve lifecycle labels from an \code{\link{eventlog}}.
#' @export
lifecycle_labels.eventlog <- function(log, eventlog = deprecated()) {

  log <- lifecycle_warning_eventlog(log, eventlog)

  log %>%
    #ungroup() %>%
    pull(!!lifecycle_id_(log)) %>%
    unique()
}

#' @describeIn lifecycle_labels Retrieve lifecycle labels from an \code{\link{activitylog}}.
#' @export
lifecycle_labels.activitylog <- function(log, eventlog = deprecated()) {

  log <- lifecycle_warning_eventlog(log, eventlog)

  as.factor(sort(timestamps(log)))
}
