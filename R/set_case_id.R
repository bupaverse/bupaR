
#' Set case id of log
#'
#' @param log \code{\link{log}}: Object of class \code{\link{log}}, \code{\link{eventlog}}, or \code{\link{activitylog}}.
#' @param eventlog Deprecated; please use \code{log} instead.
#' @param case_id New case id
#'
#'
#' @export
#'
set_case_id <- function(log, case_id, eventlog = deprecated()) {
	UseMethod("set_case_id")
}
#'
#' @describeIn set_case_id Set case id
#' @export
set_case_id.default <- function(log, case_id, eventlog = deprecated()) {
	log <- lifecycle_warning_eventlog(log, eventlog)
	set_id(log, "case_id", case_id)
}
