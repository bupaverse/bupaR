#' @title Case labels
#'
#' @description Retrieve a vector containing all unique case labels
#'
#' @inheritParams act_collapse
#'
#' @export
case_labels <- function(log) {
  UseMethod("case_labels")
}

#' @describeIn case_labels Retrieve case labels from log
#' @export
case_labels.log <- function(log) {
  log %>%
    pull(.data[[case_id(log)]]) %>%
    unique()
}

