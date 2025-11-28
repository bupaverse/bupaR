# Timestamp classifiers

Get the timestamps classifier of an object of class `activitylog`

## Usage

``` r
timestamps(x)

# S3 method for class 'eventlog'
timestamps(x)

# S3 method for class 'eventlog_mapping'
timestamps(x)

# S3 method for class 'activitylog'
timestamps(x)

# S3 method for class 'activitylog_mapping'
timestamps(x)
```

## Arguments

- x:

  Object of class
  [`activitylog`](https://bupaverse.github.io/bupaR/reference/activitylog.md),
  or
  [`mapping`](https://bupaverse.github.io/bupaR/reference/mapping.md).

## Methods (by class)

- `timestamps(eventlog)`: Retrieve timestamp identifier from eventlog

- `timestamps(eventlog_mapping)`: Retrieve timestamp identifier from
  eventlog mapping

- `timestamps(activitylog)`: Retrieve timestamp identifier from
  activitylog

- `timestamps(activitylog_mapping)`: Retrieve timestamp identifier from
  activitylog mapping

## See also

[`activitylog`](https://bupaverse.github.io/bupaR/reference/activitylog.md),
[`mapping`](https://bupaverse.github.io/bupaR/reference/mapping.md)

Other Classifiers:
[`activity_id()`](https://bupaverse.github.io/bupaR/reference/activity_id.md),
[`activity_instance_id()`](https://bupaverse.github.io/bupaR/reference/activity_instance_id.md),
[`case_id()`](https://bupaverse.github.io/bupaR/reference/case_id.md),
[`lifecycle_id()`](https://bupaverse.github.io/bupaR/reference/lifecycle_id.md),
[`resource_id()`](https://bupaverse.github.io/bupaR/reference/resource_id.md),
[`set_activity_id()`](https://bupaverse.github.io/bupaR/reference/set_activity_id.md),
[`set_activity_instance_id()`](https://bupaverse.github.io/bupaR/reference/set_activity_instance_id.md),
[`set_case_id()`](https://bupaverse.github.io/bupaR/reference/set_case_id.md),
[`set_lifecycle_id()`](https://bupaverse.github.io/bupaR/reference/set_lifecycle_id.md),
[`set_resource_id()`](https://bupaverse.github.io/bupaR/reference/set_resource_id.md),
[`set_timestamp()`](https://bupaverse.github.io/bupaR/reference/set_timestamp.md),
[`timestamp()`](https://bupaverse.github.io/bupaR/reference/timestamp.md)
