


#' @title Ungroup event log
#' @name ungroup_eventlog
#' @description Remove groups from event log
#' @param eventlog Eventlog
#' @export ungroup_eventlog
ungroup_eventlog <- function(eventlog) {
	UseMethod("ungroup_eventlog")
}
#' @describeIn ungroup_eventlog Remove groups from event log
#' @export
ungroup_eventlog.eventlog <- function(eventlog) {
	if (is_grouped_eventlog(eventlog)) {
		eventlog %>%
			as.data.frame %>%
			re_map(mapping(eventlog))
	} else {
		eventlog
	}
}
