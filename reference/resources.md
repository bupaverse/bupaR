# Resources

Returns a `tibble` containing a list of all resources in the event log,
with their absolute and relative frequency

## Usage

``` r
resources(log)

# S3 method for class 'eventlog'
resources(log)

# S3 method for class 'activitylog'
resources(log)

# S3 method for class 'grouped_log'
resources(log)
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

- `resources(eventlog)`: Generate resource list for eventlog

- `resources(activitylog)`: Generate resource list for activitylog

- `resources(grouped_log)`: Compute activity frequencies

## See also

[`resource_id`](https://bupaverse.github.io/bupaR/reference/resource_id.md),
[`eventlog`](https://bupaverse.github.io/bupaR/reference/eventlog.md)
