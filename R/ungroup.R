#' @title Ungroup log
#' @param x Activitylog
#' @param ... variables to remove from grouping
#' @name ungroup
#' @importFrom dplyr ungroup
#' @export
dplyr::ungroup

#' @describeIn ungroup Ungroup columns in eventlog
#' @export

ungroup.activitylog <- function(x, ...) {

	mapping <- mapping(x)
	x %>%
		as.data.frame() %>%
		dplyr::ungroup(...) %>%
		re_map(mapping)
}
