#' @title Durations
#'
#' @description Computes the throughput times of each case.
#' Throughput time is defined as the interval between the start of the first event and the completion of the last event.
#'
#' @param eventlog The event log to be used. An object of class
#' \code{eventlog}.
#'
#' @param units The time unit in which the throughput times should be reported.
#'
#'
#' @examples
#'
#'
#' data(example_log)
#' durations(example_log)
#'
#' @export durations

durations <- function(eventlog,
					  units = "days") {
	stop_eventlog(eventlog)

	colnames(eventlog)[colnames(eventlog)==lifecycle_id(eventlog)] <- "life_cycle_classifier"
	colnames(eventlog)[colnames(eventlog)==case_id(eventlog)] <- "case_classifier"
	colnames(eventlog)[colnames(eventlog)==timestamp(eventlog)] <- "timestamp_classifier"

	e <- eventlog

	durations <- e %>% group_by(case_classifier) %>% summarize(s = min(timestamp_classifier), e = max(timestamp_classifier))

	durations$duration <- durations$e - durations$s
	durations$duration <- as.double(durations$duration, units = units)

	durations <- durations %>% select(case_classifier, duration) %>% arrange(desc(duration))

	colnames(durations)[colnames(durations)=="case_classifier"] <- case_id(eventlog)
	colnames(durations)[colnames(durations)=="duration"] <- paste("duration_in_", units, sep ="")

	durations <- tbl_df(durations)

	return(durations)

}
