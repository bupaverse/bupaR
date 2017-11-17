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
#' @importFrom tidyr unite
#' @importFrom glue glue
#' @importFrom forcats fct_collapse
#' @importFrom purrr map
#' @importFrom purrr pmap
#' @importFrom tidyr nest
#' @importFrom tidyr unnest
#' @importFrom stats median
#' @importFrom stats na.omit
#' @importFrom stats quantile
#' @importFrom stats sd
#' @importFrom utils head
#' @importFrom utils setTxtProgressBar
#' @importFrom utils txtProgressBar
#' @importFrom utils data
globalVariables(c("."))
"_PACKAGE"

