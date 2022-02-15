
#' Create base log
#'
#' @param log Eventlog
#' @param ... Other arguments


#' @export
create_base_log <- function(log, ...) {
	UseMethod("create_base_log")
}
#' @export
create_base_log.eventlog <- function(log, ...) {
	log %>%
		group_by_ids(case_id, activity_id, activity_instance_id) %>%
		summarize(!!resource_id_(eventlog) := first(.data[[resource_id(log)]]),
				  "min_ts" = min(.data[[timestamp(log)]]),
				  "max_ts" = max(.data[[timestamp(log)]]),
				  ".order" = min(.data$.order))
}
#' @export
create_base_log.activitylog <- function(log, ...) {
	log %>%
		select_ids(case_id, activity_id, resource_id, lifecycle_ids)
}
