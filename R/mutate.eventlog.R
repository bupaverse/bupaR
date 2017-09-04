#' @title Mutate event log
#' @description Mutate an event log
#' @param .data Eventlog
#' @param ... New variables
#' @method mutate eventlog
#' @export

mutate.eventlog <- function(.data, ...) {


	mapping <- mapping(.data)
	x <- NextMethod(.data, ...)

	x %>%
		re_map(mapping) -> x

	return(x)

}

