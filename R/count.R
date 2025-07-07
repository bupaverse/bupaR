


#' @title Count log
#' @name count
#' @param x \code{\link{log}}: Object of class \code{\link{eventlog}} or \code{\link{activitylog}}.
#' @param ... Additional arguments passed to [dplyr][count]
#' @inheritParams dplyr::count
#' @importFrom dplyr count
#' @export
dplyr::count


#' @describeIn count Count log 
#' @export

count.log <- function(x, ...) {
  
  x %>%
    as_tibble() %>%
    count(...) 

}

#' @describeIn count Count grouped log 
#' @export

count.grouped_log <- function(x, ...) {
  
  x %>%
    as_tibble() %>%
    group_by(pick(as.character(groups(x)))) %>%
    count(...) 
  
}