# Case list

Construct list of cases

## Usage

``` r
case_list(log, .keep_trace_list)

# S3 method for class 'eventlog'
case_list(log, .keep_trace_list = FALSE)

# S3 method for class 'activitylog'
case_list(log, .keep_trace_list = FALSE)
```

## Arguments

- log:

  [`log`](https://bupaverse.github.io/bupaR/reference/log.md): Object of
  class [`log`](https://bupaverse.github.io/bupaR/reference/log.md) or
  derivatives
  ([`grouped_log`](https://bupaverse.github.io/bupaR/reference/grouped_log.md),
  [`eventlog`](https://bupaverse.github.io/bupaR/reference/eventlog.md),
  [`activitylog`](https://bupaverse.github.io/bupaR/reference/activitylog.md),
  etc.).

- .keep_trace_list:

  Logical (default is `FALSE`): If `TRUE`, keeps the trace as a `list`.
  If `FALSE`, only the concatenated string representation of the trace
  is kept.

## Methods (by class)

- `case_list(eventlog)`: Return case list

- `case_list(activitylog)`: Return case list
