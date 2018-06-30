#' @title Select event log
#' @name select
#' @param .data Eventlog
#' @param ... Bare column names
#' @param force_df If TRUE, result will no longer be a event log when not all id columns are selected.
#' @importFrom dplyr select
#' @export
dplyr::select

#' @describeIn select Select eventlog
#' @export
select.eventlog <- function(.data, ..., force_df = FALSE) {
	.order <- NULL

	mapping <- mapping(.data)

	if(force_df == FALSE) {

	.data %>%
		as.data.frame() %>%
		dplyr::select(...,
					  !!case_id_(.data),
					  !!activity_id_(.data),
					  !!activity_instance_id_(.data),
					  !!timestamp_(.data),
					  !!resource_id_(.data),
					  !!lifecycle_id_(.data),
					  .order) %>%
		re_map(mapping) %>%
		return()
	}
	else {
		.data %>%
			as.data.frame() %>%
			dplyr::select(...) %>%
			tbl_df() %>%
			return()
	}
}

