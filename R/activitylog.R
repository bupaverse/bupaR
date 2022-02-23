#' Create activity log
#'
#' @param activitylog The data object to be used as activity log. This can be a
#' \code{data.frame} or \code{tibble}.
#' @param case_id The case classifier of the activity log. A character vector containing variable names of length 1 or more.
#' @param activity_id The activity classifier of the activity log. A character vector containing variable names of length 1 or more.
#' @param resource_id The resource identifier of the activity log. A character vector containing variable names of length 1 or more.
#' @param lifecycle_ids The columns with timestamps refering to different lifecycle events. A character vector of 1 or more.
#' These should have one of the folliwing names: "schedule","assign","reassign","start","suspend","resume","abort_activity","abort_case","complete","manualskip","autoskip".
#' These columns should be of the Date or POSIXct class.
#' @inheritParams eventlog
#' @importFrom purrr pmap
#' @export
#'
activitylog <- function(activitylog, case_id, activity_id, resource_id, lifecycle_ids, order) {
	UseMethod("activitylog")
}


#' @export

activitylog.data.frame <- function(activitylog,
								   case_id = NULL,
								   activity_id = NULL,
								   resource_id = NULL,
								   lifecycle_ids = c("start","complete"),
								   order = "auto") {


	activitylog <- as_tibble(activitylog)
	class(activitylog) <- c("activitylog", "log",class(activitylog))


	allowed_lifecycles <- c("schedule","assign","reassign","start","suspend","resume","abort_activity","abort_case","complete","manualskip","autoskip")

	if(any(!(lifecycle_ids %in% allowed_lifecycles))) {
		stop(glue::glue("Lifecycles {str_subset(lifecycle_ids, allowed_lifecycles, negate = F)} are not allowed. Allowed lifecycles: {str_c(allowed_lifecycles, collapse = \", \")}"))
	}

	args_values <- as.list(environment())[c("case_id","activity_id","resource_id")]
	args_names <- args_values %>% names

	attribute_list <- pmap(list(args_values, args_names),
						   ~list(attribute_name = ..2,
						   	  attribute_values = ..1))

	activitylog <- purrr::reduce(.x = attribute_list, .f = check_wrapper_activitylog, .init = activitylog)

	if(is.null(lifecycle_ids)) {
		stop("No lifecycles provided nor found")
	}
	else if(any(!(lifecycle_ids %in% names(activitylog))))
		stop(glue::glue("Lifecycles {str_c(str_subset(lifecycle_ids, names(activitylog), negate = T), collapse = ',')} not found"))
	else {
		for(i in seq_along(lifecycle_ids)) {
			if(!any(c("POSIXct","Date") %in% (activitylog %>% pull(!!as.symbol(lifecycle_ids[[i]])) %>% class())))
				stop(glue::glue("Column {lifecycle_ids[[i]]} should be a POSIXct or Date variable."))


		}
	}
	attr(activitylog, "lifecycle_ids") <- lifecycle_ids

	if(length(order) == 1 && order %in% c("auto","alphabetical",colnames(activitylog))) {

		activitylog$.order_auto <- seq_len(nrow(activitylog))

		if(order == "auto") {

			activitylog$.order <- activitylog$.order_auto

		} else if(order == "alphabetical") {

			activitylog$.order <- order(order(activitylog[[activity_id(activitylog)]], activitylog$.order_auto))

		} else {
			activitylog$.order <- order(order(activitylog[[order]], activitylog$.order_auto))
		}

		activitylog$.order_auto <- NULL

	} else if (order != "sorted" || !(".order" %in% colnames(activitylog))) {
		stop("Order should be a character with value 'auto', 'alphabetical', 'sorted', or a valid column-name")
	}


	activitylog

}

check_wrapper_activitylog  <- function(activitylog, attributes) {
	check_attributes_activitylog(activitylog, attributes$attribute_name, attributes$attribute_values)
}

check_attributes_activitylog <- function(activitylog, attribute_name, attribute_values) {

	FUN <- ifelse(attribute_name == "case_id", bupaR::case_id,
				  ifelse(  attribute_name == "activity_id", bupaR::activity_id,
				  		 ifelse( attribute_name == "resource_id", bupaR::resource_id)))


	if(is.null(attribute_values)) {
		if(!is.null(FUN(activitylog))) {
			#message(glue("Recovered existing {attribute_name}"))
		}
		else {
			stop(glue("No {attribute_name} provided"))
		}
	} else if(length(attribute_values) == 1) {
		if(!(attribute_values %in% names(activitylog))) {
			stop(glue("{attribute_name} not found in data.frame"))
		} else {
			attr(activitylog, attribute_name) <- attribute_values
		}
	} else {
		if(any(!(attribute_values %in% names(activitylog))))
			stop(glue("One or more {attribute_name} not found"))
		else {

			merge_col <- activitylog[,attribute_values]
			merged_values <- purrr::reduce(merge_col, paste, sep = "_")
			activitylog[[paste0(attribute_values, collapse = "_")]] <- merged_values
			attr(activitylog, attribute_name) <- paste0(attribute_values, collapse =  "_")
		}
	}
	return(activitylog)
}

