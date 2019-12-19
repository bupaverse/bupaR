#' @title Life cycles
#'
#' @description Returns a \code{tbl_df}  containing a list of all life cycle types in the event log, with their absolute and relative frequency (# events)
#'
#' @param eventlog The event log to be used. An object of class
#' \code{eventlog}.
#'
#' @seealso \code{\link{lifecycle_id}}, \code{\link{eventlog}}
#'
#' @export
#'
lifecycles <- function(eventlog) {
	UseMethod("lifecycles")
}

#' @describeIn lifecycles Generate lifecycle list for eventlog
#' @export

lifecycles.eventlog <- function(eventlog) {

	eventlog %>%
		group_by(!!lifecycle_id_(eventlog)) %>%
		summarize("absolute_frequency" = n()) %>%
		arrange(-!!as.symbol("absolute_frequency")) %>%
		mutate("relative_frequency" := (!!as.symbol("absolute_frequency"))/sum( (!!as.symbol("absolute_frequency"))))
}

#' @describeIn lifecycles Generate lifecycle list for grouped eventlog
#' @export

lifecycles.grouped_eventlog <- function(eventlog) {
	mapping <- mapping(eventlog)

	eventlog %>%
		nest() %>%
		mutate(data = map(data, re_map, mapping)) %>%
		mutate(data = map(data, activities)) %>%
		unnest()
}

#' @title Get vector of lifecycle labels
#' @description Retrieve a vector containing all unique lifecycle labels
#' @param eventlog Eventlog
#' @export
lifecycle_labels <- function(eventlog) {
	UseMethod("lifecycle_labels")
}

#' @describeIn lifecycle_labels Retrieve lifecycle labels from eventlog
#' @export
lifecycle_labels.eventlog <- function(eventlog) {
	eventlog %>%
		ungroup() %>%
		pull(!!lifecycle_id_(eventlog)) %>%
		unique()
}



