#' @title Select event log
#' @name select
#' @param force_df If TRUE, result will no longer be a event log when not all id columns are selected.
#' @inheritDotParams dplyr::select
#' @inheritParams dplyr::select
#' @importFrom dplyr select
#' @rdname select
# #' @export
#' dplyr::select

#' @export
select.eventlog <- function(.data, ..., force_df = FALSE) {
	mapping <- mapping(.data)

	if(force_df == FALSE) {
		.data %>%
			as.data.frame() %>%
			dplyr::select(...,
						  all_of(c(case_id(mapping),
						  		 activity_id(mapping),
						  		 activity_instance_id(mapping),
						  		 timestamp(mapping),
						  		 resource_id(mapping),
						  		 lifecycle_id(mapping),
						  		 ".order"))) %>%
			re_map(mapping)
	}
	else {
		.data %>%
			as.data.frame() %>%
			dplyr::select(...) %>%
			as_tibble()
	}
}

#' @export
select.grouped_eventlog <- function(.data, ..., force_df = FALSE) {
	groups <- groups(.data)
	mapping <- mapping(.data)


	if(force_df == FALSE) {
		.data %>%
			as.data.frame() %>%
			dplyr::select(...,
						  all_of(c(case_id(mapping),
						  		 activity_id(mapping),
						  		 activity_instance_id(mapping),
						  		 timestamp(mapping),
						  		 resource_id(mapping),
						  		 lifecycle_id(mapping),
						  		 ".order"))) %>%
			re_map(mapping) -> .data
	}
	else {
		.data %>%
			as.data.frame() %>%
			dplyr::select(all_of(paste(groups)), ...) %>%
			as_tibble() -> .data
	}

	.data %>%
		group_by_at(vars(all_of(paste(groups))))

}
#' @export
select.activitylog <- function(.data, ..., force_df = FALSE) {
	mapping <- mapping(.data)

	if(force_df == FALSE) {
		.data %>%
			as.data.frame() %>%
			dplyr::select(...,
						  all_of(c(case_id(mapping),
						  		 activity_id(mapping),
						  		 resource_id(mapping),
						  		 timestamps(mapping),
						  		 ".order"))) %>%
			re_map(mapping)
	}
	else {
		.data %>%
			as.data.frame() %>%
			dplyr::select(...) %>%
			as_tibble()
	}
}
#' @export
select.grouped_activitylog <- function(.data, ..., force_df = FALSE) {
	groups <- groups(.data)
	mapping <- mapping(.data)


	if(force_df == FALSE) {
		.data %>%
			as.data.frame() %>%
			dplyr::select(...,
						  all_of(c(case_id(mapping),
						  		 activity_id(mapping),
						  		 resource_id(mapping),
						  		 timestamps(mapping),
						  		 ".order"))) %>%
			re_map(mapping) -> .data
	}
	else {
		.data %>%
			as.data.frame() %>%
			dplyr::select(all_of(paste(groups)), ...) %>%
			as_tibble() -> .data
	}

	.data %>%
		group_by_at(vars(all_of(paste(groups))))
}

