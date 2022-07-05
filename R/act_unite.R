#' @title Unite activity labels
#' @description Recode two or different more activity labels two a uniform activity label
#' @inheritParams act_collapse
#' @param ... A series of named character vectors. The activity labels in each vector will be replaced with the name.
#' @seealso \code{\link{eventlog}}, \code{\link{activity_id}}, \code{\link{act_recode}}
#' @family Activity processing functions
#' @export act_unite
act_unite <- function(log, ..., eventlog = deprecated()) {
	UseMethod("act_unite")
}
#' @describeIn act_unite Unite activity labels in event log
#' @export
act_unite.log <- function(log, ..., eventlog = deprecated()) {
	log <- lifecycle_warning_eventlog(log, eventlog)
	log %>%
		mutate(!!activity_id(log) := forcats::fct_collapse((!!as.symbol(activity_id(log))), ...))
}

#' @describeIn act_unite Unite activity labels of event log
#' @export

act_unite.grouped_log <- function(log, ..., eventlog = deprecated()) {
	log <- lifecycle_warning_eventlog(log, eventlog)

	apply_grouped_fun(log, act_unite, ..., .ignore_groups = TRUE)

}


