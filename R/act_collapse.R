#' Collapse activity labels of a sub process into a single activity
#'
#' Collapse activity labels of a sub process into a single activity
#'
#'
#' @param eventlog An \code{eventlog} object
#' @param ... A series of named character vectors. The activity labels in each vector will be collapsed into one activity with the name of the vector.
#' @family Activity processing functions
#' @export act_collapse
#'
act_collapse <- function(eventlog, ...) {
	UseMethod("act_collapse")
}

#' @describeIn act_collapse Collapse activity labels of a subprocess into a single activity
#' @export
act_collapse.eventlog <- function(eventlog, ...) {
	sub_processes <- list(...)
	for(i in seq_along(sub_processes)) {
		eventlog <- aggregate_subprocess(eventlog, sub_name = names(sub_processes)[i], sub_processes[[i]])
	}
	return(eventlog)
}


aggregate_subprocess <- function(eventlog, sub_name, sub_acts) {

	mapping <- mapping(eventlog)

	eventlog %>%
		filter((!!as.symbol(activity_id(mapping))) %in% sub_acts) -> sub_log

	start_activities_INTERN(sub_log) %>%
		pull(!!as.symbol(activity_id(mapping))) -> start_act

	end_activities_INTERN(sub_log) %>%
		pull(!!as.symbol(activity_id(mapping))) -> end_act

	sub_log %>%
		group_by(!!as.symbol(case_id(mapping)),
				 !!as.symbol(activity_id(mapping)),
				 !!as.symbol(activity_instance_id(mapping)),
				 !!as.symbol(resource_id(mapping))) %>%
		summarize("ts" = min(!!as.symbol(timestamp(mapping))),
				  "max_ts" = max(!!as.symbol(timestamp(mapping)))) %>%
		group_by(!!as.symbol(case_id(mapping))) %>%
		arrange(!!as.symbol("ts")) %>%
		mutate("cur_act" = !!as.symbol(activity_id(mapping)),
			   "next_act" = lead(!!as.symbol(activity_id(mapping)))) %>%
		mutate("end_sub_process" = (!!as.symbol("next_act")) %in% start_act & (!!as.symbol("cur_act")) %in% end_act) %>%
		mutate(end_case = is.na(!!as.symbol("next_act"))) %>%
		arrange(!!as.symbol(case_id(mapping)), !!as.symbol("ts")) %>%
		ungroup() %>%
		mutate("sub_process_instance" = lag(cumsum((!!as.symbol("end_sub_process")) + !!as.symbol("end_case")), default = 0)) %>%
		group_by(!!as.symbol("sub_process_instance")) %>%
		slice(c(1,n())) %>%
		mutate("RESOURCE_CLASSIFIER" = paste(sort(unique(!!as.symbol(resource_id(mapping)))), collapse = ",")) %>%
		mutate("LIFECYCLE_CLASSIFIER" = c("start","complete"),
			   is_collapsed = T) %>%
		ungroup() %>%
		mutate(!!as.symbol(lifecycle_id(mapping)) := !!as.symbol("LIFECYCLE_CLASSIFIER"),
			   !!as.symbol(resource_id(mapping)) := !!as.symbol("RESOURCE_CLASSIFIER"),
			   !!as.symbol(activity_instance_id(mapping)) := as.character(!!as.symbol("sub_process_instance")),
			   !!as.symbol(timestamp(mapping)) := if_else((!!as.symbol("LIFECYCLE_CLASSIFIER")) == "start", !!as.symbol("ts"), (!!as.symbol("max_ts"))),
			   !!as.symbol(activity_id(mapping)) := sub_name)  %>%
		select(-one_of(c("ts",
						 "max_ts",
						 "cur_act",
						 "next_act",
						 "end_sub_process",
						 "end_case",
						 "RESOURCE_CLASSIFIER",
						 "LIFECYCLE_CLASSIFIER"))) -> aggregation

	eventlog %>%
		filter(!(!!as.symbol(activity_id(mapping))) %in% sub_acts) %>%
		mutate(is_collapsed = F) %>%
		bind_rows(aggregation) %>%
		re_map(mapping) -> result

	return(result)


}


### functions edeaR (bupaR cannot have edear dependency)

end_activities_INTERN <- function(eventlog) {

	eventlog %>%
		group_by(!!as.symbol(case_id(eventlog))) %>%
		arrange(!!as.symbol(timestamp(eventlog))) %>%
		summarize(last_event = last(!!as.symbol(activity_id(eventlog)))) %>%
		group_by(!!as.symbol("last_event")) %>%
		summarize() -> r

	colnames(r)[colnames(r) == "last_event"] <- activity_id(eventlog)
	return(r)

}

start_activities_INTERN <- function(eventlog) {

	eventlog %>%
		group_by(!!as.symbol(case_id(eventlog))) %>%
		arrange(!!as.symbol(timestamp(eventlog))) %>%
		summarize(first_event = first(!!as.symbol(activity_id(eventlog)))) %>%
		group_by(!!as.symbol("first_event")) %>%
		summarize() -> r

	colnames(r)[colnames(r) == "first_event"] <- activity_id(eventlog)
	return(r)

}












