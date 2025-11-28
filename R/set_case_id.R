
#' Set case id of log
#'
#' @inheritParams act_collapse
#' @param case_id New case id
#' @family Classifiers

#'
#' @export
#'
set_case_id <- function(log, case_id) {
	UseMethod("set_case_id")
}
#'
#' @describeIn set_case_id Set case id
#' @export
set_case_id.default <- function(log, case_id) {
	set_id(log, "case_id", case_id)
}
