


#' @title Ungroup event log
#' @name ungroup_eventlog
#' @description Remove groups from event log
#' @param log Eventlog
#' @export ungroup_eventlog
ungroup_eventlog <- function(log) {
	UseMethod("ungroup_eventlog")
}
#' @describeIn ungroup_eventlog Remove groups from event log
#' @export
ungroup_eventlog.eventlog <- function(log) {
	if (is_grouped_eventlog(log)) {
		log %>%
			as.data.frame %>%
			re_map(mapping(log))
	} else {
		log
	}
}

#' @describeIn ungroup_eventlog Remove groups from \code{\link{log}}.
#' @export
ungroup_eventlog.grouped_log <- function(log) {

	if (is.grouped_log(log)) {
		ungrouped <- log %>%
			as.data.frame() %>%
			re_map(mapping(log))

		return(ungrouped)
	}

	return(log)
}

