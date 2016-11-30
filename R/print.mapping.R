#' @title Generic print function for eventlog_mapping
#' @description Generic print function for eventlog_mapping
#' @param x Eventlog mapping object
#' @param ... Additional Arguments
#' @method print eventlog_mapping
#' @export

print.eventlog_mapping <- function(x, ...) {
	mapping <- x

cat(paste0("Case identifier:\t\t", mapping$case_identifier),"\n")
cat(paste0("Activity identifier:\t\t", mapping$activity_identifier),"\n")
cat(paste0("Resource identifier:\t\t", mapping$resource_identifier),"\n")
cat(paste0("Activity instance identifier:\t", mapping$activity_instance_identifier),"\n")
cat(paste0("Timestamp:\t\t\t", mapping$timestamp_identifier),"\n")
cat(paste0("Lifecycle transition:\t\t", mapping$lifecycle_identifier),"\n")

}

