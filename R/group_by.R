#' @title Group event log
#' @name group_by
#' @param .data \code{\link{log}}: Object of class \code{\link{eventlog}} or \code{\link{activitylog}}.
#' @param ... Variables to group on
#' @inheritParams dplyr::group_by
#' @param .add Add grouping variables to existing ones
#' @importFrom dplyr group_by
#' @export
dplyr::group_by
#' @export
group_by.eventlog <- function(.data, ..., .add = F) {


	mapping <- mapping(.data)
	.data <- as.data.frame(.data)
	x <- group_by(.data, ..., .add = .add)
	class(x) <- c("grouped_eventlog", "grouped_log", "eventlog", "log", class(x))

	return(x)

}

#' @export
group_by.activitylog <- function(.data, ..., .add = F) {

	mapping <- mapping(.data)
	.data <- as.data.frame(.data)
	x <- group_by(.data, ..., .add = .add)
	class(x) <- c("grouped_activitylog","grouped_log","activitylog", "log", class(x))

	return(x)

}

#' @export

group_by.grouped_log <- function(.data, ..., .add = F) {
	mapping <- mapping(.data)
	groups <- groups(.data)
	#.data <- as.data.frame(.data)
	if(.add) {
	  x <- .data %>%
	    ungroup_eventlog() %>%
	    group_by(across(c(one_of(paste(groups)), ...))) 
	} else {
	  x <- .data %>%
	    ungroup_eventlog() %>%
	    group_by(...)
	}
	class(x) <- class(.data)

	return(x)
}




