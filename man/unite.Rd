% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/unite.eventlog.R
\name{unite}
\alias{unite}
\alias{unite.eventlog}
\alias{unite.activtylog}
\alias{unite.grouped_eventlog}
\title{Unite multiple columns into one.}
\usage{
unite(data, col, ..., sep = "_", remove = TRUE, na.rm = FALSE)

\method{unite}{eventlog}(data, col, ..., sep = "_", remove = T)

\method{unite}{activtylog}(data, col, ..., sep = "_", remove = T)

\method{unite}{grouped_eventlog}(data, col, ..., sep = "_", remove = T)
}
\arguments{
\item{data}{Eventlog}

\item{col}{The name of the new column, as a string or symbol.

This argument is passed by expression and supports
\link[rlang:topic-inject]{quasiquotation} (you can unquote strings
and symbols). The name is captured from the expression with
\code{\link[rlang:defusing-advanced]{rlang::ensym()}} (note that this kind of interface where
symbols do not represent actual objects is now discouraged in the
tidyverse; we support it here for backward compatibility).}

\item{...}{Additional arguments passed to \link[=unite]{tidyr}}

\item{sep}{Separator to use between values.}

\item{remove}{If \code{TRUE}, remove input columns from output data frame.}

\item{na.rm}{If \code{TRUE}, missing values will be removed prior to uniting
each value.}
}
\description{
Unite multiple columns into one.
}
\section{Methods (by class)}{
\itemize{
\item \code{unite(eventlog)}: Unite columns in eventlog

\item \code{unite(activtylog)}: Unite columns in activitylog

\item \code{unite(grouped_eventlog)}: Unite columns in grouped eventlog

}}
