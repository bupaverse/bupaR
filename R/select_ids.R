
#' Select identifiers from log
#'
#' @param .log \code{\link{log}}: Object of class \code{\link{log}}, \code{\link{eventlog}}, or \code{\link{activitylog}}.
#' @param ... One or more of the following: activity_id, case_id, activity_instance_id, resource_id, lifecycle_id
#' @examples
#'
#' library(eventdataR)
#'
#' patients %>% select_ids(activity_id, case_id)
#'
#'
#' @export
#'
select_ids <- function(.log, ...) {
	UseMethod("select_ids")
}

#' @describeIn select_ids Select identifiers from log
#' @export
#'
select_ids.log <- function(.log, ...) {

	ids <- list(...)

	for(i in 1:length(ids)) {
		ids[[i]] <- ids[[i]](.log)
	}
	select(.log, all_of(unlist(ids)), force_df = TRUE)
}
