# Sample function for logs

Sample function for logs

## Usage

``` r
slice_sample(.data, ..., n, prop, by = NULL, weight_by = NULL, replace = FALSE)

# S3 method for class 'log'
slice_sample(.data, ..., n, prop, weight_by = NULL, replace = FALSE)

# S3 method for class 'grouped_log'
slice_sample(.data, ..., n, prop, weight_by = NULL, replace = FALSE)
```

## Arguments

- .data:

  A data frame, data frame extension (e.g. a tibble), or a lazy data
  frame (e.g. from dbplyr or dtplyr). See *Methods*, below, for more
  details.

- ...:

  Arguments passed on to
  [`dplyr::slice_sample`](https://dplyr.tidyverse.org/reference/slice.html)

  `n,prop`

  :   Provide either `n`, the number of rows, or `prop`, the proportion
      of rows to select. If neither are supplied, `n = 1` will be used.
      If `n` is greater than the number of rows in the group (or
      `prop > 1`), the result will be silently truncated to the group
      size. `prop` will be rounded towards zero to generate an integer
      number of rows.

      A negative value of `n` or `prop` will be subtracted from the
      group size. For example, `n = -2` with a group of 5 rows will
      select 5 - 2 = 3 rows; `prop = -0.25` with 8 rows will select 8 \*
      (1 - 0.25) = 6 rows.

- n, prop:

  Provide either `n`, the number of rows, or `prop`, the proportion of
  rows to select. If neither are supplied, `n = 1` will be used. If `n`
  is greater than the number of rows in the group (or `prop > 1`), the
  result will be silently truncated to the group size. `prop` will be
  rounded towards zero to generate an integer number of rows.

  A negative value of `n` or `prop` will be subtracted from the group
  size. For example, `n = -2` with a group of 5 rows will select 5 - 2 =
  3 rows; `prop = -0.25` with 8 rows will select 8 \* (1 - 0.25) = 6
  rows.

- by:

  **\[experimental\]**

  \<[`tidy-select`](https://dplyr.tidyverse.org/reference/dplyr_tidy_select.html)\>
  Optionally, a selection of columns to group by for just this
  operation, functioning as an alternative to
  [`group_by()`](https://dplyr.tidyverse.org/reference/group_by.html).
  For details and examples, see
  [?dplyr_by](https://dplyr.tidyverse.org/reference/dplyr_by.html).

- weight_by:

  \<[`data-masking`](https://rlang.r-lib.org/reference/args_data_masking.html)\>
  Sampling weights. This must evaluate to a vector of non-negative
  numbers the same length as the input. Weights are automatically
  standardised to sum to 1.

- replace:

  Should sampling be performed with (`TRUE`) or without (`FALSE`, the
  default) replacement.

## Methods (by class)

- `slice_sample(log)`: Sample `n` cases of a
  [`log`](https://bupaverse.github.io/bupaR/reference/log.md).

- `slice_sample(grouped_log)`: Sample `n` cases from a
  [`grouped_log`](https://bupaverse.github.io/bupaR/reference/grouped_log.md).
