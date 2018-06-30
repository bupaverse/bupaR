#' @title Unite multiple columns into one.

#' @param .data Eventlog
#' @param col The name of the new column (character value)
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
	data %>%
		as.data.frame() %>%
		unite(col = !!col, ..., sep = sep, remove = remove) %>%
		re_map(mapping)
}

#' @describeIn unite Unite columns in grouped eventlog
#' @export

unite.grouped_eventlog <- function(data, col, ..., sep = "_", remove = T) {

	mapping <- mapping(data)
	groups <- groups(data)

	data %>%
		as.data.frame() %>%
		unite(col = !!col, ..., sep = sep, remove = remove) %>%
		re_map(mapping) %>%
		group_by_at(vars(one_of(paste(groups))))

}
