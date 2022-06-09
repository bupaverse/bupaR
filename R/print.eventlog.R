#' @title Generic print function for eventlog
#' @description Generic print function for eventlog
#' @param x Eventlog object
#' @param ... Additional Arguments
#' @importFrom pillar style_subtle
#' @importFrom purrr map_chr
#' @export

print.log <- function(x, ...) {

        if(nrow(x) > 0) {

       nev <- n_events(x)

        cat(map_chr(c("# Log of", nev, ngettext(nev, "event", "events"), "consisting of:\n"), style_subtle))
        if(nev < 250000) {
                ntr <- n_traces(x)
                cat(ntr, ngettext(ntr, "trace", "traces"), "\n")
        }
        ncs <- n_cases(x)
        cat(ncs, ngettext(ncs, "case", "cases"), "\n")
        nai <- n_activity_instances(x)
        nac <- n_activities(x)
        cat(
                nai, ngettext(nai, "instance", "instances"), "of",
                nac, ngettext(nac, "activity", "activities"), "\n"
        )
        nrs <- n_resources(x)
        cat(nrs, ngettext(nrs, "resource", "resources"), "\n")

        if("activitylog" %in% class(x)) {
        	timestamps <- gather(x[lifecycle_ids(x)]) %>% pull(.data[["value"]])
        } else {
        	timestamps <- x[[timestamp(x)]]

        }

        cat(
                "Events occurred from", format(min(timestamps)),
                "until", format(max(timestamps)), "\n", "\n"
        )
        cat(style_subtle("# Variables were mapped as follows:\n"))
        print(mapping(x))
        cat("\n")

        } else {
                cat("EMPTY EVENT LOG\n")
        }
        NextMethod(x)
}

#' @export
print.grouped_log <- function(x, ...) {
	groups <- groups(x)
	x <- ungroup_eventlog(x)
	cat(style_subtle(glue("# Groups: [{paste(groups, collapse = \", \")}]")))
	cat("\nGrouped ")
	print(x)
}
