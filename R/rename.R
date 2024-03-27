


#' @title Rename log
#' @param .data \code{\link{log}}: Object of class \code{\link{eventlog}} or \code{\link{activitylog}}.
#' @param ... Variables to rename. Use "new_name" = "old_name" to rename selected variables.
#' @name rename
#' @importFrom dplyr rename
#' @export
dplyr::rename


#' @describeIn rename Rename log 
#' @export

rename.log <- function(.data, ...) {
  
  
  renames <- list(...)
  mapping <- mapping(.data)

  if(mapping$case_identifier %in% renames) {
    mapping$case_identifier <- names(renames)[renames == mapping$case_identifier]

  }
  if(mapping$activity_identifier          %in% renames) {
    mapping$activity_identifier          <- names(renames)[renames == mapping$activity_identifier         ]
  }
  if(mapping$resource_identifier          %in% renames) {
    mapping$resource_identifier          <- names(renames)[renames == mapping$resource_identifier         ]
  }

  if(is.eventlog(.data)) {
    if(mapping$activity_instance_identifier %in% renames) {
      mapping$activity_instance_identifier <- names(renames)[renames == mapping$activity_instance_identifier]
    }
    if(mapping$lifecycle_identifier         %in% renames) {
      mapping$lifecycle_identifier         <- names(renames)[renames == mapping$lifecycle_identifier        ]
    }
    if(mapping$timestamp_identifier         %in% renames) {
      mapping$timestamp_identifier         <- names(renames)[renames == mapping$timestamp_identifier        ]
    }
  } else {
    for(i in 1:length(mapping$timestamps)) {
      if(mapping$timestamps[i] %in% renames) {
        mapping$timestamps[i] <- names(renames)[renames == mapping$timestamps[i]]
      }
    }
  }
  .data %>%
    as_tibble() %>%
    rename(...) %>%
    re_map(mapping)
}

#' @describeIn rename Rename grouped log 
#' @export

rename.grouped_log <- function(.data, ...) {
  
  groups <- groups(.data)
  
  renames <- list(...)
  mapping <- mapping(.data)
  mapping[mapping %in% renames] <- names(renames)
  
  .data %>%
    as_tibble() %>%
    rename(...) %>%
    re_map(mapping) %>%
    group_by(pick(as.character(groups)))
}
