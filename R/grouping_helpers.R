#' as.grouped.data.frame
#'
#' @param data Data
#' @param groups Names of grouping variables as character vector (e.g. by using \code{dplyr::group_vars}
as.grouped.data.frame <- function(data, groups) {

	data %>%
		as.data.frame() %>%
		dplyr::group_by_at(groups)
}

apply_grouped_fun <- function(log, fun, ..., .ignore_groups = FALSE) {
	mapping <- mapping(log)

	if(!.ignore_groups) {
		log %>%
			# remove grouping
			ungroup() %>%
			# group_by + nest (has option to keep group-vars in nested data)
			nest_by(across(mapping$groups), .keep = TRUE) %>%
			# nest_by returns rowwise data.frame, which we don't need
			ungroup() %>%
			# make sure data is event log
			mutate(data = map(data, re_map, mapping)) %>%
			# compute output of function, taking over any arguments
			mutate(data = map(data, fun, ...)) %>%
			# remove any columns in the output data that is also present in the group-keys
			mutate(data = map(data, ~select(.x,-any_of(mapping$groups)))) %>%
			# unnest
			unnest(cols = data)
	} else {
		log %>%
			ungroup_eventlog() %>%
			fun(...) %>%
			group_by(across(mapping$groups))
	}
}
