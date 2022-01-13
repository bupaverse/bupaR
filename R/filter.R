#' @title Filter event log
#' @name filter
#' @param .data Eventlog
#' @param ... Conditions to filter
#' @importFrom dplyr filter
#' @export
dplyr::filter

#' @export
filter.eventlog <- function(.data, ...) {
	mapping <- mapping(.data)
	.data %>%
		as.data.frame() %>%
		dplyr::filter(...) %>%
		re_map(mapping)
}
#' @export

filter.grouped_eventlog <- function(.data, ...) {
	groups <- groups(.data)
	mapping <- mapping(.data)
	.data %>%
		nest() %>%
		mutate(data = map(data, dplyr::filter, ...)) %>%
		unnest(data) %>%
		re_map(mapping) %>%
		group_by_at(vars(one_of(paste(groups))))

}

#' @export
filter.activitylog <- function(.data, ...) {
	mapping <- mapping(.data)
	.data %>%
		as.data.frame() %>%
		dplyr::filter(...) %>%
		re_map(mapping)
}

#' @export

filter.grouped_activitylog <- function(.data, ...) {
	groups <- groups(.data)
	mapping <- mapping(.data)
	.data %>%
		nest() %>%
		mutate(data = map(data, dplyr::filter, ...)) %>%
		unnest(data) %>%
		re_map(mapping) %>%
		group_by_at(vars(one_of(paste(groups))))

}
