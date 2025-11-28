# n_resources

Returns the number of resources in an event log

## Usage

``` r
n_resources(log)

# S3 method for class 'log'
n_resources(log)

# S3 method for class 'grouped_log'
n_resources(log)
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

- `n_resources(log)`: Count number of resources in log

- `n_resources(grouped_log)`: Count number of resources in grouped log

## See also

Other Counters:
[`n_activities()`](https://bupaverse.github.io/bupaR/reference/n_activities.md),
[`n_activity_instances()`](https://bupaverse.github.io/bupaR/reference/n_activity_instances.md),
[`n_cases()`](https://bupaverse.github.io/bupaR/reference/n_cases.md),
[`n_events()`](https://bupaverse.github.io/bupaR/reference/n_events.md),
[`n_traces()`](https://bupaverse.github.io/bupaR/reference/n_traces.md)
