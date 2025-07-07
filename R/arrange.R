#' @title Arrange log
#' @name arrange
#' @param .data \code{\link{log}}: Object of class \code{\link{eventlog}} or \code{\link{activitylog}}.
#' @inheritDotParams dplyr::arrange
#' @inheritParams dplyr::arrange
#' @importFrom dplyr arrange
#' @export
dplyr::arrange
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

arrange.grouped_eventlog <- function(.data, ...) {

	mapping <- mapping(.data)

	.data %>%
		as.grouped.data.frame(mapping$groups) %>%
		dplyr::arrange(...) %>%
		re_map(mapping) %>%
		dplyr::group_by_at(mapping$groups)
}
#' @describeIn arrange Arrange an activitylog

#' @export
#'
arrange.activitylog <- function(.data, ...) {
	mapping <- mapping(.data)
	.data <- as.data.frame(.data)

	x <- arrange(.data, ...)
	x <- re_map(x, mapping)

	return(x)
}


#' @export
#'
arrange.grouped_activitylog <- function(.data, ...) {
	mapping <- mapping(.data)
	groups <- groups(.data)
	.data <- as.data.frame(.data)
	x <- arrange(.data, ...)
	x <- re_map(x, mapping)
	x <- group_by_at(x, vars(one_of(paste(groups))))
	return(x)
}
