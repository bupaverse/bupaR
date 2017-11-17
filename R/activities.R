#' @title Activities
#'
#' @description Returns a \code{tbl_df}  containing a list of all activity types in the event log, with their absolute and relative frequency
#'
#' @param eventlog The event log to be used. An object of class
#' \code{eventlog}.
#'
#' @seealso \code{\link{activity_id}},\code{\link{activity_instance_id}}, \code{\link{eventlog}}
#'
#' @export activities
#'
activities <- function(eventlog) {
	UseMethod("activities")
}

#' @describeIn activities Generate activity list for eventlog
#' @export

activities.eventlog <- function(eventlog) {
	stop_eventlog(eventlog)

	output <- eventlog %>%
		group_by(!!as.symbol(activity_id(eventlog))) %>%
		summarize("absolute_frequency" = n_distinct(!!as.symbol(activity_instance_id(eventlog)))) %>%
		arrange(-!!as.symbol("absolute_frequency")) %>%
		mutate("relative_frequency" := (!!as.symbol("absolute_frequency"))/sum( (!!as.symbol("absolute_frequency"))))
	return(output)
}

#' @describeIn activities Generate activity list for grouped eventlog
#' @export

activities.grouped_eventlog <- function(eventlog) {
	mapping <- mapping(eventlog)

	eventlog %>%
		nest() %>%
		mutate(data = map(data, re_map, mapping)) %>%
		mutate(data = map(data, activities)) %>%
		unnest() %>%
		return()
}

