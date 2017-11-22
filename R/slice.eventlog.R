#' @title Slice function for event log
#' @param .data Eventlog
#' @param ... Additional Arguments
#' @name slice
#' @importFrom dplyr slice
#' @export
dplyr::slice

#' @describeIn slice Slice n cases of an eventlog
#' @export

slice.eventlog <- function(.data, ...) {

	.data %>%
		pull(!!as.symbol(case_id(.data))) %>%
		.[...] -> selection
	.data %>%
		filter((!!as.symbol(case_id(.data))) %in% selection)
}

#' @describeIn slice Slice grouped eventlog: take slice of cases from each group.
#' @export

slice.grouped_eventlog <- function(.data, ...) {

	mapping <- mapping(.data)

	.data %>%
		nest() %>%
		mutate(data = map(data, re_map, mapping)) %>%
		mutate(data = map(data, slice, ...)) %>%
		unnest() %>%
		re_map(mapping) %>%
		return()
}
