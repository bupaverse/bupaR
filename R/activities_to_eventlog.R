#' Create event log from list of activity instances
#'
#' @param activity_log A data.frame where each row is an activity instances
#' @param case_id Column name of the case identifier
#' @param activity_id Column name of the activity identifier
#' @param resource_id Column name of the resource identifier
#' @param timestamps A vector of column names containing different timestamp. To column names will be transformed to lifecycle identifiers
#'
#' @export
activities_to_eventlog <- function(activity_log,
								   case_id,
								   activity_id,
								   resource_id,
								   timestamps) {

	stopifnot(is.data.frame(activity_log))
	stopifnot(is.character(case_id))
	stopifnot(is.character(activity_id))
	stopifnot(is.character(resource_id))
	stopifnot(is.character(timestamps))
	stopifnot(length(timestamps) > 1)

	activity_log %>%
		ungroup() %>%
		mutate(activity_instance_id = 1:n()) %>%
		tidyr::gather(lifecycle_id, timestamp, one_of(timestamps)) %>%
		eventlog(case_id = case_id,
				 activity_id = activity_id,
				 activity_instance_id = "activity_instance_id",
				 lifecycle_id = "lifecycle_id",
				 timestamp = "timestamp",
				 resource_id = resource_id)


}
