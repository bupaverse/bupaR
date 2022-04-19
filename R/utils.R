
#' @export
magrittr::`%>%`

#' @importFrom rlang sym
#'
case_id_ <- function(eventlog) sym(case_id(eventlog))
activity_id_ <- function(eventlog) sym(activity_id(eventlog))
activity_instance_id_ <- function(eventlog) sym(activity_instance_id(eventlog))
resource_id_ <- function(eventlog) sym(resource_id(eventlog))
timestamp_ <- function(eventlog) sym(timestamp(eventlog))
lifecycle_id_ <- function(eventlog) sym(lifecycle_id(eventlog))


is_eventlog <- function(eventlog) {
	"eventlog" %in% class(eventlog)
}

is_grouped_eventlog <- function(eventlog) {
	"grouped_eventlog" %in% class(eventlog)
}

.start_activities_eventlog <- function(eventlog) {
	aid <- activity_id(eventlog)
	eventlog %>%
		group_by(.data[[case_id(eventlog)]]) %>%
		arrange(.data[[timestamp(eventlog)]], .data[[".order"]]) %>%
		summarize({{aid}} := first(.data[[activity_id(eventlog)]])) %>%
		distinct(.data[[aid]])
}

.end_activities_eventlog <- function(eventlog) {
	aid <- activity_id(eventlog)
	eventlog %>%
		group_by(.data[[case_id(eventlog)]]) %>%
		arrange(.data[[timestamp(eventlog)]], .data[[".order"]]) %>%
		summarize({{aid}} := last(.data[[activity_id(eventlog)]])) %>%
		distinct(.data[[aid]])

}

.start_activities_activitylog <- function(activitylog) {

	aid <- activity_id(activitylog)
	activitylog %>%
		group_by(.data[[case_id(activitylog)]]) %>%
		arrange(.data[["start"]], .data[["complete"]],  .data[[".order"]]) %>%
		summarize({{aid}} := first(.data[[activity_id(activitylog)]])) %>%
		distinct(.data[[aid]])

}

.end_activities_activitylog <- function(activitylog) {

	aid <- activity_id(activitylog)
	activitylog %>%
		group_by(.data[[case_id(activitylog)]]) %>%
		arrange(.data[["start"]], .data[["complete"]], .data[[".order"]]) %>%
		summarize({{aid}} := last(.data[[activity_id(activitylog)]])) %>%
		distinct(.data[[aid]])
}



# Warning: The `eventlog` argument of `func()` is deprecated as of bupaR 0.5.0.
# Please use the `log` argument instead.
# WARNING: Works only on exported functions!
lifecycle_warning_eventlog <- function (log, eventlog = deprecated()) {

	if(lifecycle::is_present(eventlog)) {
		cl <- sys.call(-1L)
		func <- get(as.character(cl[[1L]]), mode = "function", envir = sys.frame(-2L))
		func_name <- match.call(definition = func, call = cl)[[1L]]

		lifecycle::deprecate_warn("0.5.0", paste0(func_name, "(eventlog)"), paste0(func_name, "(log)"))
		return(eventlog)
	}

	return(log)
}
