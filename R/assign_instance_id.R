#' Assign activity instance identifier to events
#'
#' Apply heuristics to create an activity instance identifier, so that an eventlog can be made.
#'
#' @param eventlog data.frame with events
#' @param case_id Case identifier
#' @param activity_id Activity identifier
#' @param timestamp Timestamp
#' @param lifecycle_id Lifecycle identifier
#'
#' @family Eventlog construction helpers
#' @importFrom purrr accumulate
#' @importFrom purrr map_dbl
#' @export
#'
assign_instance_id <- function(eventlog, case_id, activity_id, timestamp, lifecycle_id) {

  BUPAR_CURRENT_INSTANCE <- NULL

	BUPAR_STATUS_WIP <- list(open_instances = c(), last_instance = 0)

	eventlog %>%
		group_by(!!sym(case_id), !!sym(activity_id)) %>%
		arrange(!!sym(timestamp)) %>%
		mutate(BUPAR_STATUS_WIP = accumulate(!!sym(lifecycle_id), assign_instance_id_EVENT, .init = BUPAR_STATUS_WIP)[-1]) %>%
		mutate(BUPAR_CURRENT_INSTANCE = map_dbl(BUPAR_STATUS_WIP, ~.x$BUPAR_CURRENT_INSTANCE)) %>%
		select(-BUPAR_STATUS_WIP) %>%
		mutate(instance_by_bupaR = str_c(!!sym(case_id), !!sym(activity_id), BUPAR_CURRENT_INSTANCE, sep = "-")) %>%
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
	status$BUPAR_CURRENT_INSTANCE <- instance
	return(status)
}












