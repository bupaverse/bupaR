% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/set_lifecycle_id.R
\name{set_lifecycle_id}
\alias{set_lifecycle_id}
\alias{set_lifecycle_id.default}
\title{Set lifecycle id of log}
\usage{
set_lifecycle_id(log, lifecycle_id, eventlog = deprecated())

\method{set_lifecycle_id}{default}(log, lifecycle_id, eventlog = deprecated())
}
\arguments{
\item{log}{\code{\link{log}}: Object of class \code{\link{log}}, \code{\link{eventlog}}, or \code{\link{activitylog}}.}

\item{lifecycle_id}{New lifecycle id. Can be multiple in case of activitylog}

\item{eventlog}{Deprecated; please use \code{log} instead.}
}
\description{
Set lifecycle id of log
}
\section{Methods (by class)}{
\itemize{
\item \code{default}: Set lifecycle id
}}
