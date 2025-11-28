# Rename log

Rename log

## Usage

``` r
rename(.data, ...)

# S3 method for class 'log'
rename(.data, ...)

# S3 method for class 'grouped_log'
rename(.data, ...)
```

## Arguments

- .data:

  [`log`](https://bupaverse.github.io/bupaR/reference/log.md): Object of
  class
  [`eventlog`](https://bupaverse.github.io/bupaR/reference/eventlog.md)
  or
  [`activitylog`](https://bupaverse.github.io/bupaR/reference/activitylog.md).

- ...:

  Variables to rename. Use "new_name" = "old_name" to rename selected
  variables.

## Methods (by class)

- `rename(log)`: Rename log

- `rename(grouped_log)`: Rename grouped log
