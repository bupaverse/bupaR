


#' @title Rename log
#' @name count
#' @param .data \code{\link{log}}: Object of class \code{\link{eventlog}} or \code{\link{activitylog}}.
#' @param ... Variables to rename. Use "new_name" = "old_name" to rename selected variables.
#' @importFrom dplyr rename
#' @export
dplyr::rename


#' @describeIn rename Rename log 
#' @export

rename.log <- function(.data, ...) {
  
  
  renames <- list(...)
  mapping <- mapping(.data)
  mapping[mapping %in% renames] <- names(renames)

  .data %>%
    as_tibble() %>%
    rename(...) %>%
    re_map(mapping)
}
