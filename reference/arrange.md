# Arrange log

Arrange log

## Usage

``` r
arrange(.data, ..., .by_group = FALSE)

# S3 method for class 'grouped_eventlog'
arrange(.data, ...)

# S3 method for class 'activitylog'
arrange(.data, ...)
```

## Arguments

- .data:

  [`log`](https://bupaverse.github.io/bupaR/reference/log.md): Object of
  class
  [`eventlog`](https://bupaverse.github.io/bupaR/reference/eventlog.md)
  or
  [`activitylog`](https://bupaverse.github.io/bupaR/reference/activitylog.md).

- ...:

  Additional arguments passed to dplyr

- .by_group:

  If `TRUE`, will sort first by grouping variable. Applies to grouped
  data frames only.

## Methods (by class)

- `arrange(grouped_eventlog)`: Arrange an eventlog by group, maintaining
  all groups

- `arrange(activitylog)`: Arrange an activitylog
