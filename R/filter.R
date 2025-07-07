#' @title Filter event log
#' @name filter
#' @param .data \code{\link{log}}: Object of class \code{\link{eventlog}} or \code{\link{activitylog}}.
#' @param ... Additional arguments passed to [dplyr][filter]
#' @inheritParams dplyr::filter
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
filter.activitylog <- function(.data, ...) {
	mapping <- mapping(.data)
	.data %>%
		as.data.frame() %>%
		dplyr::filter(...) %>%
		re_map(mapping)
}

#' @export

filter.grouped_log <- function(.data, ...) {
	apply_grouped_fun(.data, filter, ..., .ignore_groups = FALSE, .keep_groups = TRUE, .returns_log = TRUE)
}



# @export
#'
#' filter.grouped_eventlog <- function(.data, ...) {
#' 	groups <- groups(.data)
#' 	mapping <- mapping(.data)
#' 	.data %>%
#' 		nest() %>%
#' 		mutate(data = map(data, dplyr::filter, ...)) %>%
#' 		unnest(data) %>%
#' 		re_map(mapping) %>%
#' 		group_by_at(vars(one_of(paste(groups))))
#'
#' }
#'
# #' @export
#'
#' filter.grouped_activitylog <- function(.data, ...) {
#' 	groups <- groups(.data)
#' 	mapping <- mapping(.data)
#' 	.data %>%
#' 		nest() %>%
#' 		mutate(data = map(data, dplyr::filter, ...)) %>%
#' 		unnest(data) %>%
#' 		re_map(mapping) %>%
#' 		group_by_at(vars(one_of(paste(groups))))
#'
#' }
