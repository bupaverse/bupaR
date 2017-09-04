#' @title bupaR - Business Process Analysis in R
#' @docType package
#' @name bupaR
#' @description Functionalities for process analysis in R. This packages implements an S3-class for event log objects, and related handler functions. Imports related packages for subsetting event data, computation of descriptive statistics, handling of Petri Net objects and visualization of process maps.
#'
#' @importFrom magrittr %>%
#' @importFrom data.table data.table
#' @importFrom data.table :=
#' @import dplyr
#' @import shiny
#' @import miniUI
#' @importFrom purrr map
#' @importFrom stats median
#' @importFrom stats na.omit
#' @importFrom stats quantile
#' @importFrom stats sd
#' @importFrom utils head
#' @importFrom utils setTxtProgressBar
#' @importFrom utils txtProgressBar
#' @importFrom utils data

globalVariables(c(".",".N","absolute_frequency", "activity_instance_classifier","case_classifier", "duration",
				  "event_classifier",
				  "relative_frequency","timestamp_classifier","trace_id", "filter_case", "install.packages"))

NULL

