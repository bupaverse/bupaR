

#' Case list
#'
#' Construct list of cases
#'
#' @param eventlog Eventlog object
#'
#' @export
#'
case_list <- function(eventlog) {
	UseMethod("case_list")
}

#' @describeIn case_list Return case list
#' @export


case_list.eventlog <- function(eventlog){

	eDT <- data.table::as.data.table(eventlog)
	cases <- eDT[,
				 list("timestamp_classifier" = min(get(timestamp(eventlog)))),
				 by = list("A" = get(case_id(eventlog)), "B" = get(activity_instance_id(eventlog)), "C" = get(activity_id(eventlog)))]
	cases <- cases[order(get("timestamp_classifier"), get("C")),
				   list(trace = paste(get("C"), collapse = ",")),
				   by = list("CASE" = get("A"))]
	cases <- cases %>% mutate(trace_id = as.numeric(factor(!!as.symbol("trace")))) %>%
		rename(!!as.symbol(case_id(eventlog)) := "CASE")

	cases %>%
		as.data.frame %>%
		tbl_df
}
