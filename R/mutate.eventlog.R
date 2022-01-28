#' @title Mutate event log
#' @param .data Eventlog
#' @param ... New variables
#' @name mutate
#' @importFrom dplyr mutate
#' @export
dplyr::mutate
#' @describeIn mutate Mutate eventlog
#' @export
mutate.eventlog <- function(.data, ...) {
	mapping <- mapping(.data)
	x <- NextMethod(.data, ...)
	x %>%
		re_map(mapping) -> x
	return(x)

}

#' @describeIn mutate Mutate grouped eventlog
#' @export

mutate.grouped_eventlog <- function(.data, ...) {
	mapping <- mapping(.data)
	groups <- groups(.data)
	x <- NextMethod(.data, ...)
	x <- re_map(x, mapping)
	x <- group_by_at(x, vars(one_of(paste(groups))))
	return(x)

}
