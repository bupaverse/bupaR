#' @title Arrange event log
#' @name arrange
#' @param .data Eventlog
#' @param ... Variables to arrange on
#' @importFrom dplyr arrange
#' @export
dplyr::arrange
#' @describeIn arrange Arrange an eventlog
#' @export
arrange.eventlog <- function(.data, ...) {

	mapping <- mapping(.data)

	.data %>%
		as.data.frame() %>%
		dplyr::arrange(...) %>%
		re_map(mapping)
}

#' @describeIn arrange Arrange an eventlog by group, maintaining all groups
#' @export
#'
arrange.grouped_eventlog <- function(.data, ...) {

	mapping <- mapping(.data)

	.data %>%
		as.grouped.data.frame(mapping$groups) %>%
		dplyr::arrange(...) %>%
		re_map(mapping) %>%
		dplyr::group_by_at(mapping$groups)
}
