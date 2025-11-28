#' @title Get vector of resource labels
#' @description Retrieve a vector containing all unique resource labels
#' @inheritParams act_collapse
#' @export
resource_labels <- function(log) {
	UseMethod("resource_labels")
}

#' @describeIn resource_labels Retrieve resource labels from eventlog
#' @export
resource_labels.default <- function(log) {
	unique(log[[resource_id(log)]])
}
