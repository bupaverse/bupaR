#' @title Eventlog
#'
#' @description A function to instantiate an object of class \code{eventlog} by specifying a
#' \code{data.frame} or \code{tibble} and appropriate case, activity and
#' timestamp classifiers.
#'
#'
#' @param eventlog The data object to be used as event log. This can be a
#' \code{data.frame} or \code{tibble}.
#'
#' @param case_id The case classifier of the event log. A character vector containing variable names of length 1 or more.
#' @param activity_id The activity classifier of the event log. A character vector containing variable names of length 1 or more.
#' @param activity_instance_id The activity instance classifier of the event log.
#' @param lifecycle_id The life cycle classifier of the event log.
#' @param timestamp The timestamp of the event log. Should refer to a Date or POSIXct field.
#' @param resource_id The resource identifier of the event log. A character vector containing variable names of length 1 or more.
#' @param order Configure how to handle sort events with equal timestamps:
#' auto will use the order in the original data,
#' alphabetical will sort the activity labels by alphabet,
#' sorted will assume that the data frame is already correctly sorted and has a column '.order',
#' providing a column name will use this column for ordering (can be numeric of character).
#' The latter will never overrule timestamp orderings.
#' @param validate When `TRUE` some basic checks are run on the contents of the event log such as that activity instances are
#'  not connected to more than one case or activity. Using `FALSE` improves the performance by skipping those checks.
#'
#' @seealso \code{\link{case_id}}, \code{\link{activity_id}},
#' \code{\link{activity_instance_id}},\code{\link{lifecycle_id}},
#'  \code{\link{timestamp}}
#'
#' @examples
#' \dontrun{
#' data <- data.frame(case = rep("A",5),
#' activity_id = c("A","B","C","D","E"),
#' activity_instance_id = 1:5,
#' lifecycle_id = rep("complete",5),
#' timestamp = 1:5,
#' resource = rep("resource 1", 5))
#' eventlog(data,case_id = "case",
#' activity_id = "activity_id",
#' activity_instance_id = "activity_instance_id",
#' lifecycle_id = "lifecycle_id",
#' timestamp = "timestamp",
#' resource_id = "resource")
#' }
#' @export eventlog

eventlog <- function(eventlog, case_id, activity_id, activity_instance_id, lifecycle_id, timestamp, resource_id, order, validate) {
	UseMethod("eventlog")
}

#' @export

eventlog.data.frame  <- function(eventlog,
					 case_id = NULL,
					 activity_id = NULL,
					 activity_instance_id = NULL,
					 lifecycle_id = NULL,
					 timestamp = NULL,
					 resource_id = NULL,
					 order = "auto",
					 validate = TRUE){

	stopifnot(is.data.frame(eventlog))
	eventlog <- as_tibble(eventlog)
	class(eventlog) <- c("eventlog", "log", class(eventlog))


	args_values <- as.list(environment())[c("case_id","activity_id","activity_instance_id","lifecycle_id","resource_id")]
	args_names <- args_values %>% names

	attribute_list <- pmap(list(args_values, args_names),
						   ~list(attribute_name = ..2,
						   	  attribute_values = ..1))


	eventlog <- purrr::reduce(.x = attribute_list, .f = check_wrapper, .init = eventlog)


	if(is.null(timestamp)) {
		if(!is.null(timestamp(eventlog))) {
			#message("Recovered existing timestamp")
		}
		else
			stop("No timestamp provided nor found")
	}
	else {
		if(!(timestamp %in% colnames(eventlog)))
			stop("Timestamp classifier not found")
		else if(!any(c("POSIXct","Date") %in% (eventlog %>% pull(!!as.symbol(timestamp)) %>% class()))) {
			stop("Timestamp should be a POSIXct or Date variable.")
		} else
			attr(eventlog, "timestamp") <- timestamp
	}

	if (validate) {
		validate_eventlog(eventlog)
	}

	if(length(order) == 1 && order %in% c("auto","alphabetical",colnames(eventlog))) {

		eventlog$.order_auto <- seq_len(nrow(eventlog))

		if(order == "auto") {

			eventlog$.order <- eventlog$.order_auto

		} else if(order == "alphabetical") {

			eventlog$.order <- order(order(eventlog[[activity_id(eventlog)]], eventlog$.order_auto))

		} else {
			eventlog$.order <- order(order(eventlog[[order]], eventlog$.order_auto))
		}

		eventlog$.order_auto <- NULL

	} else if (order != "sorted" || !(".order" %in% colnames(eventlog))) {
		stop("Order should be a character with value 'auto', 'alphabetical', 'sorted', or a valid column-name")
	}


	mapping <- mapping(eventlog)

	return(eventlog)
}





check_wrapper  <- function(eventlog, attributes) {
	check_attributes(eventlog, attributes$attribute_name, attributes$attribute_values)
}


