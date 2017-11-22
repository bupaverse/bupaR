#' @title Generic filter function for eventlog
#' @description Generic filter function for eventlog
#' @param eventlog  Eventlog object
#' @param ... Filter conditions
#' @export
filter_attributes <- function(eventlog, ...) {
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


