#' @title Mutate event log
#' @name mutate
#' @param ... Additional arguments passed to [dplyr][mutate]
#' @inheritParams dplyr::mutate
#' @importFrom dplyr mutate
#' @export
dplyr::mutate
#' @export

mutate.eventlog <- function(.data, ...) {
	mapping <- mapping(.data)
	x <- NextMethod(.data, ...)
	x %>%
		re_map(mapping) -> x
	return(x)

}

#' @export
mutate.grouped_eventlog <- function(.data, ...) {
	mapping <- mapping(.data)
	groups <- groups(.data)
	x <- NextMethod(.data, ...)
	x <- re_map(x, mapping)
	x <- group_by_at(x, vars(one_of(paste(groups))))
	return(x)
}

#' @export

mutate.activitylog <- function(.data, ...) {
	mapping <- mapping(.data)
	x <- NextMethod(.data, ...)
	x %>%
		re_map(mapping) -> x
	return(x)

}
#' @export
mutate.grouped_activitylog <- function(.data, ...) {
	mapping <- mapping(.data)
	groups <- groups(.data)
	x <- NextMethod(.data, ...)
	x <- re_map(x, mapping)
	x <- group_by_at(x, vars(one_of(paste(groups))))
	return(x)
}