check_attributes <- function(eventlog, attribute_name, attribute_values) {
	FUN <- ifelse(attribute_name == "case_id", bupaR::case_id,
				  ifelse(  attribute_name == "activity_id", bupaR::activity_id,
				  		 ifelse(  attribute_name == "activity_instance_id", bupaR::activity_instance_id,
				  		 		 ifelse( attribute_name == "resource_id", bupaR::resource_id, bupaR::lifecycle_id))))



	if(is.null(attribute_values)) {
		if(!is.null(FUN(eventlog))) {
			#message(glue("Recovered existing {attribute_name}"))
		}
		else {
			stop(glue("No {attribute_name} provided nor found"))
		}
	} else if(length(attribute_values) == 1) {
		if(!(attribute_values %in% colnames(eventlog))) {
			stop(glue("{attribute_name} not found in data.frame"))
		} else {
			attr(eventlog, attribute_name) <- attribute_values
		}
	} else {
		if(any(!(attribute_values %in% colnames(eventlog))))
			stop(glue("One or more {attribute_name} not found"))
		else {

			merge_col <- eventlog[,attribute_values]
			merged_values <- purrr::reduce(merge_col, paste, sep = "_")
			eventlog[[paste0(attribute_values, collapse = "_")]] <- merged_values
			attr(eventlog, attribute_name) <- paste0(attribute_values, collapse =  "_")
		}
	}
	return(eventlog)
}


#' @rdname eventlog
#' @export ieventlog
ieventlog <- function(eventlog){

	ui <- miniPage(
		gadgetTitleBar("Create eventlog"),
		miniContentPanel(
			fillRow(fillCol(
				selectizeInput("case_id", "Case identifier", choices = c("",colnames(eventlog)),
							   selected = ifelse(is.null(attr(eventlog, "case_id")), NA, attr(eventlog, "case_id"))),
				selectizeInput("activity_id", "Activity identifier", choices = c("",colnames(eventlog)),
							   selected = ifelse(is.null(attr(eventlog, "activity_id")), NA, attr(eventlog, "activity_id"))),

				selectizeInput("activity_instance_id", "Activity instance", choices =  c("",colnames(eventlog)),
							   selected = ifelse(is.null(attr(eventlog, "activity_instance_id")), NA, attr(eventlog, "activity_instance_id")))),

				fillCol(
					selectizeInput("lifecycle_id", "Lifecycle", choices =  c("",colnames(eventlog)),
								   selected = ifelse(is.null(attr(eventlog, "lifecycle_id")), NA, attr(eventlog, "lifecycle_id"))),
					selectizeInput("timestamp", "Timestamp", choices =  c("",colnames(eventlog)),
								   selected = ifelse(is.null(attr(eventlog, "timestamp")), NA, attr(eventlog, "timestamp"))),

					selectizeInput("resource_id", "Resource identifier",  choices =  c("",colnames(eventlog)),
								   selected = ifelse(is.null(attr(eventlog, "resource_id")), NA, attr(eventlog, "resource_id"))))

			))
	)

	server <- function(input, output, session){
		observeEvent(input$done, {
			stopApp(eventlog(eventlog = eventlog,
							 case_id = input$case_id,
							 activity_id = input$activity_id,
							 activity_instance_id = input$activity_instance_id,
							 lifecycle_id = input$lifecycle_id,
							 timestamp = input$timestamp,
							 resource_id = input$resource_id))
		})


	}

	runGadget(ui, server, viewer = dialogViewer("Create event log", height = 400))

}


validate_eventlog <- function(eventlog) {

	eventlog %>%
		group_by(!!as.symbol(activity_instance_id(eventlog))) %>%
		summarize(n_cases = n_distinct(!!as.symbol(case_id(eventlog))),
				  n_act = n_distinct(!!as.symbol(activity_id(eventlog))),
				  n_resource = n_distinct(!!as.symbol(resource_id(eventlog)))) -> t

	n_cases <- NULL
	n_act <- NULL
	n_resource <- NULL

	t %>%
		filter(n_cases > 1) -> violation_cases
	t %>%
		filter(n_act > 1) -> violation_activities
	t %>%
		filter(n_resource > 1) -> violation_resources


	if(nrow(violation_cases) >0) {
		stop(glue("The following activity instances are connected to more than one case: {paste(violation_cases %>% pull(1), collapse = \",\")}"))
	}
	if(nrow(violation_activities) > 0) {
		stop(glue("The following activity instances are connected to more than one activity: {paste(violation_activities %>% pull(1), collapse = \",\")}"))
	}
	if(nrow(violation_resources) > 0) {
		warning(glue("The following activity instances are connected to more than one resource: {paste(violation_resources %>% pull(1), collapse = \",\")}\n"))
	}

	TRUE

}
