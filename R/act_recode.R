#' @title Recode activity labels
#' @description Recode one or more activity labels through specifying their old and new label
#' @param eventlog An object of class \code{eventlog}.
#' @param ... A sequence of named character vectors of length one where the names gives the new label and the value gives the old label. Labels not mentioned will be left unchanged.
#' @seealso \code{\link{eventlog}}, \code{\link{activity_id}}, \code{\link{act_unite}}
#' @family Activity processing functions
#' @export act_recode
act_recode <- function(eventlog, ...) {
	UseMethod("act_recode")
}
#' @describeIn act_recode Recode activity labels of event log
#' @export
act_recode.eventlog <- function(eventlog, ...) {
	eventlog %>%
		mutate(!!as.symbol(activity_id(eventlog)) := forcats::fct_recode((!!as.symbol(activity_id(eventlog))), ...)) %>%
		return()
}
