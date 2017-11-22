#' Trace list
#'
#' Construct trace list
#'
#' @param eventlog Eventlog object
#'
#' @export
#'

trace_list <- function(eventlog){
	UseMethod("trace_list")
}

#' @describeIn trace_list Construct trace list for event log
#' @export

trace_list.eventlog <- function(eventlog){

	eDT <- data.table::data.table(eventlog)

	cases <- eDT[,
				 list("timestamp_classifier" = min(get(timestamp(eventlog)))),
				 by = list("A" = get(case_id(eventlog)), "B" = get(activity_instance_id(eventlog)), "C" = get(activity_id(eventlog)))]
	cases <- cases[order(get("timestamp_classifier"), get("C")),
				   list(trace = paste(get("C"), collapse = ",")),
				   by = list("CASE" = get("A"))]
	cases <- cases %>% mutate(trace_id = as.numeric(factor(!!as.symbol("trace")))) %>%
		rename(!!as.symbol(case_id(eventlog)) := "CASE")

	.N <- NULL
	absolute_frequency <- NULL
	relative_frequency <- NULL

	casesDT <- data.table(cases)

	traces <- casesDT[, .(absolute_frequency = .N), by = .(trace)]

	traces <- traces[order(absolute_frequency, decreasing = T),relative_frequency:=absolute_frequency/sum(absolute_frequency)]
	traces %>%
		tbl_df

}
