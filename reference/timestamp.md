# Timestamp classifier

Get the timestamp classifier of an object of class `eventlog`

## Usage

``` r
timestamp(x)

# S3 method for class 'eventlog'
timestamp(x)

# S3 method for class 'eventlog_mapping'
timestamp(x)

# S3 method for class 'activitylog'
timestamp(x)

# S3 method for class 'activitylog_mapping'
timestamp(x)
```

## Arguments

- x:

  Object of class
  [`eventlog`](https://bupaverse.github.io/bupaR/reference/eventlog.md),
  or
  [`mapping`](https://bupaverse.github.io/bupaR/reference/mapping.md).

## Methods (by class)

- `timestamp(eventlog)`: Retrieve timestamp identifier from eventlog

- `timestamp(eventlog_mapping)`: Retrieve timestamp identifier from
  eventlog mapping

- `timestamp(activitylog)`: Retrieve timestamp identifier from
  activitylog

- `timestamp(activitylog_mapping)`: Retrieve timestamp identifier from
  activitylog mapping

## See also

[`eventlog`](https://bupaverse.github.io/bupaR/reference/eventlog.md),
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
[`timestamps()`](https://bupaverse.github.io/bupaR/reference/timestamps.md)
