
#' @export
magrittr::`%>%`

load <- c("edeaR","petrinetR")

.onAttach <- function(...) {
	needed <- load[!is_attached(load)]

	if (length(needed) == 0)
		return()

	packageStartupMessage(paste0("Loading bpaR: ", needed, collapse = "\n"))
	lapply(needed, library, character.only = TRUE, warn.conflicts = FALSE)

}

is_attached <- function(x) {
	paste0("package:", x) %in% search()
}


cases_light <- function(eventlog){
	if(!("eventlog" %in% class(eventlog)))
		stop("Function only applicable for eventlog object")

	traces(eventlog, output_traces = FALSE, output_cases = TRUE)
}


traces_light <- function(eventlog){

	colnames(eventlog)[colnames(eventlog) == case_id(eventlog)] <- "case_classifier"
	colnames(eventlog)[colnames(eventlog) == activity_id(eventlog)] <- "event_classifier"
	colnames(eventlog)[colnames(eventlog) == timestamp(eventlog)] <- "timestamp_classifier"
	colnames(eventlog)[colnames(eventlog) == activity_instance_id(eventlog)] <- "activity_instance_classifier"

	eDT <- data.table::data.table(eventlog)

	cases <- eDT[,
				 .(timestamp_classifier = min(timestamp_classifier)),
				 by = .(case_classifier, activity_instance_classifier,  event_classifier)]

	cases <- cases[order(timestamp_classifier), .(trace = paste(event_classifier, collapse = ",")),
				   by = .(case_classifier)]

	#	cases <- eventlog %>%
	#		group_by(case_classifier, activity_instance_classifier, event_classifier) %>%
	#		summarize(timestamp_classifier = min(timestamp_classifier)) %>%
	#		group_by(case_classifier) %>%
	#		arrange(timestamp_classifier) %>%
	#		summarize(trace = paste(event_classifier, collapse = ",")) %>%
	#		mutate(trace_id = as.numeric(factor(trace)))


	casesDT <- data.table(cases)

	traces <- casesDT[, .(absolute_frequency = .N), by = .(trace)]

	traces <- traces[order(absolute_frequency, decreasing = T),relative_frequency:=absolute_frequency/sum(absolute_frequency)]
	traces <- tbl_df(traces)

	#traces <- eventlog %>%
	#	group_by(case_classifier, activity_instance_classifier, event_classifier) %>%
	#	summarize(timestamp_classifier = min(timestamp_classifier)) %>%
	#	group_by(case_classifier) %>%
	#	arrange(timestamp_classifier) %>%
	#	summarize(trace = paste(event_classifier, collapse = ",")) %>%
	#	group_by(trace) %>%
	#	summarize()

	return(traces)

}

summary_statistics <- function(vector) {


	s <- summary(vector)
	s <- c(s, St.Dev = sd(vector))
	s <- c(s, IQR = s[5] - s[2])
	names(s) <- c("min","q1","median","mean","q3","max","st_dev","iqr")
	s <- as.data.frame(s)
	s <- t(s)
	row.names(s) <- NULL

	return(s)
}

stop_eventlog <- function(eventlog)
	if(!("eventlog" %in% class(eventlog)))
		stop("Function only applicable for class eventlog")
