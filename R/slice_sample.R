#' @title Sample function for logs
#' @name slice_sample
# @description Takes a sample of the specified \code{size} from the cases of \code{.data}, either with or without replacement.
#'
# @inheritParams dplyr::slice_sample
#'
#' @importFrom dplyr slice_sample
#' @export
dplyr::slice_sample

#' @describeIn slice_sample Sample \code{n} cases of a \code{\link{log}}.
#' @export
slice_sample.log <- function(.data, ..., n, prop, weight_by = NULL, replace = FALSE) {

  n_cases <- n_cases(.data)

  if(!replace && !missing(n) && n > n_cases) {
    stop(glue("Cannot take a sample ({n}) larger than the population ({n_cases}) when 'replace = FALSE'"))
  }

  case_ids <- .data %>%
    distinct(.data[[case_id(.)]]) %>%
    as.data.frame()

  sample <- dplyr::slice_sample(case_ids, ..., n = n, prop = prop, weight_by = weight_by, replace = replace) %>%
    pull(.data[[case_id(.data)]])

  .data %>%
    filter(.data[[case_id(.)]] %in% sample)

  # Doesn't work for log class
  #take_sample(log = .data, ..., n = n, prop = prop, weight_by = weight_by, replace = replace)
}

#' @describeIn slice_sample Sample \code{n} cases from a \code{\link{grouped_log}}.
#' @export
slice_sample.grouped_log <- function(.data, ..., n, prop, weight_by = NULL, replace = FALSE) {

  take_sample(log = .data, ..., n = n, prop = prop, weight_by = weight_by, replace = replace)

  #.data %>%
  #  apply_grouped_fun(fun = slice_sample.log, n = n, prop = prop, weight_by = weight_by, replace = replace, .keep_groups = TRUE, .returns_log = TRUE)
}

# Extract common function body. Doesn't work for log class
take_sample <- function(log, ..., n, prop, weight_by = NULL, replace = FALSE) {

  case_ids <- log %>%
    distinct(.data[[case_id(.)]])

  sample <- dplyr::slice_sample(case_ids, ..., n = n, prop = prop, weight_by = weight_by, replace = replace) %>%
    pull(.data[[case_id(log)]])

  log %>%
    filter(.data[[case_id(.)]] %in% sample)
}
