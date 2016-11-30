#' @title Generic summary function for eventlog class
#' @description Generic summary function for eventlog class
#' @param object Eventlog object
#' @param ... Additional Arguments
#' @method summary eventlog
#' @export

summary.eventlog <- function(object, ...){

	eventlog <- object

	ca <- cases_light(eventlog)

	number_of_events <- nrow(eventlog)
	number_of_cases <- nrow(ca)
	number_of_traces <- length(unique(ca$trace_id))
	number_of_activities <- nrow(activities(eventlog))


	colnames(eventlog)[colnames(eventlog)==timestamp(eventlog)] <- "timestamp_classifier"

	first_event <- as.character(arrange(eventlog, timestamp_classifier)$timestamp_classifier[1])
	last_event <- as.character(arrange(eventlog, timestamp_classifier)$timestamp_classifier[nrow(eventlog)])

	events_per_case <- number_of_events/number_of_cases

	cat("Number of events:  ")
	cat(number_of_events)
	cat("\nNumber of cases:  ")
	cat(number_of_cases)
	cat("\nNumber of traces:  ")
	cat(number_of_traces)
	cat("\nNumber of distinct activities:  ")
	cat(number_of_activities)
	cat("\nAverage trace length:  ")
	cat(events_per_case)
	cat("\n\nStart eventlog:  ")
	cat(first_event)
	cat("\nEnd eventlog:  ")
	cat(last_event)
	cat("\n\n")
	NextMethod(object)

}
