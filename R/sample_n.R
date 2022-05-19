#' @title Sample function for eventlog
#'
#' @description Takes a sample of the specified \code{size} from the cases of \code{log}, either with or without replacement.
#'
#' @param log \code{\link{log}}: Object of class \code{\link{log}}, \code{\link{eventlog}}, or \code{\link{activitylog}}.
#' @param tbl Deprecated; please use \code{log} instead.
#' @param size \code{\link{integer}}: Number of cases to sample
#' @param replace \code{\link{logical}} (default \code{FALSE}): Sample with replacement \code{TRUE} or without \code{FALSE}.
#' @param weight Sampling weights. This must evaluate to a vector of non-negative numbers the same length as the input.
#' Weights are automatically standardised to sum to 1.
#' @param .env Deprecated; please don't use.
#'
#' @importFrom dplyr sample_n
#' @export
sample_n <- function(log, tbl = deprecated(), size, replace = FALSE, weight = NULL, .env = deprecated()) {
	UseMethod("sample_n")
}

#' @describeIn sample_n Sample n cases of eventlog
#' @export
sample_n.eventlog <- function(log, tbl = deprecated(), size, replace = FALSE, weight = NULL, .env = deprecated()) {

	log <- lifecycle_warning_tbl(log, tbl)

	n_cases <- n_cases(log)

	if(!replace & size > n_cases) {
		stop(paste(c("Size parameter (", size, ") is larger than number of cases (", n_cases ,"). Do you want to use replace = T?"), collapse = ""))
	}

	case_ids <- case_labels(log)


	selection <- sample(case_ids, size = size, replace = replace)

	log %>%
		filter((!!as.symbol(case_id(log))) %in% selection)
}


#' @describeIn sample_n Stratified sampling of a grouped eventlog: sample n cases within each group
#' @method sample_n grouped_eventlog
#' @export
sample_n.grouped_eventlog <- function(log, tbl = deprecated(), size, replace = FALSE, weight = NULL, .env = deprecated()) {

	log <- lifecycle_warning_tbl(log, tbl)

	mapping <- mapping(log)

	log %>%
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

#' @describeIn sample_n Sample n cases from an \code{\link{activitylog}}.
#' @export
sample_n.activitylog <- function(log, tbl = deprecated(), size, replace = FALSE, weight = NULL, .env = deprecated()) {

	log <- lifecycle_warning_tbl(log, tbl)

	n_cases <- n_cases(log)

	if(!replace & size > n_cases) {
		stop(paste(c("Size parameter (", size, ") is larger than number of cases (", n_cases ,"). Do you want to use replace = T?"), collapse = ""))
	}

	case_ids <- log %>%
		distinct(.data[[case_id(.)]])

	sample <- case_ids %>%
		as.data.frame() %>%
		slice_sample(n = size, weight_by = weight, replace = replace)

	log %>%
		filter(.data[[case_id(.)]] %in% sample)
}

#' @describeIn sample_n Sample n cases from a \code{\link{grouped_activitylog}}.
#' @export
sample_n.grouped_activitylog <- function(log, tbl = deprecated(), size, replace = FALSE, weight = NULL, .env = deprecated()) {

	log <- lifecycle_warning_tbl(log, tbl)

	mapping <- mapping(log)

	apply_grouped_fun(to_eventlog(log), fun = sample_n.eventlog, size = size, replace = replace, .keep_groups = TRUE, .returns_log = TRUE) %>%
		to_activitylog() %>%
		group_by_at(vars(one_of(paste(mapping$groups))))
}