#' @title Filter event log
#' @name filter
#' @param .data Eventlog
#' @param ... Conditions to filter
#' @importFrom dplyr filter
#' @export
dplyr::filter

#' @describeIn filter Filter eventlog
#' @export
filter.eventlog <- function(.data, ...) {
	mapping <- mapping(.data)
	.data %>%
		as.data.frame() %>%
		dplyr::filter(...) %>%
		re_map(mapping) %>%
		return()
}
#' @describeIn filter Filter eventlog
#' @export

filter.grouped_eventlog <- function(.data, ...) {
	groups <- groups(.data)
	mapping <- mapping(.data)
	.data %>%
		nest() %>%
		mutate(data = map(data, dplyr::filter, ...)) %>%
		unnest() %>%
		re_map(mapping) %>%
		group_by_at(vars(one_of(paste(groups))))

}
