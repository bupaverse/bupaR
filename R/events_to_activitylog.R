

#' Events to activities
#'
#' @param eventlog The event log to be converted. An object of class
#' \code{eventlog} or \code{data.frame}
#' @param case_id If eventlog is data.frame, the case classifier of the event log. A character vector containing variable names of length 1 or more.
#' @param activity_id If eventlog is data.frame, the activity classifier of the event log. A character vector containing variable names of length 1 or more.
#' @param activity_instance_id If eventlog is data.frame, the activity instance classifier of the event log.
#' @param lifecycle_id If eventlog is data.frame, the life cycle classifier of the event log.
#' @param timestamp If eventlog is data.frame, the timestamp of the event log. Should refer to a Date or POSIXct field.
#' @param resource_id If eventlog is data.frame, the resource identifier of the event log. A character vector containing variable names of length 1 or more.
#' @param ... Additional argments, i.e. for fixing resource inconsistencies
#' @importFrom stringr str_subset
#' @export
#'

events_to_activitylog <- function(eventlog, case_id, activity_id, activity_instance_id, lifecycle_id, timestamp, resource_id, ...) {
	UseMethod("events_to_activitylog")
}

#' @export
events_to_activitylog.data.frame <- function(eventlog, case_id, activity_id, activity_instance_id, lifecycle_id, timestamp, resource_id, ...) {
	suppressWarnings({
	eventlog(eventlog,
			 case_id = case_id,
			 activity_id = activity_id,
			 activity_instance_id = activity_instance_id,
			 lifecycle_id = lifecycle_id,
			 timestamp = timestamp,
			 resource_id = resource_id) -> eventlog
	})
	suppressMessages({fixed <- invisible(fix_resource_inconsistencies(eventlog, ..., details = F))})
	if(!is.null(fixed))
		eventlog <- fixed

	events_to_activitylog(eventlog)

}

#' @export

events_to_activitylog.eventlog <- function(eventlog, case_id = NULL, activity_id = NULL, activity_instance_id = NULL, lifecycle_id = NULL, timestamp = NULL, resource_id = NULL, ...) {

	.order <- NULL

	if(!is.null(suppressMessages(detect_resource_inconsistencies(eventlog)))) {
		stop("Eventlog contains resource inconsistencies. First use fix_resource_inconsistencies to fix problem")
	}

	eventlog <- standardize_lifecycle(eventlog)

	eventlog %>%
		select(-.order, force_df = TRUE) %>%
		spread(!!lifecycle_id_(eventlog), !!timestamp_(eventlog)) -> activitylog


	### Check if the columns start and complete exist. If not, initiate them to NA
	if(!("start" %in% colnames(activitylog))){
		warning("No start events were found. Creating and initialising 'start' to NA.")
		activitylog$start <- lubridate::NA_POSIXct_
	}
	if(!("complete" %in% colnames(activitylog))){
		warning("No complete events were found. Creating and initialising 'complete' to NA.")
		activitylog$complete <- lubridate::NA_POSIXct_
	}

	activitylog(as.data.frame(activitylog),
				case_id = case_id(eventlog),
				activity_id = activity_id(eventlog),
				resource_id = resource_id(eventlog),
				lifecycle_ids = as.vector(c("start","complete", str_subset(lifecycle_labels(eventlog), c("(start)|(complete)"), negate = T)))
	)


}
