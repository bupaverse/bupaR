
#' Set timestamp of eventlog
#'
#' @param log \code{\link{log}}: Object of class \code{\link{eventlog}}.
#' @param eventlog Deprecated; please use \code{log} instead.
#' @param timestamp New timestamp
#'
#'
#' @export
#'
set_timestamp <- function(log, timestamp, eventlog = deprecated()) {
	UseMethod("set_timestamp")
}
#'
#' @describeIn set_timestamp Set timestamp of eventlog
#' @export
set_timestamp.eventlog <- function(log, timestamp, eventlog = deprecated()) {
	log <- lifecycle_warning_eventlog(log, eventlog)
	set_id(log, "timestamp", timestamp)
}
