# Set lifecycle id of log

Set lifecycle id of log

## Usage

``` r
set_lifecycle_id(log, lifecycle_id)

# Default S3 method
set_lifecycle_id(log, lifecycle_id)
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

- lifecycle_id:

  New lifecycle id. Can be multiple in case of activitylog

## Methods (by class)

- `set_lifecycle_id(default)`: Set lifecycle id

## See also

Other Classifiers:
[`activity_id()`](https://bupaverse.github.io/bupaR/reference/activity_id.md),
[`activity_instance_id()`](https://bupaverse.github.io/bupaR/reference/activity_instance_id.md),
[`case_id()`](https://bupaverse.github.io/bupaR/reference/case_id.md),
[`lifecycle_id()`](https://bupaverse.github.io/bupaR/reference/lifecycle_id.md),
[`resource_id()`](https://bupaverse.github.io/bupaR/reference/resource_id.md),
[`set_activity_id()`](https://bupaverse.github.io/bupaR/reference/set_activity_id.md),
[`set_activity_instance_id()`](https://bupaverse.github.io/bupaR/reference/set_activity_instance_id.md),
[`set_case_id()`](https://bupaverse.github.io/bupaR/reference/set_case_id.md),
[`set_resource_id()`](https://bupaverse.github.io/bupaR/reference/set_resource_id.md),
[`set_timestamp()`](https://bupaverse.github.io/bupaR/reference/set_timestamp.md),
[`timestamp()`](https://bupaverse.github.io/bupaR/reference/timestamp.md),
[`timestamps()`](https://bupaverse.github.io/bupaR/reference/timestamps.md)
