# Life cycles

Returns a [`tibble`](https://tibble.tidyverse.org/reference/tibble.html)
containing a list of all life cycle types in the log, with their
absolute and relative frequency (# events).

## Usage

``` r
lifecycles(log)

# S3 method for class 'eventlog'
lifecycles(log)

# S3 method for class 'grouped_eventlog'
lifecycles(log)

# S3 method for class 'activitylog'
lifecycles(log)

# S3 method for class 'grouped_activitylog'
lifecycles(log)
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

- `lifecycles(eventlog)`: Generate lifecycle list for an
  [`eventlog`](https://bupaverse.github.io/bupaR/reference/eventlog.md).

- `lifecycles(grouped_eventlog)`: Generate lifecycle list for a
  [`grouped_eventlog`](https://bupaverse.github.io/bupaR/reference/grouped_eventlog.md).

- `lifecycles(activitylog)`: Generate lifecycle list for an
  [`activitylog`](https://bupaverse.github.io/bupaR/reference/activitylog.md).

- `lifecycles(grouped_activitylog)`: Generate lifecycle list for an
  [`grouped_activitylog`](https://bupaverse.github.io/bupaR/reference/grouped_activitylog.md).

## See also

[`lifecycle_id`](https://bupaverse.github.io/bupaR/reference/lifecycle_id.md)
