#' @title Life cycle classifier
#' @description Get the life_cycle_id of an object of class \code{eventlog}
#' @param eventlog An object of class \code{eventlog}.
#' @seealso \code{\link{eventlog}}, \code{\link{activity_instance_id}}
#' @export
lifecycle_id <- function(eventlog){
	if("eventlog" %in% class(eventlog))
		return(attr(eventlog, "lifecycle_id"))
	else
		stop("Function only applicable on objects of type 'eventlog'")
}
