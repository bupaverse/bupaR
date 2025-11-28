# n_activities

Returns the number of activities in an event log

## Usage

``` r
n_activities(log)

# S3 method for class 'log'
n_activities(log)

# S3 method for class 'grouped_log'
n_activities(log)
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

- `n_activities(log)`: Count the number of activities in a log

- `n_activities(grouped_log)`: Count the number of activities for a
  grouped log

## See also

Other Counters:
[`n_activity_instances()`](https://bupaverse.github.io/bupaR/reference/n_activity_instances.md),
[`n_cases()`](https://bupaverse.github.io/bupaR/reference/n_cases.md),
[`n_events()`](https://bupaverse.github.io/bupaR/reference/n_events.md),
[`n_resources()`](https://bupaverse.github.io/bupaR/reference/n_resources.md),
[`n_traces()`](https://bupaverse.github.io/bupaR/reference/n_traces.md)
