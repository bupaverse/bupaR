#' @title Unite multiple columns into one.

#' @param .data Eventlog
#' @param col The name of the new column
#' @param ... Columns to be united.
#' @param sep Seperator
#' @param remove Remove original columns
#' @name unite
#' @importFrom tidyr unite
#' @export
tidyr::unite

#' @describeIn unite Unite columns in eventlog
#' @export

unite.eventlog <- function(data, col, ..., sep = "_", remove = T) {

	mapping <- mapping(data)
	x <- NextMethod(data, col, ...)
	x %>%
		re_map(mapping) -> x


	return(x)

}

#' @describeIn unite Unite columns in grouped eventlog
#' @export

unite.grouped_eventlog <- function(data, col, ..., sep = "_", remove = T) {

	mapping <- mapping(data)
	groups <- groups(data)
	x <- NextMethod(data, ...)
	x <- re_map(x, mapping)
	x <- group_by_at(x, vars(one_of(paste(groups))))

	return(x)

}
