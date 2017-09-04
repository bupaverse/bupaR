#' @title Group event log
#' @description Group an event log
#' @param .data Eventlog
#' @param ... Variables to group by
#' @param add Add grouping variables to existing ones
#' @method group_by eventlog
#' @export

group_by.eventlog <- function(.data, ..., add = F) {


	mapping <- mapping(.data)
	x <- NextMethod(.data, ..., add = add)
	class(x) <- c("eventlog","grouped_eventlog", class(x))
	groups <- groups(x)
	mapping <- mapping(x)

	# map(groups, ~names(mapping)[.x == mapping]) %>%
	# 	.[lengths(.)>0] %>%
	# 	as.character() -> t
	# print(t)
	#
	# if(length(t) > 0) {
	# 	warning(glue::glue("Grouping includes mapped variables {paste(t, collapse = \", \")}.
	# 					   Might produce unexpected behavior. Use provided analysis levels instead."))
	# }

	return(x)

}

