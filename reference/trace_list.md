# Trace list

Construct trace list

## Usage

``` r
trace_list(log, ...)

# S3 method for class 'eventlog'
trace_list(log, ...)

# S3 method for class 'activitylog'
trace_list(log, ...)

# S3 method for class 'grouped_log'
trace_list(log, ...)
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

- ...:

  Other arguments. Currently not used.

## Methods (by class)

- `trace_list(eventlog)`: Construct trace list for event log

- `trace_list(activitylog)`: Construct trace list for activity log

- `trace_list(grouped_log)`: Construct list of traces for grouped log
