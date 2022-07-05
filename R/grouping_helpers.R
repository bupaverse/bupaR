#' as.grouped.data.frame
#'
#' @param data Data
#' @param groups Names of grouping variables as character vector (e.g. by using \code{dplyr::group_vars}
as.grouped.data.frame <- function(data, groups) {

	data %>%
		as.data.frame() %>%
		dplyr::group_by_at(groups)
}

apply_grouped_fun <- function(log, fun, ..., .ignore_groups = FALSE, .keep_groups = FALSE, .returns_log = FALSE) {

	mapping <- mapping(log)

	if(!.ignore_groups) {

		if(!.returns_log) { #fun does not return eventlog
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
				# for log metrics in edeaR, extract raw attributes from the data.
				# We propagate these attributes to the final log
				mutate(raw = map(data, attr, "raw")) -> log


			# extract and unnest raw colum
			log %>%
				select(any_of(mapping$groups), raw) %>%
				unnest(cols = raw) -> raw

			# remove raw column and unnest log
			log %>%
				select(-raw) %>%
				# remove any columns in the output data that is also present in the group-keys
				mutate(data = map(data, ~select(.x,-any_of(mapping$groups)))) %>%
				# unnest
				unnest(cols = data) -> log

			# add raw data as attribute (if not empty)
			if(nrow(raw) > 0) {
				attr(log, "raw") <- raw
			}


		} else { #fun returns eventlog
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
				mutate(data = map(data, ~select(.x,-any_of(mapping$groups), force_df = TRUE))) %>%
				# unnest
				unnest(cols = data) %>%
				re_map(mapping) -> log
		}
	} else {
		log %>%
			ungroup_eventlog() %>%
			fun(...) -> log
	}
	if(.keep_groups) {
		log %>%
			group_by(across(mapping$groups)) -> log
	}
	log
}
