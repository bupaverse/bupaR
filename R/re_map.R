#' @title Re map
#'
#' @description Construct an eventlog using an existing mapping.
#'
#' @param x The eventlog/activitylog data to be used.
#' @param mapping An existing eventlog mapping created by the mapping function
#'
#' @export re_map
#'
re_map <- function(x, mapping) {

	if("eventlog_mapping" %in% class(mapping)) {
		log <- eventlog(x,
				 case_id = mapping$case_identifier,
				 activity_id = mapping$activity_identifier,
				 activity_instance_id = mapping$activity_instance_identifier,
				 lifecycle_id = mapping$lifecycle_identifier,
				 timestamp = mapping$timestamp_identifier,
				 resource_id = mapping$resource_identifier,
				 order = ".order",
				 validate = FALSE) # assumes that data is OK upon for `re_map`
	} else if("activitylog_mapping" %in% class(mapping)) {
		log <- activitylog(x,
					case_id = mapping$case_identifier,
					activity_id = mapping$activity_identifier,
					lifecycle_ids = mapping$lifecycle_identifiers,
					resource_id = mapping$resource_identifier,
					order = ".order")

	} else {
		stop("Invalid mapping")
	}

	# Refactoring code (requires a lot of changes, not used yet).
	#if (length(mapping$groups) > 0) {
	#	log %>%
	#		dplyr::group_by_at(mapping$groups)
	#	class(log) <- c("grouped_eventlog", class(x))
	#}

	return(log)
}



