#' @title Sample function for eventlog
#' @param tbl Eventlog
#' @param size Number of cases to sample
#' @param replace Sample with replacement or not
#' @param weight N/A
#' @param .env N/A
#' @name sample_n
#' @importFrom dplyr sample_n
#' @export
dplyr::sample_n

#' @describeIn sample_n Sample n cases of eventlog
#' @export

sample_n.eventlog <- function(tbl,size, replace = FALSE, weight, .env, ...) {


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
		filter((!!as.symbol(case_id(tbl))) %in% selection)
}


#' @describeIn sample_n Stratified sampling of a grouped eventlog: sample n cases within each group
#' @method sample_n grouped_eventlog
#' @export

sample_n.grouped_eventlog <- function(tbl, size, replace = FALSE, weight, .env, ...) {

	mapping <- mapping(tbl)

	tbl %>%
		nest() %>%
		mutate(data = map(data, re_map, mapping)) %>%
		mutate(data = map(data, sample_n, size = size, replace = replace)) %>%
		unnest() %>%
		re_map(mapping) %>%
		return()



}
