#' @title Arrange event log
#' @name arrange
#' @param .data Eventlog
#' @param ... Variables to arrange on
#' @importFrom dplyr arrange
#' @export
dplyr::arrange
#' @export
arrange.eventlog <- function(.data, ...) {

	mapping <- mapping(.data)
	.data <- as.data.frame(.data)

	x <- arrange(.data, ...)
	x <- re_map(x, mapping)

	return(x)

}
#' @export
#'
arrange.grouped_eventlog <- function(.data, ...) {
	mapping <- mapping(.data)
	groups <- groups(.data)
	.data <- as.data.frame(.data)
	x <- arrange(.data, ...)
	x <- re_map(x, mapping)
	x <- group_by_at(x, vars(one_of(paste(groups))))
	return(x)
}
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
