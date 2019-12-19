
#' Fix resource inconsistencies
#'
#'
#'
#' @param eventlog Event log object
#' @param filter_condition Condition that is used to extract a subset of the activity log prior to the application of the function
#' @param overwrite_missings If events are missing, overwrite the resource if other events within activity instance are performed by single resource. Default FALSE.
#' @param detected_problems If available, the problems detected that need to be fixed. If not available, the function detect_resource_inconsistenties will be called.
#' @param details Show details
#' @export
#'
fix_resource_inconsistencies <- function(eventlog, filter_condition, overwrite_missings, detected_problems, details) {
	UseMethod("fix_resource_inconsistencies")
}

#' @describeIn fix_resource_inconsistencies activitylog Fix activitylog
#' @export

fix_resource_inconsistencies.activitylog <- function(eventlog, filter_condition = NULL, overwrite_missings = FALSE, detected_problems = NULL, details = TRUE) {
	stop("Object is activitylog. No resource inconsistencies to be fixed by definition.")
}

#' @describeIn fix_resource_inconsistencies eventlog Fix eventlog
#' @export

fix_resource_inconsistencies.eventlog <- function(eventlog, filter_condition = NULL, overwrite_missings = FALSE, detected_problems = NULL, details = TRUE) {

	key <- NULL
	value <- NULL
	contains_na <- NULL
	n_resource_labels <- NULL
	new_resource <- NULL
	single_resource <- NULL

	if(is.null(detected_problems)) {
		inconsistencies <- detect_resource_inconsistencies(eventlog, filter_condition = filter_condition)
	} else if("detected_problems" %in% class(detected_problems)) {
		if(attr(detected_problems, "type") == "resource_inconsistencies") {
			inconsistencies <- detected_problems
		} else {
			warning("Problems passed to 'detected_problems' are not about resource inconsistencies. Recomputing resource inconsistencies.")
			inconsistencies <- detect_resource_inconsistencies(eventlog, filter_condition = filter_condition)
		}
	} else {
		warning("Objected passed to 'detected_problems' is not compliant. Recomputing resource inconsistencies.")
		inconsistencies <- detect_resource_inconsistencies(eventlog, filter_condition = filter_condition)
	}


	n_anomalies <- nrow(inconsistencies)

	if(is.null(inconsistencies)) {
		message("No inconsistencies to be fixed.")
	} else {
		if(!is.null(filter_condition)) {
			message("\n\nApplied filtering condition", filter_condition, "\n", "\n")
		}

		message("*** OUTPUT ***")
		message("A total of ", n_anomalies, " activity executions in the event log are classified as inconsistencies.")
	if(details) {
		message("They are spread over the following cases and activities:")
		print(inconsistencies)
	}

		to_merge <- names(inconsistencies)[4:length(names(inconsistencies))]

		inconsistencies %>%
			gather(key, value, -1:-3) %>%
			group_by(!!case_id_(eventlog), !!activity_id_(eventlog), !!activity_instance_id_(eventlog)) %>%
			mutate(contains_na = any(is.na(value)),
				   n_resource_labels = n_distinct(value, na.rm = T)) %>%
			mutate(single_resource = ifelse(n_resource_labels == 1, unique(na.omit(value)), NA)) -> new_names

		if(nrow(new_names %>% filter(contains_na)) > 0 & !overwrite_missings) {
			warning("Some events have missing resource(s). Set overwrite_missings = TRUE, if you want to overwrite with resource available in the same activity instance.")
		} else if(nrow(new_names %>% filter(contains_na)) > 0 & overwrite_missings) {
			warning("Some events have missing resource(s). Will be overwritten if other related events have unique resource.")
		}

		## don't overwrite
		if(overwrite_missings) {
			new_names %>%
				spread(key, value) %>%
				unite(new_resource, to_merge, sep = " - ", remove = T) %>%
				mutate(new_resource = ifelse(contains_na & n_resource_labels == 1, single_resource, new_resource)) %>%
				select(-single_resource, -contains_na, -n_resource_labels) -> new_names
		} else { #overwrite
			inconsistencies %>%
				unite(new_resource, to_merge, sep = " - ", remove = T) -> new_names
		}
		message("Inconsistencies solved succesfully.")
		# join to eventlog and remap
		eventlog %>%
			as.data.frame() %>%
			mutate(!!resource_id_(eventlog) := as.character(!!resource_id_(eventlog))) %>%
			left_join(new_names, by = c(case_id(eventlog), activity_id(eventlog), activity_instance_id(eventlog))) %>%
			mutate(!!resource_id_(eventlog) := ifelse(is.na(new_resource), !!resource_id_(eventlog), new_resource)) %>%
			select(-new_resource) %>%
			re_map(mapping(eventlog))

	}



}
