
#' Convert eventlog object to activitylog object.
#'
#' @param eventlog Object of class eventlog to be converted to activitylog
#'
#' @export
#'

to_activitylog <- function(eventlog)
	UseMethod("to_activitylog")

#' @export

to_activitylog.eventlog <- function(eventlog) {

	.order <- NULL

	if(!is.null(suppressMessages(detect_resource_inconsistencies(eventlog)))) {
		stop("Eventlog contains resource inconsistencies. First use fix_resource_inconsistencies to fix problem")
	}
	mapping <- mapping(eventlog)
	eventlog <- standardize_lifecycle(eventlog)

	eventlog %>%
		as.data.frame() %>%
		group_by(.data[[activity_instance_id(eventlog)]]) %>%
		mutate(.order = min(.order)) %>%
		spread(.data[[lifecycle_id(eventlog)]], .data[[timestamp(eventlog)]]) -> activitylog


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
				case_id = case_id(mapping),
				activity_id = activity_id(mapping),
				resource_id = resource_id(mapping),
				timestamps = as.vector(c("start","complete", str_subset(lifecycle_labels(eventlog), c("(start)|(complete)"), negate = T))),
				order = ".order"
	)


}
