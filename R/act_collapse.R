#' Collapse activity labels of a sub process into a single activity
#'
#' Collapse activity labels of a sub process into a single activity
#'
#' There are different strategies to collapse activity labels (argument ´method´). The "entry_points" method aims to learn the start and end activities of the sub process, by looking at the first and last activity in each case over the whole log. Subsequently, it will create a new instance of the sub process each time there is an end activity followed by a start activity. This strategy will not take into account other activities happening in the mean time. The "consecutive" method will create an instance each time a new sequence of sub activities is started. This strategy will thus only take into account interruptions of the other activity labels.
#'
#' @param log \code{\link{log}}: Object of class \code{\link{log}} or derivatives (\code{\link{grouped_log}}, \code{\link{eventlog}},
#' \code{\link{activitylog}}, etc.).
#' @param eventlog `r lifecycle::badge("deprecated")`; please use \code{log} instead.
#' @param ... A series of named character vectors. The activity labels in each vector will be collapsed into one activity with the name of the vector.
#' @param method Defines how activities are collapsed: "entry_points" heuristically learns which of the specified activities occur at the start and end of the subprocess and collapses accordingly. "consecutive" collapses consecutive sequences of the activities.
#' @family Activity processing functions
#' @export
#'
act_collapse <- function(log, ..., method, eventlog = deprecated()) {
	UseMethod("act_collapse")
}

#' @describeIn act_collapse Collapse activity labels of a subprocess into a single activity
#' @export
act_collapse.eventlog <- function(log, ..., method = c("entry_points","consecutive"), eventlog = deprecated() ) {

	log <- lifecycle_warning_eventlog(log, eventlog)
	method <- match.arg(method)
	sub_processes <- list(...)

	if(method == "entry_points") {
		for(i in seq_along(sub_processes)) {
			log <- aggregate_subprocess_entry_points(log, sub_name = names(sub_processes)[i], sub_processes[[i]])
		}
	} else if(method == "consecutive") {
		for(i in seq_along(sub_processes)) {
			log <- aggregate_subprocess_consecutive(log, sub_name = names(sub_processes)[i], sub_processes[[i]])
		}

	}
	return(log)
}

#' @describeIn act_collapse Collapse activity labels of a subprocess into a single activity
#' @export
act_collapse.activitylog <- function(log, ..., method = c("entry_points","consecutive"), eventlog = deprecated()) {
	log <- lifecycle_warning_eventlog(log, eventlog)

	to_activitylog(act_collapse.eventlog(to_eventlog(log),..., method))

}

#' @describeIn act_collapse Collapse activity labels of a subprocess into a single activity
#' @export

act_collapse.grouped_log <- function(log, ..., method = c("entry_points","consecutive"), eventlog = deprecated()) {

	apply_grouped_fun(log, act_collapse, ..., method, .ignore_groups = TRUE, .keep_groups = TRUE)
}


aggregate_subprocess_entry_points <- function(eventlog, sub_name, sub_acts) {

	mapping <- mapping(eventlog)

	# extract log of subprocess
	eventlog %>%
		filter(.data[[activity_id(mapping)]] %in% sub_acts) -> sub_log

	# find first activities
	.start_activities_eventlog(sub_log) %>%
		pull(.data[[activity_id(mapping)]]) -> start_act

	# find last activities
	.end_activities_eventlog(sub_log) %>%
		pull(.data[[activity_id(mapping)]]) -> end_act

	sub_log %>%
		group_by_ids(case_id, activity_id, activity_instance_id, resource_id) %>%
		summarize("min_ts" = min(.data[[timestamp(mapping)]], na.rm = T),
				  "max_ts" = max(.data[[timestamp(mapping)]], na.rm = T),
				  ".order" = min(.data$.order, na.rm = T)) %>%
		group_by(.data[[case_id(mapping)]]) %>%
		arrange(.data$min_ts,
				.data$.order) %>%
		mutate("cur_act" = .data[[activity_id(mapping)]],
			   "next_act" = lead(.data[[activity_id(mapping)]])) %>%
		mutate("end_sub_process" = (.data$next_act %in% start_act) & (.data$cur_act %in% end_act)) %>%
		mutate(end_case = is.na(.data$next_act)) %>%
		arrange(.data[[case_id(mapping)]], .data$min_ts, .data$.order) %>%
		ungroup() %>%
		mutate("sub_process_instance" = paste(sub_name, lag(cumsum((.data$end_sub_process) + .data$end_case), default = 0), sep = "_")) %>%
		group_by(.data$sub_process_instance) %>%
		slice(c(1,n()))  %>%
		mutate(!!resource_id_(mapping) := paste(sort(unique(.data[[resource_id(mapping)]])), collapse = ",")) %>%
		ungroup() %>%
		mutate(!!lifecycle_id_(mapping) := rep(c("start","complete"), length.out = n()),
			   is_collapsed = T) %>%
		mutate(!!activity_instance_id_(mapping) := as.character(.data$sub_process_instance),
			   !!timestamp_(mapping) := if_else(.data[[lifecycle_id(mapping)]] == "start", .data$min_ts, .data$max_ts),
			   !!activity_id_(mapping) := sub_name)  %>%
		select(-one_of(c("min_ts",
						 "max_ts",
						 "cur_act",
						 "next_act",
						 "end_sub_process",
						 "end_case"))) %>%
		re_map(mapping)  -> aggregation


	suppressWarnings(eventlog %>%
					 	filter(!(.data[[activity_id(mapping)]]) %in% sub_acts) %>%
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

















