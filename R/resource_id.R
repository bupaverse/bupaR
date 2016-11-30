#' @title Resource classifier
#' @description Get the resource classifier of an object of class \code{eventlog}.
#' @param eventlog An object of class \code{eventlog}.
#' @seealso \code{\link{eventlog}}, \code{\link{case_id}}, \code{\link{activity_instance_id}},
#' \code{\link{timestamp}}
#' @examples
#' data(example_log)
#' resource_id(example_log)
#' @export resource_id

resource_id <- function(eventlog){
	if("eventlog" %in% class(eventlog))
		return(attr(eventlog, "resource_id"))
	else
		stop("Function only applicable on objects of type 'eventlog'")
}
