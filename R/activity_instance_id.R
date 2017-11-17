#' @title Activity instance classifier
#' @description Get the activity instance classifier of an object of class \code{eventlog}.
#' @param x An \code{eventlog} of \code{eventlog_mapping}
#' @family Eventlog classifiers
#' @export
activity_instance_id <- function(x){
	UseMethod("activity_instance_id")
}
#' @describeIn activity_instance_id Retrieve activity instance identifier from eventlog
#' @export

activity_instance_id.eventlog <- function(x){
	return(attr(x, "activity_instance_id"))
}

#' @describeIn activity_instance_id Retrieve activity instance identifier from eventlog mapping
#' @export

activity_instance_id.eventlog_mapping <- function(x){
	return(x$activity_instance_id)
}

