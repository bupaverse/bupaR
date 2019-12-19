

#' Events to activities
#'
#' @param eventlog The event log to be converted. An object of class
#' \code{eventlog}.
#'
#' @export
#'

events_to_activitylog <- function(eventlog) {
	UseMethod("events_to_activitylog")
}

#' @export

events_to_activitylog.eventlog <- function(eventlog) {

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
		activitylog$start <- as.Date(NA)
	}
	if(!("complete" %in% colnames(activitylog))){
		warning("No complete events were found. Creating and initialising 'complete' to NA.")
		activitylog$complete <- as.Date(NA)
	}

	activitylog(as.data.frame(activitylog),
				case_id = case_id(eventlog),
				activity_id = activity_id(eventlog),
				resource_id = resource_id(eventlog),
				lifecycle_ids = as.vector(c("start","complete", str_subset(lifecycle_labels(eventlog), c("(start)|(complete)"), negate = T)))
	)


}
