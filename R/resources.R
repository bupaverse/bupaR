

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
	stop_eventlog(eventlog)
	colnames(eventlog)[colnames(eventlog) == activity_instance_id(eventlog)] <- "activity_instance_classifier"

	output <- eventlog %>%
		group_by_(resource_id(eventlog)) %>%
		summarize("absolute_frequency" = n_distinct(activity_instance_classifier)) %>%
		arrange(-absolute_frequency) %>%
		mutate(relative_frequency = absolute_frequency/sum(absolute_frequency)) %>%
		arrange(-relative_frequency)

	return(output)
}
