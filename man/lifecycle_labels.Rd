% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/lifecycle_labels.R
\name{lifecycle_labels}
\alias{lifecycle_labels}
\alias{lifecycle_labels.eventlog}
\alias{lifecycle_labels.activitylog}
\title{Get vector of lifecycle labels.}
\usage{
lifecycle_labels(log, eventlog = deprecated())

\method{lifecycle_labels}{eventlog}(log, eventlog = deprecated())

\method{lifecycle_labels}{activitylog}(log, eventlog = deprecated())
}
\arguments{
\item{log}{\code{\link{log}}: Object of class \code{\link{log}} or derivatives (\code{\link{grouped_log}}, \code{\link{eventlog}},
\code{\link{activitylog}}, etc.).}

\item{eventlog}{\ifelse{html}{\href{https://lifecycle.r-lib.org/articles/stages.html#deprecated}{\figure{lifecycle-deprecated.svg}{options: alt='[Deprecated]'}}}{\strong{[Deprecated]}}; please use \code{log} instead.}
}
\description{
Retrieve a vector containing all unique lifecycle labels.
}
\section{Methods (by class)}{
\itemize{
\item \code{lifecycle_labels(eventlog)}: Retrieve lifecycle labels from an \code{\link{eventlog}}.

\item \code{lifecycle_labels(activitylog)}: Retrieve lifecycle labels from an \code{\link{activitylog}}.

}}
\seealso{
\code{\link{lifecycle_id}}
}
