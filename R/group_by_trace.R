#' @title Group a log on trace 
#' @description Group a log by trace
#' @inheritParams act_collapse


#' @export group_by_trace
group_by_trace <- function(log) {
  UseMethod("group_by_trace")
}

#' @export
group_by_trace.log <- function(log) {
  trace_id <- NULL
  cl <- case_list(log)
  dplyr::left_join(log, cl, by = case_id(log)) %>%
    group_by(trace, trace_id)
}

