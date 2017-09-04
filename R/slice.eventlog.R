#' @title Slice function for event log
#' @description Return a slice of an event log object
#' @param .data Eventlog
#' @param ... Additional Arguments
#' @method slice eventlog
#' @export

slice.eventlog <- function(.data, ...) {


	mapping <- mapping(.data)
	x <- NextMethod(.data, ...)

	x %>%
		re_map(mapping) %>%
		return

}

