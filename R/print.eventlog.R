#' @title Generic print function for eventlog
#' @description Generic print function for eventlog
#' @param x Eventlog object
#' @param ... Additional Arguments
#' @export


print.eventlog <- function(x, ...) {
       nev <- n_events(x)

        cat("Log of", nev, ngettext(nev, "event", "events"), "consisting of:\n")
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
        timestamps <- x[[timestamp(x)]]
        cat(
                "Events occurred from", format(min(timestamps)),
                "until", format(max(timestamps)), "\n", "\n"
        )
        cat("Variables were mapped as follows:\n")
        print(mapping(x))
        cat("\n")
	NextMethod(x)
}

#' @export
print.grouped_eventlog <- function(x, ...) {
	groups <- groups(x)
	x <- eventlog(x, validate = FALSE, order = "sorted")
	cat(glue("# Groups: [{paste(groups, collapse = \", \")}]"))
	cat("\nGrouped ")
	NextMethod(x)
}
