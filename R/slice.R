#' @title Slice function for event log
#' @name slice
#' @inheritDotParams dplyr::slice
#' @inheritParams dplyr::slice
#' @importFrom dplyr slice
#' @export
dplyr::slice

#' @describeIn slice Slice n cases of a log
#' @export

slice.log <- function(.data, ...) {

	.data %>%
		filter(.data[[case_id(.data)]] %in% unique(.data[[case_id(.data)]])[...] )
}


#' @describeIn slice Slice grouped log: take slice of cases from each group.
#' @export

slice.grouped_log <- function(.data, ...) {
	.data %>%
		apply_grouped_fun(slice, ..., .keep_groups = TRUE, .returns_log = TRUE)
}
