#' @title Sample function for eventlog
#' @description Return a sample of n cases of an event log object
#' @param tbl Eventlog
#' @param size Number of cases to sample
#' @param replace Sample with replacement or not
#' @param weight N/A
#' @param .env N/A
#' @method sample_n eventlog
#' @export

sample_n.eventlog <- function(tbl,size, replace = FALSE, weight, .env) {


	n_cases <- n_cases(tbl)

	if(!replace & size > n_cases) {
		stop(paste(c("Size parameter (", size, ") is larger than number of cases (", n_cases ,"). Do you want to use replace = T?"), collapse = ""))
	}

	case_ids <- tbl %>%
		rename_("case_classifier" = case_id(tbl)) %>%
		.$case_classifier %>%
		unique

	selection <- sample(case_ids, size = size, replace = replace)

	tbl %>%
		filter_case(cases = selection) %>%
		return()
}

