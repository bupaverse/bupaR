#' Assign activity instance identifier to events
#'
#' Apply heuristics to create an activity instance identifier, so that eventlog can be made.
#'
#' @param eventlog data.frame
#' @param case_id Case identifier
#' @param activity_id Activity identifier
#' @param timestamp Timestap
#' @param lifecycle_id Lifecycle identifier
#'
#' @family Eventlog construction helpers
#' @importFrom purrr accumulate
#' @importFrom purrr map_dbl
#' @export
#'
assign_instance_id <- function(eventlog, case_id, activity_id, timestamp, lifecycle_id) {

	current_instance <- NULL

	status <- list(open_instances = c(), last_instance = 0)

	eventlog %>%
		group_by(!!sym(case_id), !!sym(activity_id)) %>%
		arrange(!!sym(timestamp)) %>%
		mutate(status = accumulate(!!sym(lifecycle_id), assign_instance_id_EVENT, .init = status)[-1]) %>%
		mutate(current_instance = map_dbl(status, ~.x$current_instance)) %>%
		select(-status) %>%
		mutate(instance = str_c(!!sym(case_id), !!sym(activity_id), current_instance, sep = "-")) %>%
		ungroup() %>%
		as_tibble()
}



assign_instance_id_EVENT <- function(status, lifecycle) {

	start_lifecycles <- c("start")
	end_lifecycles <- c("complete")

	if(lifecycle %in% start_lifecycles) {

		#nieuwe gestart
		if(length(status$open_instances)>0) {
			# voeg nieuwe toe op basis van max open
			instance <- max(status$open_instances) + 1
			status$open_instances <- c(status$open_instances, instance)
			status$last_instance <- instance
		} else {
			# voeg nieuwe toe op basis van laatste gekend
			instance <- status$last_instance + 1
			status$open_instances <- instance
			status$last_instance <- instance

		}

	} else if(lifecycle %in% end_lifecycles) {
		#eindpunt
		if(length(status$open_instances)>0) {
			# eindig oudste instance
			instance <- status$open_instances[1]
			status$open_instances <- status$open_instances[-1]
		} else {
			# maak nieuwe
			instance <- status$last_instance + 1
			status$open_instances <- instance
			status$last_instance <- instance
		}
	} else {
		# gebruik oudste
		if(length(status$open_instances)>0) {
			instance <- status$open_instances[1]
		} else {
			# of maak nieuwe
			instance <- status$last_instance + 1
			status$open_instances <- instance
			status$last_instance <- instance

		}
	}
	status$current_instance <- instance
	return(status)
}












