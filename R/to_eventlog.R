#' Convert activitylog to eventlog
#'
#' @param activitylog Object of class activitylog to be converted to eventlog.
#'
#' @export
#'
to_eventlog <- function(activitylog) {
	UseMethod("to_eventlog")
}

#' @describeIn to_eventlog Convert activitylog to eventlog
#' @export
to_eventlog.activitylog <- function(activitylog) {
	activitylog %>%
		as.data.frame() %>%
		mutate(activity_instance_id_by_bupar = 1:n()) %>%
		gather(lifecycle_id, timestamp, lifecycle_ids(activitylog)) %>%
		filter(!is.na(timestamp)) %>%
		eventlog(case_id = case_id(activitylog),
				 activity_id = activity_id(activitylog),
				 activity_instance_id = "activity_instance_id_by_bupar",
				 timestamp = "timestamp",
				 lifecycle_id = "lifecycle_id",
				 resource_id = resource_id(activitylog))
}

#' @describeIn to_eventlog Convert grouped activitylog to grouped eventlog
#' @export
#'
to_eventlog.grouped_activitylog <- function(activitylog) {
	mapping <- mapping(activitylog)
	activitylog %>%
		to_eventlog.activitylog() %>%
		group_by(across(mapping$groups))
}


