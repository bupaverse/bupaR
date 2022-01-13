#' @title Re map
#'
#' @description Construct an eventlog using an existing mapping.
#'
#' @param x The eventlog/activitylog data to be used.
#'
#' @param mapping An existing eventlog mapping created by the mapping function
#'
#' @export re_map
#'
re_map <- function(x, mapping) {

	if("eventlog_mapping" %in% class(mapping)) {
		eventlog(x,
				 case_id = mapping$case_identifier,
				 activity_id = mapping$activity_identifier,
				 activity_instance_id = mapping$activity_instance_identifier,
				 lifecycle_id = mapping$lifecycle_identifier,
				 timestamp = mapping$timestamp_identifier,
				 resource_id = mapping$resource_identifier,
				 order = ".order",
				 validate = FALSE) # assumes that data is OK upon for `re_map`
	} else if("activitylog_mapping" %in% class(mapping)) {
		activitylog(x,
					case_id = mapping$case_identifier,
					activity_id = mapping$activity_identifier,
					lifecycle_ids = mapping$lifecycle_identifiers,
					resource_id = mapping$resource_identifier,
					order = ".order")

	} else {
		stop("Invalid mapping")
	}
}



