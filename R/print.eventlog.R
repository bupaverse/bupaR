#' @title Generic print function for eventlog
#' @description Generic print function for eventlog
#' @param x Eventlog object
#' @param ... Additional Arguments
#' @method print eventlog
#' @export

print.eventlog <- function(x, ...) {
	log <- x
	cat("Event log consisting of:\n")
	cat(paste(n_events(x), "events\n", sep = " "))
	cat(paste(nrow(traces_light(x)), "traces\n", sep = " "))
	cat(paste(n_cases(x), "cases\n", sep = " "))
	cat(paste(n_activities(x), "activities\n", sep = " "))
	cat(paste(n_activity_instances(x), "activity instances\n\n", sep = " "))
	NextMethod(x)
}
