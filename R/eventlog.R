#' @title Eventlog
#'
#' @description A function to instantiate an object of class \code{eventlog} by specifying a
#' \code{data.frame} or \code{tbl_df} and appropriate case, activity and
#' timestamp classifiers.
#'
#'
#' @param eventlog The data object to be used as event log. This can be a
#' \code{data.frame} or \code{tbl_df}.
#'
#' @param case_id The case classifier of the event log.
#'
#' @param activity_id The activity classifier of the event log.
#'
#' @param activity_instance_id The activity instance classifier of the event log.
#'
#' @param lifecycle_id The life cycle classifier of the event log.
#'
#' @param timestamp The timestamp of the event log.
#'
#' @param resource_id The resource identifier of the event log.
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


eventlog <- function(eventlog,
					 case_id = NULL,
					 activity_id = NULL,
					 activity_instance_id = NULL,
					 lifecycle_id = NULL,
					 timestamp = NULL,
					 resource_id = NULL){

	eventlog <- tbl_df(as.data.frame(eventlog))

	class(eventlog) <- c("eventlog",class(eventlog))

	if(is.null(case_id)){
		if(!is.null(case_id(eventlog)))
			message("Recovered existing case_id")
		else
			stop("No case_id provided nor found")
	}
	else {
		if(!(case_id %in% colnames(eventlog)))
			stop("Case classifier not found")
		else
			attr(eventlog, "case_id") <- case_id
	}

	if(is.null(activity_id)){
		if(!is.null(activity_id(eventlog)))
			message("Recovered existing activity_id")
		else
			stop("No activity_id provided nor found")
	}
	else{
		if(!(activity_id %in% colnames(eventlog)))
			stop("Activity classifier not found")
		else
			attr(eventlog, "activity_id") <- activity_id
	}

	if(is.null(activity_instance_id)){
		if(!is.null(activity_instance_id(eventlog)))
			message("Recovered existing activity_instance_id")
		else
			stop("No activity instance id provided nor found")
	}
	else {
		if(!(activity_instance_id %in% colnames(eventlog)))
			stop("Activity instance id classifier not found")
		else
			attr(eventlog, "activity_instance_id") <- activity_instance_id
	}
	if(is.null(lifecycle_id)) {
		if(!is.null(lifecycle_id(eventlog)))
			message("Recovered existing lifecycle_id")
		else
			stop("No lifecycle id provided nor found")
	}
	else {
		if(!(lifecycle_id %in% colnames(eventlog)))
			stop("lifecycle id classifier not found")
		else
			attr(eventlog, "lifecycle_id") <- lifecycle_id
	}
	if(is.null(timestamp)) {
		if(!is.null(timestamp(eventlog)))
			message("Recovered existing timestamp")
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
	if(is.null(resource_id)) {
		if(!is.null(resource_id(eventlog)))
			message("Recovered existing resource identifier")
		else {
			warning("No resource identifier provided nor found. Set to default: NA")
			attr(eventlog, "resource_id") <- NA
		}
	}
	else {
		if(!(resource_id %in% colnames(eventlog)))
			stop("Resource identifier not found")
		else
			attr(eventlog, "resource_id") <- resource_id
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

