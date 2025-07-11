% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/fill.R
\name{fill}
\alias{fill}
\title{Fill event log}
\usage{
fill(data, ..., .direction = c("down", "up", "downup", "updown"))
}
\arguments{
\item{data}{\code{\link{log}}: Object of class \code{\link{eventlog}} or \code{\link{activitylog}}.}

\item{...}{Additional arguments passed to \link[=fill]{tidyr}}

\item{.direction}{Direction in which to fill missing values. Currently
either "down" (the default), "up", "downup" (i.e. first down and then up)
or "updown" (first up and then down).}
}
\description{
Fill event log
}
