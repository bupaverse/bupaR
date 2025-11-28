# Group log on identifiers

Group log on identifiers

## Usage

``` r
group_by_ids(log, ...)

# S3 method for class 'log'
group_by_ids(log, ...)
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

  One or more of the following: activity_id, case_id,
  activity_instance_id, resource_id, lifecycle_id

## Value

Grouped log

## Methods (by class)

- `group_by_ids(log)`: Group log on identifiers
