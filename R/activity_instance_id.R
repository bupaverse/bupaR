#' @title Activity instance classifier
#' @description Get the activity instance classifier of an object of class \code{eventlog}.
#' @param eventlog An object of class \code{eventlog}.
#' @seealso \code{\link{eventlog}}, \code{\link{activity_id}},
#' \code{\link{timestamp}},
#' \code{\link{case_id}}
#' @examples
#' data(example_log)
#' activity_instance_id(example_log)
#' @export
activity_instance_id <- function(eventlog){
	if("eventlog" %in% class(eventlog))
		return(attr(eventlog, "activity_instance_id"))
	else
		stop("Function only applicable on objects of type 'eventlog'")
}
