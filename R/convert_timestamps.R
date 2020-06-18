#' Convert timestamp format
#'
#' Function converting the timestamps in the data frame to the appropriate format.
#'
#' @param x Data.frame containing events or activities.
#' @param columns A character vector with one or more names of columns to convert
#' @param format The format of the timestamps in the original dataset (either ymd_hms, dmy_hms, ymd_hm, ymd, dmy, dmy, ...). To be provided without quotation marks!
#' @return Data.frame with converted timestamps
#' @family Eventlog construction helpers
#' @export
convert_timestamps <- function(x, columns,  format){


	stopifnot("data.frame" %in% class(x))

	if(!("character" %in% class(columns) | length(columns) < 1)) {
		stop("columns should be a character vector with one or more elements.")
	}
	if(any(!(columns %in% names(x)))) {
		warning(glue::glue("The following columns are not found and ignored: {str_c(columns[!(columns %in% names(x))], collapse = ', ')}.Did you spell them wrong?"))
		columns <- columns[(columns %in% names(x))]
	}
	if(!(deparse(substitute(format))  %in% c("ymd_hms", "ymd_hm", "ymd_h","ymd",
											 "dmy_hms", "dmy_hm", "dmy_h", "dmy",
											 "mdy_hms", "mdy_hm", "mdy_h", "mdy")) | length(format) > 1) {
		stop("format should be one of the following: ymd_hms, ymd_hm, ymd_h, ymd, dmy_hms, dmy_hm, dmy_h, dmy, mdy_hms, mdy_hm, mdy_h, md")
	}
	if(!(deparse(substitute(format)) %in% c("ymd_hms", "dmy_hms", "mdy_hms"))) {
		warning("No seconds available? Timestamps will probably too coarse for reliable analyses.")
	}

	x <- mutate_at(x, columns, format)

	return(x)
}
