#' @title Group event log
#' @name group_by
#' @param .data Eventlog
#' @param ... Variables to group by
#' @param add Add grouping variables to existing ones
#' @importFrom dplyr group_by
#' @export
dplyr::group_by
#' @describeIn group_by Group eventlog
#' @export
group_by.eventlog <- function(.data, ..., add = F) {


	mapping <- mapping(.data)
	x <- NextMethod(.data, ..., add = add)
	class(x) <- c("grouped_eventlog","eventlog", class(x))


	# map(groups, ~names(mapping)[.x == mapping]) %>%
	# 	.[lengths(.)>0] %>%
	# 	as.character() -> t
	# print(t)
	#
	# if(length(t) > 0) {
	# 	warning(glue::glue("Grouping includes mapped variables {paste(t, collapse = \", \")}.
	# 					   Might produce unexpected behavior. Use provided analysis levels instead."))
	# }

	return(x)

}
#' @title Group event log on case id
#' @description Group an event log by case identifier
#' @param eventlog Eventlog
#' @export group_by_case
group_by_case <- function(eventlog) {
	UseMethod("group_by_case")
}
#' @describeIn group_by_case Group eventlog on case identifier
#' @export
group_by_case.eventlog <- function(eventlog) {
	group_by(eventlog, !!as.symbol(case_id(eventlog)))
}
#' @title Group event log on activity id
#' @description Group an event log by activity identifier
#' @param eventlog Eventlog
#' @export group_by_activity
group_by_activity <- function(eventlog) {
	UseMethod("group_by_activity")
}
#' @describeIn group_by_activity Group eventlog on activity identifier
#' @export
group_by_activity.eventlog <- function(eventlog) {
	group_by(eventlog, !!as.symbol(activity_id(eventlog)))
}


#' @title Group event log on activity instance id
#' @description Group an event log by activity instance identifier
#' @param eventlog Eventlog
#' @export group_by_activity_instance
group_by_activity_instance <- function(eventlog) {
	UseMethod("group_by_activity_instance")
}
#' @describeIn group_by_activity_instance Group eventlog on activity instance identifier
#' @export
group_by_activity_instance.eventlog <- function(eventlog) {
	group_by(eventlog, !!as.symbol(activity_instance_id(eventlog)))
}



#' @title Group event log on resource id
#' @description Group an event log by resource identifier
#' @param eventlog Eventlog
#' @export group_by_resource
group_by_resource <- function(eventlog) {
	UseMethod("group_by_resource")
}
#' @describeIn group_by_resource Group eventlog on resource identifier
#' @export
group_by_resource.eventlog <- function(eventlog) {
	group_by(eventlog, !!as.symbol(resource_id(eventlog)))
}


#' @title Group event log on resource and activity id
#' @description Group an event log by resource and activity identifier
#' @param eventlog Eventlog
#' @export group_by_resource_activity
group_by_resource_activity <- function(eventlog) {
	UseMethod("group_by_resource_activity")
}
#' @describeIn group_by_resource_activity Group an event log by resource and activity identifier
#' @export
group_by_resource_activity.eventlog <- function(eventlog) {
	group_by(eventlog, !!as.symbol(resource_id(eventlog)), !!as.symbol(activity_id(eventlog)))
}



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
