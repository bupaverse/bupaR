# n_traces

Returns the number of traces in an event log

## Usage

``` r
n_traces(log)

# S3 method for class 'log'
n_traces(log)

# S3 method for class 'grouped_log'
n_traces(log)
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

## Methods (by class)

- `n_traces(log)`: Count number of traces for eventlog

- `n_traces(grouped_log)`: Count number of traces for grouped eventlog

## See also

Other Counters:
[`n_activities()`](https://bupaverse.github.io/bupaR/reference/n_activities.md),
[`n_activity_instances()`](https://bupaverse.github.io/bupaR/reference/n_activity_instances.md),
[`n_cases()`](https://bupaverse.github.io/bupaR/reference/n_cases.md),
[`n_events()`](https://bupaverse.github.io/bupaR/reference/n_events.md),
[`n_resources()`](https://bupaverse.github.io/bupaR/reference/n_resources.md)
