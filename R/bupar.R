#' @title bupaR - Business Process Analysis in R
#' @docType package
#' @name bupaR
#' @description Functionalities for process analysis in R. This packages implements an S3-class for event log objects, and related handler functions. Imports related packages for subsetting event data, computation of descriptive statistics, handling of Petri Net objects and visualization of process maps.
#'
## usethis namespace: start
#' @importFrom magrittr %>%
#' @importFrom data.table as.data.table
#' @importFrom data.table data.table
#' @importFrom data.table :=
#' @import dplyr
#' @import shiny
#' @import miniUI
#' @import eventdataR
#' @importFrom tidyr unite
#' @importFrom glue glue
#' @importFrom forcats fct_collapse
#' @importFrom purrr map
#' @importFrom purrr pmap
#' @importFrom tibble as_tibble
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
## usethis namespace: end
globalVariables(c("."))
"_PACKAGE"

