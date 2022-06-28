
#' @title Summarize event log
#' @name summarize
#' @param .data \code{\link{log}}: Object of class \code{\link{eventlog}} or \code{\link{activitylog}}
#' @param ... Name-value pairs of summary functions
#' @importFrom dplyr summarize
#' @return
#' The summarize function returns a tible, no event log.
#' @export
dplyr::summarise

#' @export
summarise.eventlog <- function(.data, ...) {
	#warning("Calling summarize on eventlog object returns tibble.")
	.data %>%
		as.data.frame() %>%
		summarize(...) %>%
		as_tibble()
}
#' @export

summarise.grouped_eventlog <- function(.data, ...) {
	#warning("Calling summarize on eventlog object returns tibble.")
	groups <- groups(.data)
	mapping <- mapping(.data)
	.data %>%
		as.data.frame() %>%
		group_by_at(vars(one_of(paste(groups)))) %>%
		summarize(...) %>%
		as_tibble()

}

#' @export
summarise.activitylog <- function(.data, ...) {
	#warning("Calling summarize on activitylog object returns tibble.")
	.data %>%
		as.data.frame() %>%
		summarize(...) %>%
		as_tibble()
}
#' @export

summarise.grouped_activitylog <- function(.data, ...) {
	#warning("Calling summarize on activitylog object returns tibble.")
	groups <- groups(.data)
	mapping <- mapping(.data)
	.data %>%
		as.data.frame() %>%
		group_by_at(vars(one_of(paste(groups)))) %>%
		summarize(...) %>%
		as_tibble()

}
