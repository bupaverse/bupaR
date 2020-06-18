
#' @export
magrittr::`%>%`

#' @importFrom rlang sym
#'
case_id_ <- function(eventlog) sym(case_id(eventlog))
activity_id_ <- function(eventlog) sym(activity_id(eventlog))
activity_instance_id_ <- function(eventlog) sym(activity_instance_id(eventlog))
resource_id_ <- function(eventlog) sym(resource_id(eventlog))
timestamp_ <- function(eventlog) sym(timestamp(eventlog))
lifecycle_id_ <- function(eventlog) sym(lifecycle_id(eventlog))

is_eventlog <- function(eventlog) {
	"eventlog" %in% class(eventlog)
}

is_grouped_eventlog <- function(eventlog) {
	"grouped_eventlog" %in% class(eventlog)
}


#' @importFrom lubridate ymd_hms
#' @export
lubridate::ymd_hms
#' @importFrom lubridate ymd_hm
#' @export
lubridate::ymd_hm
#' @importFrom lubridate ymd_h
#' @export
lubridate::ymd_h
#' @importFrom lubridate ymd
#' @export
lubridate::ymd
#' @importFrom lubridate dmy_hms
#' @export
lubridate::dmy_hms
#' @importFrom lubridate dmy_hm
#' @export
lubridate::dmy_hm
#' @importFrom lubridate dmy_h
#' @export
lubridate::dmy_h
#' @importFrom lubridate dmy
#' @export
lubridate::dmy
#' @importFrom lubridate mdy_hms
#' @export
lubridate::mdy_hms
#' @importFrom lubridate mdy_hm
#' @export
lubridate::mdy_hm
#' @importFrom lubridate mdy_h
#' @export
lubridate::mdy_h
#' @importFrom lubridate mdy
#' @export
lubridate::mdy


