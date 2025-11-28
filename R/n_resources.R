#' @title n_resources
#'
#' @description Returns the number of resources in an event log
#' @inheritParams act_collapse
#' @family Counters
#' @export

n_resources <- function(log) {
	UseMethod("n_resources")
}


#' @describeIn n_resources Count number of resources in log
#' @export

n_resources.log <- function(log) {
	length(unique(log[[resource_id(log)]]))
}

#' @describeIn n_resources Count number of resources in grouped log
#' @export
n_resources.grouped_log <- function(log) {
	log %>%
		summarize(n_resources = n_distinct(.data[[resource_id(log)]])) %>%
		return()
}

