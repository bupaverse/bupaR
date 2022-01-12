
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




.end_activities_eventlog <- function(eventlog) {

	eventlog %>%
		group_by(!!as.symbol(case_id(eventlog))) %>%
		arrange(!!as.symbol(timestamp(eventlog))) %>%
		summarize(last_event = last(!!as.symbol(activity_id(eventlog)))) %>%
		group_by(!!as.symbol("last_event")) %>%
		summarize() -> r

	colnames(r)[colnames(r) == "last_event"] <- activity_id(eventlog)
	return(r)

}

.start_activities_eventlog <- function(eventlog) {


		eventlog %>%
		group_by(!!as.symbol(case_id(eventlog))) %>%
		arrange(!!as.symbol(timestamp(eventlog))) %>%
		summarize(first_event = first(!!as.symbol(activity_id(eventlog)))) %>%
		group_by(!!as.symbol("first_event")) %>%
		summarize() -> r

	colnames(r)[colnames(r) == "first_event"] <- activity_id(eventlog)
	return(r)

}

.end_activities_activitylog <- function(activitylog) {

	activitylog %>%
		group_by(!!as.symbol(case_id(eventlog))) %>%
		arrange(!!as.symbol(timestamp(eventlog))) %>%
		summarize(last_event = last(!!as.symbol(activity_id(eventlog)))) %>%
		group_by(!!as.symbol("last_event")) %>%
		summarize() -> r

	colnames(r)[colnames(r) == "last_event"] <- activity_id(eventlog)
	return(r)

}

.start_activities_activitylog <- function(activitylog) {

		eventlog %>%
		group_by(!!as.symbol(case_id(eventlog))) %>%
		arrange(!!as.symbol(timestamp(eventlog))) %>%
		summarize(first_event = first(!!as.symbol(activity_id(eventlog)))) %>%
		group_by(!!as.symbol("first_event")) %>%
		summarize() -> r

	colnames(r)[colnames(r) == "first_event"] <- activity_id(eventlog)
	return(r)

}
