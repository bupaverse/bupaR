#' @title Group event log
#' @name group_by
#' @param .data Object of class eventlog or activitylog
#' @param ... Variables to group by
#' @param add Add grouping variables to existing ones
#' @importFrom dplyr group_by
#' @export
dplyr::group_by
#' @export
group_by.eventlog <- function(.data, ..., .add = F) {


	mapping <- mapping(.data)
	.data <- as.data.frame(.data)
	x <- group_by(.data, ..., .add = .add)
	class(x) <- c("grouped_eventlog","eventlog", class(x))

	return(x)

}

#' @export
group_by.activitylog <- function(.data, ..., .add = F) {

	mapping <- mapping(.data)
	.data <- as.data.frame(.data)
	x <- group_by(.data, ..., .add = .add)
	class(x) <- c("grouped_activitylog","activitylog", class(x))

	return(x)

}




