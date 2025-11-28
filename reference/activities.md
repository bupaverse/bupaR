# Activities

Returns a `tibble` containing a list of all activity types in the event
log, with their absolute and relative frequency

## Usage

``` r
activities(log, ...)

# S3 method for class 'activitylog'
activities(log, ...)

# S3 method for class 'grouped_log'
activities(log, ...)
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

  Unused.

## Methods (by class)

- `activities(activitylog)`: Compute activity frequencies

- `activities(grouped_log)`: Compute activity frequencies

## See also

[`activity_id`](https://bupaverse.github.io/bupaR/reference/activity_id.md),[`activity_instance_id`](https://bupaverse.github.io/bupaR/reference/activity_instance_id.md),
[`eventlog`](https://bupaverse.github.io/bupaR/reference/eventlog.md)
