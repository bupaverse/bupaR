# Count log

Count log

## Usage

``` r
count(x, ..., wt = NULL, sort = FALSE, name = NULL)

# S3 method for class 'log'
count(x, ...)

# S3 method for class 'grouped_log'
count(x, ...)
```

## Arguments

- x:

  [`log`](https://bupaverse.github.io/bupaR/reference/log.md): Object of
  class
  [`eventlog`](https://bupaverse.github.io/bupaR/reference/eventlog.md)
  or
  [`activitylog`](https://bupaverse.github.io/bupaR/reference/activitylog.md).

- ...:

  Additional arguments passed to dplyr

- wt:

  \<[`data-masking`](https://rlang.r-lib.org/reference/args_data_masking.html)\>
  Frequency weights. Can be `NULL` or a variable:

  - If `NULL` (the default), counts the number of rows in each group.

  - If a variable, computes `sum(wt)` for each group.

- sort:

  If `TRUE`, will show the largest groups at the top.

- name:

  The name of the new column in the output.

  If omitted, it will default to `n`. If there's already a column called
  `n`, it will use `nn`. If there's a column called `n` and `nn`, it'll
  use `nnn`, and so on, adding `n`s until it gets a new name.

## Methods (by class)

- `count(log)`: Count log

- `count(grouped_log)`: Count grouped log
