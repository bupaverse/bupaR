
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

#' as.grouped.data.frame
#'
#' @param data Data
#' @param groups Names of grouping variables as character vector (e.g. by using \code{dplyr::group_vars}
as.grouped.data.frame <- function(data, groups) {

	data %>%
		as.data.frame() %>%
		dplyr::group_by_at(groups)
}

apply_grouped <- function(log, fun) {
	mapping <- mapping(log)
	log %>%
		nest() %>%
		mutate(data = map(data, re_map, mapping)) %>%
		mutate(data = map(data, fun)) %>%
		unnest(cols = data)
}


#' @importFrom lubridate ymd_hms
#' @export
lubridate::ymd_hms
#' @importFrom lubridate ymd_hm
#' @export
lubridate::ymd_hm
#' @importFrom lubridate ymd_h
#' @export
lubridate::ymd_h
#' @importFrom lubridate ymd
#' @export
lubridate::ymd
#' @importFrom lubridate dmy_hms
#' @export
lubridate::dmy_hms
#' @importFrom lubridate dmy_hm
#' @export
lubridate::dmy_hm
#' @importFrom lubridate dmy_h
#' @export
lubridate::dmy_h
#' @importFrom lubridate dmy
#' @export
lubridate::dmy
#' @importFrom lubridate mdy_hms
#' @export
lubridate::mdy_hms
#' @importFrom lubridate mdy_hm
#' @export
lubridate::mdy_hm
#' @importFrom lubridate mdy_h
#' @export
lubridate::mdy_h
#' @importFrom lubridate mdy
#' @export
lubridate::mdy



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

group_by_ids <- function(.log, ...) {

	ids <- list(...)

	for(i in 1:length(ids)) {
		ids[[i]] <- ids[[i]](.log)
	}
	group_by(.log, across(paste(ids)))
}


select_ids <- function(.log, ...) {

	ids <- list(...)

	for(i in 1:length(ids)) {
		ids[[i]] <- ids[[i]](.log)
	}
	select(.log, all_of(unlist(ids)), force_df = TRUE)
}


# Warning: The `eventlog` argument of `func()` is deprecated as of bupaR 0.5.0.
# Please use the `log` argument instead.
# WARNING: Works only on exported functions!
lifecycle_warning_eventlog <- function (log, eventlog = deprecated()) {

	cl <- sys.call(-1L)
	func <- get(as.character(cl[[1L]]), mode = "function", envir = sys.frame(-2L))
	func_name <- match.call(definition = func, call = cl)[[1L]]

	if(lifecycle::is_present(eventlog)) {
		lifecycle::deprecate_warn("0.5.0", paste0(func_name, "(eventlog)"), paste0(func_name, "(log)"))
		return(eventlog)
	}

	return(log)
}
