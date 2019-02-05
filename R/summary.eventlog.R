#' @title Generic summary function for eventlog class
#' @description Generic summary function for eventlog class
#' @param object Eventlog object
#' @param ... Additional Arguments
#' @rdname summary
#' @method summary eventlog
#' @export

summary.eventlog <- function(object, ...){

	eventlog <- object

	ca <- case_list(eventlog)

	number_of_events <- nrow(eventlog)
	number_of_cases <- nrow(ca)
	number_of_traces <- length(unique(ca$trace_id))
	number_of_activities <- nrow(activities(eventlog))


	first_event <- as.character(min(pull(eventlog, !!as.symbol(timestamp(eventlog)))))
	last_event <- as.character(max(pull(eventlog, !!as.symbol(timestamp(eventlog)))))

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

#' @describeIn summary Summary of grouped event log
#' @export

summary.grouped_eventlog <- function(object, ...) {
	object <- eventlog(object, validate = FALSE)
	NextMethod(object)
}
