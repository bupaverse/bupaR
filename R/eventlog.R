#' @title Eventlog
#'
#' @description A function to instantiate an object of class \code{eventlog} by specifying a
#' \code{data.frame} or \code{tbl_df} and appropriate case, activity and
#' timestamp classifiers.
#'
#'
#' @param eventlog The data object to be used as event log. This can be a
#' \code{data.frame} or \code{tbl_df}.
#'
#' @param case_id The case classifier of the event log.
#'
#' @param activity_id The activity classifier of the event log.
#'
#' @param activity_instance_id The activity instance classifier of the event log.
#'
#' @param lifecycle_id The life cycle classifier of the event log.
#'
#' @param timestamp The timestamp of the event log.
#'
#' @param resource_id The resource identifier of the event log.
#'
#' @seealso \code{\link{case_id}}, \code{\link{activity_id}},
#' \code{\link{activity_instance_id}},\code{\link{lifecycle_id}},
#'  \code{\link{timestamp}}
#'
#'
#' @export eventlog

eventlog <- function(eventlog,
					 case_id = NULL,
					 activity_id = NULL,
					 activity_instance_id = NULL,
					 lifecycle_id = NULL,
					 timestamp = NULL,
					 resource_id = NULL){

	eventlog <- tbl_df(as.data.frame(eventlog))

	class(eventlog) <- c("eventlog",class(eventlog))

	if(is.null(case_id)){
		if(!is.null(case_id(eventlog)))
			message("Recovered existing case_id")
		else
			stop("No case_id provided nor found")
	}
	else {
		if(!(case_id %in% colnames(eventlog)))
			stop("Case classifier not found")
		else
			attr(eventlog, "case_id") <- case_id
	}

	if(is.null(activity_id)){
		if(!is.null(activity_id(eventlog)))
			message("Recovered existing activity_id")
		else
			stop("No activity_id provided nor found")
	}
	else{
		if(!(activity_id %in% colnames(eventlog)))
			stop("Activity classifier not found")
		else
			attr(eventlog, "activity_id") <- activity_id
	}

	if(is.null(activity_instance_id)){
		if(!is.null(activity_instance_id(eventlog)))
			message("Recovered existing activity_instance_id")
		else
			stop("No activity instance id provided nor found")
	}
	else {
		if(!(activity_instance_id %in% colnames(eventlog)))
			stop("Activity instance id classifier not found")
		else
			attr(eventlog, "activity_instance_id") <- activity_instance_id
	}
	if(is.null(lifecycle_id)) {
		if(!is.null(lifecycle_id(eventlog)))
			message("Recovered existing lifecycle_id")
		else
			stop("No lifecycle id provided nor found")
	}
	else {
		if(!(lifecycle_id %in% colnames(eventlog)))
			stop("lifecycle id classifier not found")
		else
			attr(eventlog, "lifecycle_id") <- lifecycle_id
	}
	if(is.null(timestamp)) {
		if(!is.null(timestamp(eventlog)))
			message("Recovered existing timestamp")
		else
			stop("No timestamp provided nor found")
	}
	else {
		if(!(timestamp %in% colnames(eventlog)))
			stop("Timestamp classifier not found")
		else
			attr(eventlog, "timestamp") <- timestamp
	}
	if(is.null(resource_id)) {
		if(!is.null(resource_id(eventlog)))
			message("Recovered existing resource identifier")
		else {
			warning("No resource identifier provided nor found. Set to default: NA")
			attr(eventlog, "resource_id") <- NA
		}
	}
	else {
		if(!(resource_id %in% colnames(eventlog)))
			stop("Resource identifier not found")
		else
			attr(eventlog, "resource_id") <- resource_id
	}
	return(eventlog)
}



