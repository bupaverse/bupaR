#' @title Generic filter function for eventlog
#' @description Generic filter function for eventlog
#'
#' `r lifecycle::badge("deprecated")`
#'
#' This function is deprecated as of bupaR version 0.5.0. Please use [filter] instead.
#'
#' @param eventlog Eventlog object
#' @param ... Filter conditions
#' @keywords internal
#' @export
filter_attributes <- function(eventlog, ...) {
	lifecycle::deprecate_warn("0.5.0", "filter_attributes()", "filter()")
	UseMethod("filter_attributes")
}

#' @describeIn filter_attributes Filter eventlog using attributes
#' @export

filter_attributes.eventlog <- function(eventlog, ...) {
	filter(eventlog, ...)

}

#' @describeIn filter_attributes Filter grouped eventlog using attributes
#' @export

filter_attributes.grouped_eventlog <- function(eventlog, ...) {
	filter(eventlog, ...)
}


#' @describeIn filter_attributes Filter eventlog using attributes
#' @export

filter_attributes.activitylog <- function(eventlog, ...) {
	filter(eventlog, ...)

}

#' @describeIn filter_attributes Filter grouped eventlog using attributes
#' @export

filter_attributes.grouped_activitylog <- function(eventlog, ...) {
	filter(eventlog, ...)
}

