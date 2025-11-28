# n_events

Returns the number of events in an event log.

## Usage

``` r
n_events(log)

# S3 method for class 'eventlog'
n_events(log)

# S3 method for class 'grouped_eventlog'
n_events(log)

# S3 method for class 'activitylog'
n_events(log)

# S3 method for class 'grouped_activitylog'
n_events(log)
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

- `n_events(eventlog)`: Count number of events in an
  [`eventlog`](https://bupaverse.github.io/bupaR/reference/eventlog.md).

- `n_events(grouped_eventlog)`: Count number of events in a
  [`grouped_eventlog`](https://bupaverse.github.io/bupaR/reference/grouped_eventlog.md).

- `n_events(activitylog)`: Count number of events in an
  [`activitylog`](https://bupaverse.github.io/bupaR/reference/activitylog.md).

- `n_events(grouped_activitylog)`: Count number of events in an
  [`grouped_activitylog`](https://bupaverse.github.io/bupaR/reference/grouped_activitylog.md).

## See also

Other Counters:
[`n_activities()`](https://bupaverse.github.io/bupaR/reference/n_activities.md),
[`n_activity_instances()`](https://bupaverse.github.io/bupaR/reference/n_activity_instances.md),
[`n_cases()`](https://bupaverse.github.io/bupaR/reference/n_cases.md),
[`n_resources()`](https://bupaverse.github.io/bupaR/reference/n_resources.md),
[`n_traces()`](https://bupaverse.github.io/bupaR/reference/n_traces.md)
