#' @title Timestamp classifier
#'
#' @description Get the  timestamp classifier of an object of class \code{eventlog}
#'
#' @param eventlog An object of class \code{eventlog}.
#'
#' @seealso \code{\link{eventlog}}
#' @examples
#'
#'
#' data(example_log)
#' timestamp(example_log)
#'
#'
#' @export timestamp
#'
timestamp <- function(eventlog){
	if("eventlog" %in% class(eventlog))
		return(attr(eventlog, "timestamp"))
	else
		stop("Function only applicable on objects of type 'eventlog'")
}
