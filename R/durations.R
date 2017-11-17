#' @title Durations
#'
#' @description Computes the throughput times of each case.
#' Throughput time is defined as the interval between the start of the first event and the completion of the last event.
#'
#' @param eventlog The event log to be used. An object of class
#' \code{eventlog}.
#' @param units The time unit in which the throughput times should be reported.
#' @export durations
durations <- function(eventlog, units) {
	UseMethod("durations")
}
#' @describeIn durations Compute durations from eventlog
#' @export
durations.eventlog <- function(eventlog,
					  units = "days") {

	e <- eventlog

	durations <- e %>% group_by(!!as.symbol(case_id(eventlog))) %>% summarize(s = min(!!as.symbol(timestamp(eventlog))),
															   e = max(!!as.symbol(timestamp(eventlog))))

	durations$duration <- durations$e - durations$s
	durations$duration <- as.double(durations$duration, units = units)

	durations <- durations %>% select(one_of(c(case_id(eventlog), "duration"))) %>% arrange(desc(!!as.symbol("duration")))

	colnames(durations)[colnames(durations)=="duration"] <- paste("duration_in_", units, sep ="")

	durations <- tbl_df(durations)

	return(durations)

}
