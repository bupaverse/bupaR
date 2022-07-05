#' Create event log from list of activity instances
#'
#' @description
#' `r lifecycle::badge("superseded")`
#'
#' This function is superseded. For new code we recommend using activitylog() to create an activitylog, and if needed to_eventlog() to transform it into an eventlog.
#'
#' @param activity_log A data.frame where each row is an activity instances
#' @param case_id Column name of the case identifier
#' @param activity_id Column name of the activity identifier
#' @param resource_id Column name of the resource identifier
#' @param timestamps A vector of column names containing different timestamp. To column names will be transformed to lifecycle identifiers
#' @inheritParams eventlog
#' @keywords internal
#' @export
activities_to_eventlog <- function(activity_log,
								   case_id,
								   activity_id,
								   resource_id,
								   timestamps,
								   order = "auto") {

	lifecycle::signal_stage(stage = "superseded", "activities_to_eventlog()")

	activitylog(activity_log,
				case_id = case_id,
				activity_id = activity_id,
				resource_id = resource_id,
				timestamps = timestamps,
				order = order) %>%
		to_eventlog()



}


