# Summarize event log

Summarize event log

## Usage

``` r
summarise(.data, ..., .by = NULL, .groups = NULL)
```

## Arguments

- .data:

  [`log`](https://bupaverse.github.io/bupaR/reference/log.md): Object of
  class
  [`eventlog`](https://bupaverse.github.io/bupaR/reference/eventlog.md)
  or
  [`activitylog`](https://bupaverse.github.io/bupaR/reference/activitylog.md)

- ...:

  Name-value pairs of summary functions

- .by:

  **\[experimental\]**

  \<[`tidy-select`](https://dplyr.tidyverse.org/reference/dplyr_tidy_select.html)\>
  Optionally, a selection of columns to group by for just this
  operation, functioning as an alternative to
  [`group_by()`](https://dplyr.tidyverse.org/reference/group_by.html).
  For details and examples, see
  [?dplyr_by](https://dplyr.tidyverse.org/reference/dplyr_by.html).

- .groups:

  **\[experimental\]** Grouping structure of the result.

  - "drop_last": dropping the last level of grouping. This was the only
    supported option before version 1.0.0.

  - "drop": All levels of grouping are dropped.

  - "keep": Same grouping structure as `.data`.

  - "rowwise": Each row is its own group.

  When `.groups` is not specified, it is chosen based on the number of
  rows of the results:

  - If all the results have 1 row, you get "drop_last".

  - If the number of rows varies, you get "keep" (note that returning a
    variable number of rows was deprecated in favor of
    [`reframe()`](https://dplyr.tidyverse.org/reference/reframe.html),
    which also unconditionally drops all levels of grouping).

  In addition, a message informs you of that choice, unless the result
  is ungrouped, the option "dplyr.summarise.inform" is set to `FALSE`,
  or when `summarise()` is called from a function in a package.

## Value

The summarize function returns a tibble, no event log. All groups will
be removed.
