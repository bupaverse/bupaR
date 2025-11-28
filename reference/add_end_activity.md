# Add Artificial Start/End Activities

Adds an artificial start or end activity to each case with the specified
`label`.

## Usage

``` r
add_end_activity(log, label = "End")

add_start_activity(log, label = "Start")

# S3 method for class 'eventlog'
add_end_activity(log, label = "End")

# S3 method for class 'activitylog'
add_end_activity(log, label = "End")

# S3 method for class 'grouped_log'
add_end_activity(log, label = "End")

# S3 method for class 'eventlog'
add_start_activity(log, label = "Start")

# S3 method for class 'activitylog'
add_start_activity(log, label = "Start")

# S3 method for class 'grouped_log'
add_start_activity(log, label = "Start")
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

- label:

  [`character`](https://rdrr.io/r/base/character.html): Start (default
  `"Start"`) or end (default `"End"`) activity label. This must be an
  activity label that is not already present in `log`.

## Methods (by class)

- `add_end_activity(eventlog)`: Adds end activity to an
  [`eventlog`](https://bupaverse.github.io/bupaR/reference/eventlog.md).

- `add_end_activity(activitylog)`: Adds end activity to an
  [`activitylog`](https://bupaverse.github.io/bupaR/reference/activitylog.md).

- `add_end_activity(grouped_log)`: Adds end activity to a
  [`grouped_log`](https://bupaverse.github.io/bupaR/reference/grouped_log.md).

## Functions

- `add_start_activity(eventlog)`: Adds start activity to an
  [`eventlog`](https://bupaverse.github.io/bupaR/reference/eventlog.md).

- `add_start_activity(activitylog)`: Adds start activity to an
  [`activitylog`](https://bupaverse.github.io/bupaR/reference/activitylog.md).

- `add_start_activity(grouped_log)`: Adds start activity to a
  [`grouped_log`](https://bupaverse.github.io/bupaR/reference/grouped_log.md).
