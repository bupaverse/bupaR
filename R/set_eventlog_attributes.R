


#' Set individual attributes of event log
#'
#' @param eventlog Event log object
#' @param case_id New case id
#' @param activity_id New activity id
#' @param activity_instance_id New activity instance id
#' @param resource_id New resource id
#' @param lifecycle_id New lifecycle id
#' @param timestamp New timestamp
#' @name set_case_id
#'



## CASE ID

#' @export
#'
set_case_id <- function(eventlog, case_id) {
	UseMethod("set_case_id")
}
#' @rdname set_case_id
#' @export
#'
set_activity_id <- function(eventlog, activity_id) {
	UseMethod("set_activity_id")
}
#' @rdname set_case_id
#' @export
#'
set_activity_instance_id <- function(eventlog, activity_instance_id) {
	UseMethod("set_activity_instance_id")
}
#' @rdname set_case_id
#' @export
#'
set_timestamp <- function(eventlog, timestamp) {
	UseMethod("set_timestamp")
}

#' @rdname set_case_id
#' @export
#'
set_resource_id <- function(eventlog, resource_id) {
	UseMethod("set_resource_id")
}

#' @rdname set_case_id
#' @export
#'
set_lifecycle_id <- function(eventlog, lifecycle_id) {
	UseMethod("set_lifecycle_id")
}


#' @describeIn set_case_id Set case id of event log
#' @export
set_case_id.eventlog <- function(eventlog, case_id) {
	eventlog %>%
		eventlog(case_id = case_id)
}
#' @describeIn set_case_id Set case id of grouped event log
#' @export
set_case_id.grouped_eventlog <- function(eventlog, case_id) {
	groups <- groups(eventlog)
	eventlog %>%
		eventlog(case_id = case_id) %>%
		group_by_at(vars(one_of(paste(groups))))
}

## ACTIVITY ID

#' @describeIn set_case_id Set activity id of event log
#' @export
set_activity_id.eventlog <- function(eventlog, activity_id) {
	eventlog %>%
		eventlog(activity_id = activity_id)
}
#' @describeIn set_case_id Set activity id of grouped event log
#' @export
set_activity_id.grouped_eventlog <- function(eventlog, activity_id) {
	groups <- groups(eventlog)
	eventlog %>%
		eventlog(activity_id = activity_id) %>%
		group_by_at(vars(one_of(paste(groups))))
}

## ACTIVITY INSTANCE ID

#' @describeIn set_case_id Set activity instance id of event log
#' @export
set_activity_instance_id.eventlog <- function(eventlog, activity_instance_id) {
	eventlog %>%
		eventlog(activity_instance_id = activity_instance_id)
}
#' @describeIn set_case_id Set activity instance id of grouped event log
#' @export
set_activity_instance_id.grouped_eventlog <- function(eventlog, activity_instance_id) {
	groups <- groups(eventlog)
	eventlog %>%
		eventlog(activity_instance_id = activity_instance_id) %>%
		group_by_at(vars(one_of(paste(groups))))
}

## TIMESTAMP

#' @describeIn set_case_id Set timestamp of event log
#' @export
set_timestamp.eventlog <- function(eventlog, timestamp) {
	eventlog %>%
		eventlog(timestamp = timestamp)
}
#' @describeIn set_case_id Set timestamp of grouped event log
#' @export
set_timestamp.grouped_eventlog <- function(eventlog, timestamp) {
	groups <- groups(eventlog)
	eventlog %>%
		eventlog(timestamp = timestamp) %>%
		group_by_at(vars(one_of(paste(groups))))
}

## RESOURCE

#' @describeIn set_case_id Set resource_id of event log
#' @export
set_resource_id.eventlog <- function(eventlog, resource_id) {
	eventlog %>%
		eventlog(resource_id = resource_id)
}
#' @describeIn set_case_id Set resource_id of grouped event log
#' @export
set_resource_id.grouped_eventlog <- function(eventlog, resource_id) {
	groups <- groups(eventlog)
	eventlog %>%
		eventlog(resource_id = resource_id) %>%
		group_by_at(vars(one_of(paste(groups))))
}

## LIFECYCLE ID

#' @describeIn set_case_id Set lifecycle_id of event log
#' @export
set_lifecycle_id.eventlog <- function(eventlog, lifecycle_id) {
	eventlog %>%
		eventlog(lifecycle_id = lifecycle_id)
}
#' @describeIn set_case_id Set lifecycle_id of grouped event log
#' @export
set_lifecycle_id.grouped_eventlog <- function(eventlog, lifecycle_id) {
	groups <- groups(eventlog)
	eventlog %>%
		eventlog(lifecycle_id = lifecycle_id) %>%
		group_by_at(vars(one_of(paste(groups))))
}


