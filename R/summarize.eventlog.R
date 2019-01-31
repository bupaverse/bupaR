
#' @title Summarize event log
#' @name summarize
#' @param .data Eventlog
#' @param ... Name-value pairs of summary functions
#' @importFrom dplyr summarize
#' @return
#' The summarize function returns a tible, no event log.
#' @export
dplyr::summarise

#' @describeIn summarize Summarize eventlog
#' @export
summarise.eventlog <- function(.data, ...) {
	.data %>%
		as.data.frame() %>%
		summarize(...)
}
#' @describeIn summarize Summarize eventlog
#' @export

summarise.grouped_eventlog <- function(.data, ...) {
	groups <- groups(.data)
	mapping <- mapping(.data)
	.data %>%
		as.data.frame() %>%
		group_by_at(vars(one_of(paste(groups)))) %>%
		summarize(...)

}
