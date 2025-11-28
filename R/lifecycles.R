#' @title Life cycles
#'
#' @description Returns a \code{\link[dplyr]{tibble}} containing a list of all life cycle types in the log,
#' with their absolute and relative frequency (# events).
#'
#' @inheritParams act_collapse
#'
#' @seealso \code{\link{lifecycle_id}}
#'
#' @export
lifecycles <- function(log) {
	UseMethod("lifecycles")
}

#' @describeIn lifecycles Generate lifecycle list for an \code{\link{eventlog}}.
#' @export
lifecycles.eventlog <- function(log) {

	log %>%
		group_by(!!lifecycle_id_(log)) %>%
		summarize("absolute_frequency" = n()) %>%
		arrange(-!!as.symbol("absolute_frequency")) %>%
		mutate("relative_frequency" := (!!as.symbol("absolute_frequency"))/sum( (!!as.symbol("absolute_frequency"))))
}

#' @describeIn lifecycles Generate lifecycle list for a \code{\link{grouped_eventlog}}.
#' @export
lifecycles.grouped_eventlog <- function(log) {

	mapping <- mapping(log)

	apply_grouped_fun(log, lifecycles.eventlog)
}

#' @describeIn lifecycles Generate lifecycle list for an \code{\link{activitylog}}.
#' @export
lifecycles.activitylog <- function(log) {

	lifecycles.eventlog(to_eventlog(log))
}

#' @describeIn lifecycles Generate lifecycle list for an \code{\link{grouped_activitylog}}.
#' @export
lifecycles.grouped_activitylog <- function(log) {

	apply_grouped_fun(to_eventlog(log), lifecycles.eventlog)
}
