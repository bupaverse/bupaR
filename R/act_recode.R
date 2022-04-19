#' @title Recode activity labels
#' @description Recode one or more activity labels through specifying their old and new label
#' @param log An object of class \code{eventlog}.
#' @param eventlog Deprecated; please use \code{log} instead.
#' @param ... A sequence of named character vectors of length one where the names gives the new label and the value gives the old label. Labels not mentioned will be left unchanged.
#' @seealso \code{\link{eventlog}}, \code{\link{activity_id}}, \code{\link{act_unite}}
#' @family Activity processing functions
#' @export
act_recode <- function(log, ..., eventlog = deprecated()) {
	UseMethod("act_recode")
}
#' @describeIn act_recode Recode activity labels of event log
#' @export
act_recode.log <- function(log, ..., eventlog = deprecated()) {
	log <- lifecycle_warning_eventlog(log, eventlog)

	log %>%
		mutate(!!as.symbol(activity_id(log)) := forcats::fct_recode((!!as.symbol(activity_id(log))), ...))
}

#' @describeIn act_recode Recode activity labels of event log
#' @export

act_recode.grouped_log <- function(log, ..., eventlog = deprecated()) {
	log <- lifecycle_warning_eventlog(log, eventlog)

	apply_grouped_fun(log, act_recode, ..., .ignore_groups = TRUE)

}
