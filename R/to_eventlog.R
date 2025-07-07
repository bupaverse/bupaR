#' Convert activitylog to eventlog
#'
#' @param activitylog Object of class \code{\link{activitylog}}
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
		mutate(activity_instance_id_by_bupar = as.character(1:n())) %>%
		#mutate(across(timestamps(activitylog), as.character)) %>%
		gather(lifecycle_id, timestamp, timestamps(activitylog)) %>%
		filter(!is.na(timestamp)) %>%
		#mutate(timestamp = ymd_hms(timestamp)) %>%
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


