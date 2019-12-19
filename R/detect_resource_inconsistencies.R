
#' Detect resource inconsistencies
#'
#' Function to detect inconsistencies in resource information between related events.
#'
#' @param eventlog Event log object
#' @param filter_condition Condition that is used to extract a subset of the activity log prior to the application of the function
#' @importFrom tidyr spread
#' @importFrom tidyr gather
#' @export
#'
detect_resource_inconsistencies <- function(eventlog,
											filter_condition) {
	UseMethod("detect_resource_inconsistencies")
}

#' @export


detect_resource_inconsistencies.eventlog <- function(eventlog, filter_condition = NULL) {

	inconsistency <- NULL

	if(!is.null(filter_condition)) {
		eventlog <- eventlog %>%
			filter(!! rlang::parse_expr(filter_condition))
	}

	allowed_lifecycles <- c("schedule","assign","reassign","start","suspend","resume","abort_activity","abort_case","complete","manualskip","autoskip")

	if(any(!(lifecycle_labels(eventlog) %in% allowed_lifecycles))) {
		stop(glue::glue("Lifecycle not conform standard lifecycle model. \nAllowed lifecycles: {str_c(allowed_lifecycles, collapse =', ')}.
         \nNon-standard lifecycles: {str_subset(lifecycle_labels(eventlog), allowed_lifecycles, negate = TRUE)
         \nTry function 'standardize_lifecycle' to fix."))
	}
	# Store the number of cases for output

	if(length(lifecycle_labels(eventlog)) == 1) {
		message(glue::glue("Only {lifecycle_labels(eventlog)} events were found in the event log. Thus there are no resource inconsistencies."))

	} else {

		eventlog %>%
			as.data.frame() %>%
			select(case_id(eventlog),
				   activity_id(eventlog),
				   resource_id(eventlog),
				   lifecycle_id(eventlog),
				   activity_instance_id(eventlog)) %>%
			mutate(!!resource_id_(eventlog) := as.character(!!resource_id_(eventlog))) %>%
			group_by(!!case_id_(eventlog), !!activity_id_(eventlog), !!activity_instance_id_(eventlog)) %>%
			mutate(inconsistency = (n_distinct(!!resource_id_(eventlog)) > 1) | (sum(is.na(!!resource_id_(eventlog))) > 0 & sum(is.na(!!resource_id_(eventlog))) < n())) %>%
			ungroup() %>%
			filter(inconsistency) %>%
			select(-inconsistency) %>%
			spread(!!lifecycle_id_(eventlog), !!resource_id_(eventlog)) -> output

		if(nrow(output) > 0) {
			class(output) <- c("detected_problems", class(output))
			attr(output, "eventlog") <- eventlog
			attr(output, "type") <- "resource_inconsistencies"
			output
		} else {
			message("No inconsistencies found")
		}
	}




}

#' @export
#'
detect_resource_inconsistencies.activitylog <- function(eventlog,
														filter_condition = NULL) {
	stop("Object is activitylog. No resource inconsistencies by definition.")
}


# OLD LEGACY CODE
# resource_inconsistencies <- function(event_log,
#                                      case_id_label,
#                                      activity_label,
#                                      resource_label,
#                                      event_lifecycle_label,
#                                      timestamps_label,
#                                      event_matching_label = NULL,
#                                      details = TRUE,
#                                      filter_condition = NULL,
#                                      detect_only = TRUE) {
#
#   # Predefine variables
#   lifecycle <- NULL
#   event_matching <- NULL
#   timestamp <- NULL
#   row_id <- NULL
#   consistent <- NULL
#   row_ids <- NULL
#   new <- NULL
#   gather <- NULL
#   case_id <- NULL
#   activity <- NULL
#   resource <- NULL
#   start <- NULL
#   complete <- NULL
#
#   # Check if the required columns are present in the log
#   missing_columns <- check_colnames(event_log, case_id_label, activity_label, resource_label, timestamps_label, event_lifecycle_label, event_matching_label)
#   if(!is.null(missing_columns)){
#     stop("The following columns were not found in the event log: ",
#          paste(missing_columns, collapse = "\t"), ".", "\n  ",
#          "Ensure all labels are passed correctly to detect resource inconsistencies.")
#   }
#
#   # Rename columns for ease-of-use later in this function
#   colnames(event_log)[match(case_id_label, colnames(event_log))] <- "case_id"
#   colnames(event_log)[match(activity_label, colnames(event_log))] <- "activity"
#   colnames(event_log)[match(resource_label, colnames(event_log))] <- "resource"
#   colnames(event_log)[match(event_lifecycle_label, colnames(event_log))] <- "lifecycle"
#   colnames(event_log)[match(timestamps_label, colnames(event_log))] <- "timestamp"
#   if(!is.null(event_matching_label)){
#     colnames(event_log)[match(event_matching_label, colnames(event_log))] <- "event_matching"
#   }
#
#   # Save the log as passed originally, but with standardized column names
#   event_log.original <- event_log
#
#   # Create another copy for safety purposes with chronologically ordening rows later
#   # log_copy <- event_log
#   # !! Commented because it is part of the old code.
#
#
#   # Apply filter condition when specified
#   if(!is.null(filter_condition)) {
#     event_log <- event_log %>% filter(!! rlang::parse_expr(filter_condition))
#   }
#
#   # Prepare the data: make sure the lifecycle column values are all lowercase
#   event_log[["lifecycle"]] <- str_to_lower(event_log[["lifecycle"]])
#
#   # Store the number of cases for output
#   n_cases <- event_log %>% distinct(case_id) %>% nrow() %>% as.numeric()
#
#   #####                                                               #####
#   # If only start or complete is present, there cannot be inconsistencies #
#   #####                                                               #####
#   events <- event_log[["lifecycle"]] %>% unique
#
#   if(!("start" %in% events) & !("complete" %in% events)) {
#     return("No start events and no complete were found in the event log. Thus there are no resource inconsistencies.")
#   } else if(!("start" %in% events) & ("complete" %in% events)) {
#     return("Only complete events were found in the event log. Thus there are no resource inconsistencies.")
#   } else if(("start" %in% events) & !("complete" %in% events)) {
#     return("Only start events were found in the event log. Thus there are no resource inconsistencies.")
#   }
#
#
#
#   #####                                   #####
#   # Start with collecting the inconsistencies #
#   #####                                   #####
#   # If a column that links events with each other is present:
#   if(!is.null(event_matching_label)){
#     inconsistencies <- event_log %>%
#       select(case_id, activity, resource, lifecycle, event_matching) %>% # Only select the essential columns to ensure a good spread. Timestamps
#       spread(lifecycle, resource)
#
#     # Prepare the inconsistencies table for output:
#     #   Those activities with different resources or where one of the two is missing
#     inconsistencies <- inconsistencies %>%
#       filter(start != complete | is.na(start) | is.na(complete) | is.null(start) | is.null(complete)) %>%
#       filter(!(is.na(start) & is.na(complete)) & !(is.null(start) & is.null(complete))) %>%
#       select(case_id, activity, event_matching, start, complete)
#   }
#
#   # In case the matching column is not provided
#   else {
#     #### New algorithm provided by Niels, edited by Greg for better integration with this function
#
#     # First, arrange on time and add row numbers for ordering purposes
#     inconsistencies <- event_log %>%
#       arrange(timestamp) %>%
#       mutate(row_id = row_number()) %>%
#
#       # Now count event occurences to see if there are any inconsistencies, keep row numbers in the table
#       group_by(case_id, activity, resource, lifecycle) %>%
#       summarise(n = n(), row_ids = paste0(row_id, collapse = "-")) %>%
#
#       # Check (in)consistencies and filter
#       group_by(case_id, activity, resource) %>%
#       mutate(consistent = if_else(n[1] == n[2], TRUE, FALSE)) %>%
#       filter(is.na(consistent) | consistent == FALSE)
#
#     # Duplicate rows if required to return to the original row numbers
#     if (nrow(inconsistencies) > 0) {
#       inconsistencies <- inconsistencies[rep(row.names(inconsistencies), inconsistencies$n),]
#       inconsistencies <- inconsistencies %>% group_by(case_id,activity,resource,lifecycle) %>% mutate(row_id = strsplit(row_ids, "-")[[1]])
#     }
#
#     # Keep this working table in a separate variable so we can continue working with the row numbers later if required.
#     working_table <- inconsistencies %>% select(-n:-consistent)
#
#     inconsistencies <- inconsistencies %>%
#
#       # Arrange back on row_id
#       arrange(row_id) %>%
#
#       # Clean up the table
#       select(case_id, activity, resource, lifecycle)
#
#     # Try to spread, but add row numbers in case of duplicate identifiers
#     tryCatch(
#       {
#         if(nrow(inconsistencies) > 0) {
#           inconsistencies <- inconsistencies %>%
#             spread(lifecycle, resource) %>% select(case_id, activity, start, complete)
#         } else {
#           return("No resource inconsistencies were found in the log.")
#         }
#       },
#       # An error indicates that duplicate entries were found: add row numbers and try again
#       error = function(e) {
#         inconsistencies <<- inconsistencies %>%
#           group_by(case_id, activity, lifecycle) %>%
#           mutate(r = row_number()) %>%
#           ungroup()
#
#         if(nrow(inconsistencies) > 0) {
#           inconsistencies <<- inconsistencies %>%
#             spread(lifecycle, resource) %>% select(case_id, activity, start, complete)
#         } else {
#           return("No resource inconsistencies were found in the log.")
#         }
#
#         #warning("At least two start events were linked with two complete events because of duplicate identifiers.\n")
#       }
#     )
#
#     # If either start or complete events are missing, there cannot be a resource inconsistency
#     if(!("start" %in% colnames(inconsistencies)) & !("complete" %in% colnames(inconsistencies))) {
#       return("No start events and no complete were found in the event log. Thus there are no resource inconsistencies.")
#     } else if (("start" %in% colnames(inconsistencies)) & !("complete" %in% colnames(inconsistencies))) {
#       return("Only start events were found in the event log. Thus there are no resource inconsistencies.")
#     } else if (!("start" %in% colnames(inconsistencies)) & ("complete" %in% colnames(inconsistencies))) {
#       return("Only complete events were found in the event log. Thus there are no resource inconsistencies.")
#     }
#
#     # Prepare the inconsistencies table for output:
#     #   Those activities with different resources
#     inconsistencies <- inconsistencies %>%
#       select(case_id, activity, start, complete) %>%
#       filter(start != complete)
#
#   }
#
#   #####                           #####
#   # Prepare and return / print output #
#   #####                           #####
#   n_anomalies <- nrow(inconsistencies)
#
#   # Return to the original names that were passed to the function so the user is not confused.
#   colnames(inconsistencies)[1] <- case_id_label
#   colnames(inconsistencies)[2] <- activity_label
#   if(!is.null(event_matching_label)){
#     colnames(event_log)[3] <- event_matching_label
#   }
#
#   # Print output
#
#   if (detect_only) {
#     return(inconsistencies)
#   } else {
#     if(!is.null(filter_condition)) {
#       cat("\n\nApplied filtering condition", filter_condition, "\n", "\n")
#     }
#
#     cat("*** OUTPUT ***", "\n")
#     cat("A total of", n_anomalies, "activity executions in the event log are classified as inconsistencies.", "\n", "\n")
#     cat("They are spread over the following cases and activities:", "\n")
#     print.data.frame(inconsistencies)
#   }
#
#
#   #####                               #####
#   # Solve the inconistencies if requested #
#   #####                               #####
#   if(!detect_only) {
#     response <- readline("Do you want to correct these entries in the event log? (Y/N) ")
#   } else {
#     response <- "Y"
#   }
#
#   if (str_to_lower(response) == "y" | stringr::str_length(response) == 0) {
#
#     # Get back to custom col names to make mutations easier
#     colnames(inconsistencies)[1] <- "case_id"
#     colnames(inconsistencies)[2] <- "activity"
#     if(!is.null(event_matching_label)){
#       colnames(inconsistencies)[3] <- "event_matching"
#     }
#
#     # Algorithm if a matching was already provided
#     if(!is.null(event_matching_label)){
#       # Continue working with the inconsistencies table, we have a copy of the log in which we can overwrite with the new results
#       inconsistencies <- inconsistencies %>%
#         # First of all, NAs should be indicated as inconsistency, but should NOT be overwritten.
#         # Example: if a start event is missing, which creates an inconsistency because there is no resource for the start, the resource should not
#         # become NA - resource x.
#         # Therefore, only overwrite resources if both are known and different from each other
#         filter(!is.na(start) & !is.na(complete)) %>%
#
#         # Create the new resource label
#         mutate(new = paste(start, complete, sep = " - "))
#
#       # Add these new resources to the original log, and only those new resources
#       solved <- inconsistencies %>%
#         select(-start, -complete) %>%
#         right_join(event_log.original) %>%
#
#         # overwrite the resource column with the 'new' column
#         mutate(resource = if_else(!is.na(new), new, resource)) %>%
#         select(-new) %>%
#
#         # Set the proper order of columns
#         select(case_id, activity, resource, lifecycle, event_matching, timestamp, everything())
#
#       # Return the result, with the original names of course
#       colnames(solved)[1] <- case_id_label
#       colnames(solved)[2] <- activity_label
#       colnames(solved)[3] <- resource_label
#       colnames(solved)[4] <- event_lifecycle_label
#       colnames(solved)[5] <- event_matching_label
#       colnames(solved)[6] <- timestamps_label
#       return(solved)
#     }
#
#
#     # Algorithm when custom matches had to be made
#     else {
#       inconsistencies <- inconsistencies %>%
#         # From the inconsistencies, get the rows which we can use to overwrite resource entries
#         filter(!is.na(start) & !is.na(complete)) %>%
#         # Now create the new resource label
#         mutate(new = paste(start, complete, sep = " - ")) %>%
#         # Gather so the entries can be merged with the working table
#         gather(lifecycle, resource, start, complete) %>%
#         select(case_id, activity, resource, lifecycle, new)
#
#       # Update the working table so it now also holds the new resource labels.
#       # We use the working table because it also still contains the row numbers
#       working_table <- working_table %>%
#         left_join(inconsistencies) %>%
#         filter(!is.na(new))
#
#       # Now use the working table to add the new resource labels to the original log
#       solved <- event_log.original %>%
#         left_join(working_table) %>%
#         mutate(resource = if_else(is.na(new), resource, new)) %>%
#         select(-row_id, -new) %>%
#
#         # Set the proper order of columns
#         select(case_id, activity, resource, lifecycle, timestamp, everything())
#
#       # Return the result, with the original names of course
#       colnames(solved)[1] <- case_id_label
#       colnames(solved)[2] <- activity_label
#       colnames(solved)[3] <- resource_label
#       colnames(solved)[4] <- event_lifecycle_label
#       colnames(solved)[5] <- timestamps_label
#       return(solved)
#     }
#   } else {
#     # The user responded no to correcting the entries
#     return(inconsistencies)
#   }
# }
