#' @title Sample function for eventlog
#' @name sample_n
#' @param tbl Event log
#' @param size \code{\link{integer}}: Number of cases to sample
#' @param replace \code{\link{logical}} (default \code{FALSE}): Sample with replacement \code{TRUE} or without \code{FALSE}.
#' @param weight Sampling weights. This must evaluate to a vector of non-negative numbers the same length as the input.
#' Weights are automatically standardised to sum to 1.
#' @param .env Deprecated; please don't use.
#' @param ... ignored
#'
#' @seealso \code{\link{slice_sample}}
#' @importFrom dplyr sample_n
#' @export
dplyr::sample_n
#' @describeIn sample_n Sample n cases of eventlog
#' @export
sample_n.log <- function(tbl, size, replace = FALSE, weight = NULL, .env = NULL, ...) {

	lifecycle::signal_stage("superseded", "sample_n()")

	n_cases <- n_cases(tbl)

	if(!replace & size > n_cases) {
		stop(paste(c("Size parameter (", size, ") is larger than number of cases (", n_cases ,"). Do you want to use replace = T?"), collapse = ""))
	}

	case_ids <- case_labels(tbl)

	selection <- sample(case_ids, size = size, replace = replace)

	tbl %>%
		filter((!!as.symbol(case_id(tbl))) %in% selection)
}

#' @describeIn sample_n Stratified sampling of a grouped eventlog: sample n cases within each group
#' @method sample_n grouped_log
#' @export
sample_n.grouped_log <- function(tbl, size, replace = FALSE, weight = NULL, .env = NULL, ...) {

	lifecycle::signal_stage("superseded", "sample_n()")

	mapping <- mapping(tbl)

	tbl %>%
		nest() %>%
		# make sure that all grouping variables are in the nested data frames
		do({
			group_data <- select(., -data)
			.$data <- purrr::imap(.$data, ~ cbind(.x, group_data[.y,]))
			.
		}) %>%
		mutate(data = map(data, re_map, mapping)) %>%
		mutate(data = map(data, sample_n, size = size, replace = replace)) %>%
		# remove grouping variables to avoid duplicates
		mutate(data = map(data, ~ select_at(as.data.frame(.x), .vars = vars(-one_of(paste(mapping$groups)))))) %>%
		unnest(cols = data) %>%
		re_map(mapping) %>%
		# result should retain grouping
		group_by_at(vars(one_of(paste(mapping$groups)))) %>%
		return()

	#log %>%
	#	apply_grouped_fun(fun = sample_n.eventlog, size, replace, .keep_groups = TRUE, .returns_log = TRUE)
}
