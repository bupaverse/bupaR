

#' @title Resources
#'
#' @description Returns a \code{tbl_df}  containing a list of all resources in the event log, with there absolute and relative frequency
#'
#' @param eventlog The event log to be used. An object of class
#' \code{eventlog}.
#'
#'
#' @seealso \code{\link{resource_id}}, \code{\link{eventlog}}
#'
#'
#' @export resources

resources <- function(eventlog) {
	UseMethod("resources")
}

#' @describeIn resources Generate resource list for eventlog
#' @export

resources.eventlog <- function(eventlog) {

	absolute_frequency <- NULL
	relative_frequency <- NULL

	output <- eventlog %>%
		group_by_(resource_id(eventlog)) %>%
		summarize("absolute_frequency" = n_distinct(!!as.symbol(activity_instance_id(eventlog)))) %>%
		arrange(-absolute_frequency) %>%
		mutate(relative_frequency = absolute_frequency/sum(absolute_frequency)) %>%
		arrange(-relative_frequency)

	return(output)
}
#' @describeIn resources Generate resource list for grouped eventlog
#' @export
resources.grouped_eventlog <- function(eventlog) {
	mapping <- mapping(eventlog)

	eventlog %>%
		nest() %>%
		mutate(data = map(data, re_map, mapping)) %>%
		mutate(data = map(data, resources)) %>%
		unnest() %>%
		return()
}
