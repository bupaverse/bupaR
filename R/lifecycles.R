#' @title Life cycles
#'
#' @description Returns a \code{\link{tibble}} containing a list of all life cycle types in the log,
#' with their absolute and relative frequency (# events).
#'
#' @param log \code{\link{log}}: Object of class \code{\link{log}}, \code{\link{eventlog}}, or \code{\link{activitylog}}.
#' @param eventlog `r lifecycle::badge("deprecated")`; please use \code{log} instead.
#'
#' @seealso \code{\link{lifecycle_id}}
#'
#' @export
lifecycles <- function(log, eventlog = deprecated()) {
	UseMethod("lifecycles")
}

#' @describeIn lifecycles Generate lifecycle list for an \code{\link{eventlog}}.
#' @export
lifecycles.eventlog <- function(log, eventlog = deprecated()) {

	log <- lifecycle_warning_eventlog(log, eventlog)

	log %>%
		group_by(!!lifecycle_id_(log)) %>%
		summarize("absolute_frequency" = n()) %>%
		arrange(-!!as.symbol("absolute_frequency")) %>%
		mutate("relative_frequency" := (!!as.symbol("absolute_frequency"))/sum( (!!as.symbol("absolute_frequency"))))
}

#' @describeIn lifecycles Generate lifecycle list for a \code{\link{grouped_eventlog}}.
#' @export
lifecycles.grouped_eventlog <- function(log, eventlog = deprecated()) {

	log <- lifecycle_warning_eventlog(log, eventlog)

	mapping <- mapping(log)

	apply_grouped_fun(log, lifecycles.eventlog)
}

#' @describeIn lifecycles Generate lifecycle list for an \code{\link{activitylog}}.
#' @export
lifecycles.activitylog <- function(log, eventlog = deprecated()) {

	log <- lifecycle_warning_eventlog(log, eventlog)

	lifecycles.eventlog(to_eventlog(log))
}

#' @describeIn lifecycles Generate lifecycle list for an \code{\link{grouped_activitylog}}.
#' @export
lifecycles.activitylog <- function(log, eventlog = deprecated()) {

	log <- lifecycle_warning_eventlog(log, eventlog)

	apply_grouped_fun(to_eventlog(log), lifecycles.eventlog)
}