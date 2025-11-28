
#' Set timestamp of eventlog
#'
#' @inheritParams act_collapse
#' @param timestamp New timestamp
#' @family Classifiers

#'
#' @export
#'
set_timestamp <- function(log, timestamp) {
	UseMethod("set_timestamp")
}
#'
#' @describeIn set_timestamp Set timestamp of eventlog
#' @export
set_timestamp.eventlog <- function(log, timestamp) {
	set_id(log, "timestamp", timestamp)
}
