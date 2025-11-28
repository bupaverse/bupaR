#' @title Resources
#' @description Returns a \code{tibble}  containing a list of all resources in the event log, with their absolute and relative frequency
#' @inheritParams act_collapse
#' @seealso \code{\link{resource_id}}, \code{\link{eventlog}}
#' @export resources

resources <- function(log) {
	UseMethod("resources")
}

#' @describeIn resources Generate resource list for eventlog
#' @export

resources.eventlog <- function(log) {

	absolute_frequency <- NULL
	relative_frequency <- NULL

	output <- log %>%
		group_by(!!as.symbol(resource_id(log))) %>%
		summarize("absolute_frequency" = n_distinct(!!as.symbol(activity_instance_id(log)))) %>%
		arrange(-absolute_frequency) %>%
		mutate(relative_frequency = absolute_frequency/sum(absolute_frequency)) %>%
		arrange(-relative_frequency)

	return(output)
}
#' @describeIn resources Generate resource list for activitylog
#' @export

resources.activitylog <- function(log) {
	resources.eventlog(to_eventlog(log))
}
#' @describeIn resources Compute activity frequencies
#' @export
#'
resources.grouped_log <- function(log) {
	apply_grouped_fun(log, resources)
}



