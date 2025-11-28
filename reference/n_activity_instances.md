# n_activity_instances

Returns the number of activity instances in an event log

## Usage

``` r
n_activity_instances(log)

# S3 method for class 'eventlog'
n_activity_instances(log)

# S3 method for class 'grouped_eventlog'
n_activity_instances(log)

# S3 method for class 'activitylog'
n_activity_instances(log)

# S3 method for class 'grouped_activitylog'
n_activity_instances(log)
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

- `n_activity_instances(eventlog)`: eventlog

- `n_activity_instances(grouped_eventlog)`: grouped_eventlog

- `n_activity_instances(activitylog)`: activitylog

- `n_activity_instances(grouped_activitylog)`: grouped_activitylog

## See also

Other Counters:
[`n_activities()`](https://bupaverse.github.io/bupaR/reference/n_activities.md),
[`n_cases()`](https://bupaverse.github.io/bupaR/reference/n_cases.md),
[`n_events()`](https://bupaverse.github.io/bupaR/reference/n_events.md),
[`n_resources()`](https://bupaverse.github.io/bupaR/reference/n_resources.md),
[`n_traces()`](https://bupaverse.github.io/bupaR/reference/n_traces.md)
