# Cases

Provides a fine-grained summary of an event log with characteristics for
each case: the number of events, the number of activity types, the
timespan, the trace, the duration, and the first and last event type.

## Usage

``` r
cases(log, ...)

# S3 method for class 'log'
cases(log, ...)

# S3 method for class 'eventlog'
cases(log, ...)

# S3 method for class 'activitylog'
cases(log, ...)
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

  Other (optional) arguments passed on to methods. See
  [`durations`](https://bupaverse.github.io/bupaR/reference/durations.md)
  for more options.

## Methods (by class)

- `cases(log)`: Construct list of cases in a
  [`log`](https://bupaverse.github.io/bupaR/reference/log.md).

- `cases(eventlog)`: Construct list of cases in an
  [`eventlog`](https://bupaverse.github.io/bupaR/reference/eventlog.md).

- `cases(activitylog)`: Construct list of cases in a
  [`activitylog`](https://bupaverse.github.io/bupaR/reference/activitylog.md).

## See also

[`case_list`](https://bupaverse.github.io/bupaR/reference/case_list.md),[`durations`](https://bupaverse.github.io/bupaR/reference/durations.md)
