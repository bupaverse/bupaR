#' Collapse activity labels of a sub process into a single activity
#'
#' Collapse activity labels of a sub process into a single activity
#'
#' There are different strategies to collapse activity labels (argument ´method´). The "entry_points" method aims to learn the start and end activities of the sub process, by looking at the first and last activity in each case over the whole log. Subsequently, it will create a new instance of the sub process each time there is an end activity followed by a start activity. This strategy will not take into account other activities happening in the mean time. The "consecutive" method will create an instance each time a new sequence of sub activities is started. This strategy will thus only take into account interruptions of the other activity labels.
#'
#' @param eventlog An \code{eventlog} object
#' @param ... A series of named character vectors. The activity labels in each vector will be collapsed into one activity with the name of the vector.
#' @param method Defines how activities are collapsed: "entry_points" heuristically learns which of the specified activities occur at the start and end of the subprocess and collapses accordingly. "consecutive" collapses consecutive sequences of the activities.
#' @family Activity processing functions
#' @export act_collapse
#'
act_collapse <- function(eventlog, ..., method) {
	UseMethod("act_collapse")
}

#' @describeIn act_collapse Collapse activity labels of a subprocess into a single activity
#' @export
act_collapse.eventlog <- function(eventlog, ..., method = c("entry_points","consecutive")) {
	method <- match.arg(method)
	sub_processes <- list(...)
	if(method == "entry_points") {
		for(i in seq_along(sub_processes)) {
			eventlog <- aggregate_subprocess_entry_points(eventlog, sub_name = names(sub_processes)[i], sub_processes[[i]])
		}
	} else if(method == "consecutive") {
		for(i in seq_along(sub_processes)) {
			eventlog <- aggregate_subprocess_consecutive(eventlog, sub_name = names(sub_processes)[i], sub_processes[[i]])
		}

	}
	return(eventlog)
}


aggregate_subprocess_entry_points <- function(eventlog, sub_name, sub_acts) {

	min_order <- NULL
	.order <- NULL

	mapping <- mapping(eventlog)

	# extract log of subprocess
	eventlog %>%
		filter((!!as.symbol(activity_id(mapping))) %in% sub_acts) -> sub_log


	# find first activities
	start_activities_INTERN(sub_log) %>%
		pull(!!as.symbol(activity_id(mapping))) -> start_act

	# find last activities
	end_activities_INTERN(sub_log) %>%
		pull(!!as.symbol(activity_id(mapping))) -> end_act



	sub_log %>%
		group_by(!!as.symbol(case_id(mapping)),
				 !!as.symbol(activity_id(mapping)),
				 !!as.symbol(activity_instance_id(mapping)),
				 !!as.symbol(resource_id(mapping))) %>%
		summarize("ts" = min(!!as.symbol(timestamp(mapping))),
				  "max_ts" = max(!!as.symbol(timestamp(mapping))),
				  "min_order" = min(.order)) %>%
		group_by(!!as.symbol(case_id(mapping))) %>%
		arrange(!!as.symbol("ts"),
				min_order) %>%
		mutate("cur_act" = !!as.symbol(activity_id(mapping)),
			   "next_act" = lead(!!as.symbol(activity_id(mapping)))) %>%
		mutate("end_sub_process" = (!!as.symbol("next_act")) %in% start_act & (!!as.symbol("cur_act")) %in% end_act) %>%
		mutate(end_case = is.na(!!as.symbol("next_act"))) %>%
		arrange(!!as.symbol(case_id(mapping)), !!as.symbol("ts"), min_order) %>%
		ungroup() %>%
		mutate("sub_process_instance" = paste(sub_name, lag(cumsum((!!as.symbol("end_sub_process")) + !!as.symbol("end_case")), default = 0), sep = "_")) %>%
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
		rename(.order = min_order) %>%
		select(-one_of(c("ts",
						 "max_ts",
						 "cur_act",
						 "next_act",
						 "end_sub_process",
						 "end_case",
						 "RESOURCE_CLASSIFIER",
						 "LIFECYCLE_CLASSIFIER"))) %>%
		re_map(mapping)  -> aggregation


	suppressWarnings(eventlog %>%
					 	filter(!(!!as.symbol(activity_id(mapping))) %in% sub_acts) %>%
					 	mutate(is_collapsed = F) %>%
					 	bind_rows(aggregation) %>%
					 	re_map(mapping) -> result)

	return(result)
	#

}

aggregate_subprocess_consecutive <- function(eventlog, sub_name, sub_acts) {
	.order <- NULL
	min_order <- NULL
	cur_act <- NULL
	start_sub_process <- NULL
	end_sub_process <- NULL
	end_case <- NULL

	mapping <- mapping(eventlog)

	eventlog %>%
		group_by(!!as.symbol(case_id(mapping)),
				 !!as.symbol(activity_id(mapping)),
				 !!as.symbol(activity_instance_id(mapping)),
				 !!as.symbol(resource_id(mapping))) %>%
		summarize("ts" = min(!!as.symbol(timestamp(mapping))),
				  "max_ts" = max(!!as.symbol(timestamp(mapping))),
				  "min_order" = min(.order)) %>%
		group_by(!!as.symbol(case_id(mapping))) %>%
		arrange(!!as.symbol("ts"),
				min_order) %>%
		mutate("cur_act" = !!as.symbol(activity_id(mapping)),
			   "next_act" = lead(!!as.symbol(activity_id(mapping)))) %>%
		mutate("end_sub_process" = !((!!as.symbol("next_act")) %in% sub_acts) & (!!as.symbol("cur_act")) %in% sub_acts) %>%
		mutate("start_sub_process" = lag((!!as.symbol("next_act")) %in% sub_acts & !((!!as.symbol("cur_act")) %in% sub_acts))) %>%
		mutate("start_sub_process" = ifelse(is.na(!!as.symbol("start_sub_process")), ifelse(cur_act %in% sub_acts, T, F), start_sub_process)) %>%
		mutate(end_case = is.na(!!as.symbol("next_act"))) %>%
		arrange(!!as.symbol(case_id(mapping)), !!as.symbol("ts"), min_order) %>%
		ungroup() %>%
		mutate(sub_process_instance = paste(sub_name, cumsum(start_sub_process) + lag(cumsum(end_sub_process), default = 0) + lag(cumsum(end_case), default = 0), sep = "_")) %>%
		filter(cur_act %in% sub_acts) %>%
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
		rename(.order = min_order) %>%
		select(-one_of(c("ts",
						 "max_ts",
						 "cur_act",
						 "next_act",
						 "end_sub_process",
						 "end_case",
						 "RESOURCE_CLASSIFIER",
						 "LIFECYCLE_CLASSIFIER"))) %>%
		re_map(mapping) -> aggregation

	suppressWarnings(eventlog %>%
					 	filter(!(!!as.symbol(activity_id(mapping))) %in% sub_acts) %>%
					 	mutate(is_collapsed = F) %>%
					 	bind_rows(aggregation) %>%
					 	re_map(mapping) -> result)

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












