#' @title Get vector of activity labels
#' @description Retrieve a vector containing all unique activity labels
#' @inheritParams act_collapse
#' @export
activity_labels <- function(log, eventlog = deprecated()) {
	UseMethod("activity_labels")
}

#' @describeIn activity_labels Retrieve activity labels
#' @export
activity_labels.log <- function(log, eventlog = deprecated()) {

	log <- lifecycle_warning_eventlog(log, eventlog)

	log %>%
		ungroup() %>%
		pull(!!activity_id_(log)) %>%
		unique()
}
