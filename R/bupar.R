#' @title bupaR - Business Process Analysis in R
#'
#' @description Functionalities for process analysis in R. This packages implements an S3-class for event log objects,
#' and related handler functions. Imports related packages for subsetting event data, computation of descriptive statistics,
#' handling of Petri Net objects and visualization of process maps.
#'
# @docType package
#' @name bupaR
#'
## usethis namespace: start
#' @import dplyr
#' @import shiny
#' @import miniUI
#' @import eventdataR
#' @importFrom glue glue
#' @importFrom forcats fct_collapse fct_expand
#' @importFrom purrr map pmap
#' @importFrom tibble as_tibble
#' @importFrom tidyr nest unnest unite
#' @importFrom stats median na.omit quantile sd
#' @importFrom utils head setTxtProgressBar txtProgressBar data
#' @importFrom lifecycle deprecated
#' @importFrom magrittr %>%
#' @importFrom data.table as.data.table data.table := .I .N .SD
#' @importFrom rlang .data arg_match caller_arg caller_env is_character
#' @importFrom cli cli_abort
#' @importFrom stringi stri_c
#' @importFrom ggplot2 waiver scale_fill_gradient2 scale_fill_gradient scale_color_manual scale_fill_manual scale_color_gradient scale_color_gradient2
## usethis namespace: end

globalVariables(c("."))
"_PACKAGE"
NULL
