
#' @export
magrittr::`%>%`



cases_light <- function(eventlog){
	if(!("eventlog" %in% class(eventlog)))
		stop("Function only applicable for eventlog object")

	eDT <- data.table::as.data.table(eventlog)
	cases <- eDT[,
				 list("timestamp_classifier" = min(get(timestamp(eventlog)))),
				 by = list("A" = get(case_id(eventlog)), "B" = get(activity_instance_id(eventlog)), "C" = get(activity_id(eventlog)))]
	cases <- cases[order(get("timestamp_classifier"), get("C")),
				   list(trace = paste(get("C"), collapse = ",")),
				   by = list("CASE" = get("A"))]
	cases <- cases %>% mutate(trace_id = as.numeric(factor(!!as.symbol("trace")))) %>%
		rename(!!as.symbol(case_id(eventlog)) := "CASE")
	#	cases <- eventlog %>%
	#		group_by(case_classifier, activity_instance_classifier, event_classifier) %>%
	#		summarize(timestamp_classifier = min(timestamp_classifier)) %>%
	#		group_by(case_classifier) %>%
	#		arrange(timestamp_classifier) %>%
	#		summarize(trace = paste(event_classifier, collapse = ",")) %>%
	#		mutate(trace_id = as.numeric(factor(trace)))

	casesDT <- data.table(cases)
	cases <- cases %>% data.frame

	#traces <- cases %>%
	#	group_by(trace, trace_id) %>%
	#	summarize(absolute_frequency = n()) %>%
	#	ungroup() %>%
	#	arrange(desc(absolute_frequency)) %>%
	#	mutate(relative_frequency = absolute_frequency/sum(absolute_frequency))


		return(cases)

}


traces_light <- function(eventlog){



	eDT <- data.table::data.table(eventlog)

		cases <- eDT[,
				 list("timestamp_classifier" = min(get(timestamp(eventlog)))),
				 by = list("A" = get(case_id(eventlog)), "B" = get(activity_instance_id(eventlog)), "C" = get(activity_id(eventlog)))]
	cases <- cases[order(get("timestamp_classifier"), get("C")),
				   list(trace = paste(get("C"), collapse = ",")),
				   by = list("CASE" = get("A"))]
	cases <- cases %>% mutate(trace_id = as.numeric(factor(!!as.symbol("trace")))) %>%
		rename(!!as.symbol(case_id(eventlog)) := "CASE")

	#	cases <- eventlog %>%
	#		group_by(case_classifier, activity_instance_classifier, event_classifier) %>%
	#		summarize(timestamp_classifier = min(timestamp_classifier)) %>%
	#		group_by(case_classifier) %>%
	#		arrange(timestamp_classifier) %>%
	#		summarize(trace = paste(event_classifier, collapse = ",")) %>%
	#		mutate(trace_id = as.numeric(factor(trace)))


	.N <- NULL
	absolute_frequency <- NULL
	relative_frequency <- NULL

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
