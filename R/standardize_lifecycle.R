

#' Standardize format of lifecycle types
#'
#' @param eventlog The event log to be converted. An object of class
#' \code{eventlog}.
#' @export
#' @importFrom stringr str_to_lower
#' @importFrom dplyr count
#' @importFrom dplyr case_when
#' @importFrom glue glue
#'
standardize_lifecycle <- function(eventlog) {
	UseMethod("standardize_lifecycle")
}

#' @describeIn standardize_lifecycle Standardize lifecycle types for eventlog
#' @export


standardize_lifecycle.eventlog <- function(eventlog) {

	NEW_LC <- NULL

	if(all(lifecycle_labels(eventlog) %in% c("start","complete")))
		eventlog
	else {
		eventlog %>%
			mutate(NEW_LC = str_to_lower(!!lifecycle_id_(eventlog))) %>%
			mutate(NEW_LC = case_when(NEW_LC == "completed" ~ "complete",
									  NEW_LC == "started" ~ "start",
									  T ~ NEW_LC)) -> eventlog

		eventlog %>%
			filter(NEW_LC != !!lifecycle_id_(eventlog)) %>%
			count(!!lifecycle_id_(eventlog), NEW_LC) %>%
			mutate_all(as.character) -> changes

		if(nrow(changes) > 0) {
			message("Following lifecycles updated:")
			for(i in 1:nrow(changes)) {
				message(glue("{as.character(changes[i,1])} -> {changes[i,2]}"))
			}
		}
		eventlog %>%
			mutate(!!lifecycle_id_(eventlog) := NEW_LC) %>%
			select(-NEW_LC)
	}
}
