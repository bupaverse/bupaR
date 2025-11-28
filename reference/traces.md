# Traces

`traces` computes the different activity sequences of an event log
together with their absolute and relative frequencies. Activity
sequences are based on the start timestamp of activities.

## Usage

``` r
traces(log, ...)

# S3 method for class 'log'
traces(log, ...)

# S3 method for class 'grouped_log'
traces(log, ...)
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

  Deprecated arguments

## Methods (by class)

- `traces(log)`: Construct traces list for eventlog

- `traces(grouped_log)`: Construct list of traces for grouped log

## See also

[`cases`](https://bupaverse.github.io/bupaR/reference/cases.md),
[`eventlog`](https://bupaverse.github.io/bupaR/reference/eventlog.md)
