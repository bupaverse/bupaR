#' Group log on identifiers
#'
#' @inheritParams group_by_case
#' @param ... One or more of the following: activity_id, case_id, activity_instance_id, resource_id, lifecycle_id
#'
#' @return Grouped log
#' @export
#'


group_by_ids <- function(log, ...) {
	UseMethod("group_by_ids")
}

#' @describeIn group_by_ids Group log on identifiers
#' @export

group_by_ids.log <- function(log, ...) {

	ids <- list(...)

	for(i in 1:length(ids)) {
		ids[[i]] <- ids[[i]](log)
	}
	group_by(log, across(paste(ids)))
}
