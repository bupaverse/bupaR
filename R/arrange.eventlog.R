#' @title Arrange event log
#' @name arrange
#' @param .data Eventlog
#' @param ... Variables to arrange on
#' @importFrom dplyr arrange
#' @export
dplyr::arrange
#' @describeIn arrange Arrange an eventlog
#' @export
arrange.eventlog <- function(.data, ..., add = F) {

	mapping <- mapping(.data)
	x <- NextMethod(.data, ...)
	x <- re_map(x, mapping)

	return(x)

}
#' @describeIn arrange Arrange an eventlog by group, maintaining all groups
#' @export
#'
arrange.grouped_eventlog <- function(.data, ..., add = F) {
	mapping <- mapping(.data)
	groups <- groups(.data)
	x <- NextMethod(.data, ...)
	x <- re_map(x, mapping)
	x <- group_by_at(x, vars(one_of(paste(groups))))
	return(x)
}
