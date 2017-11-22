#' @title Unite activity labels
#' @description Recode two or different more activity labels two a uniform activity label
#' @param eventlog An object of class \code{eventlog}.
#' @param ... A series of named character vectors. The activity labels in each vector will be replaced with the name.
#' @seealso \code{\link{eventlog}}, \code{\link{activity_id}}, \code{\link{act_recode}}
#' @family Activity processing functions
#' @export act_unite
act_unite <- function(eventlog, ...) {
	UseMethod("act_unite")
}
#' @describeIn act_unite Unite activity labels in event log
#' @export
act_unite.eventlog <- function(eventlog, ...) {
	eventlog %>%
		mutate(!!activity_id(eventlog) := forcats::fct_collapse((!!as.symbol(activity_id(eventlog))), ...)) %>%
		return()
}




