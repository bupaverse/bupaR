% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/lifecycles.R
\name{lifecycles}
\alias{lifecycles}
\alias{lifecycles.eventlog}
\alias{lifecycles.grouped_eventlog}
\alias{lifecycles.activitylog}
\alias{lifecycles.grouped_activitylog}
\title{Life cycles}
\usage{
lifecycles(log, eventlog = deprecated())

\method{lifecycles}{eventlog}(log, eventlog = deprecated())

\method{lifecycles}{grouped_eventlog}(log, eventlog = deprecated())

\method{lifecycles}{activitylog}(log, eventlog = deprecated())

\method{lifecycles}{grouped_activitylog}(log, eventlog = deprecated())
}
\arguments{
\item{log}{\code{\link{log}}: Object of class \code{\link{log}} or derivatives (\code{\link{grouped_log}}, \code{\link{eventlog}},
\code{\link{activitylog}}, etc.).}

\item{eventlog}{\ifelse{html}{\href{https://lifecycle.r-lib.org/articles/stages.html#deprecated}{\figure{lifecycle-deprecated.svg}{options: alt='[Deprecated]'}}}{\strong{[Deprecated]}}; please use \code{log} instead.}
}
\description{
Returns a \code{\link[dplyr]{tibble}} containing a list of all life cycle types in the log,
with their absolute and relative frequency (# events).
}
\section{Methods (by class)}{
\itemize{
\item \code{lifecycles(eventlog)}: Generate lifecycle list for an \code{\link{eventlog}}.

\item \code{lifecycles(grouped_eventlog)}: Generate lifecycle list for a \code{\link{grouped_eventlog}}.

\item \code{lifecycles(activitylog)}: Generate lifecycle list for an \code{\link{activitylog}}.

\item \code{lifecycles(grouped_activitylog)}: Generate lifecycle list for an \code{\link{grouped_activitylog}}.

}}
\seealso{
\code{\link{lifecycle_id}}
}
