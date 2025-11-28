#' @title n_activities
#'
#' @description Returns the number of activities in an event log
#' @inheritParams act_collapse
#' @family Counters
#' @export

n_activities <- function(log) {
	UseMethod("n_activities")
}

#' @describeIn n_activities Count the number of activities in a log
#' @export


n_activities.log <- function(log){
	length(unique(log[[activity_id(log)]]))
}

#' @describeIn n_activities Count the number of activities for a grouped  log
#' @export
n_activities.grouped_log <- function(log) {
  log %>%
		summarize(n_activities = n_distinct(.data[[activity_id(log)]]))
}


