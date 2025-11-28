# Resource classifier

Get the resource classifier of an object of class `eventlog`.

## Usage

``` r
resource_id(x)

# S3 method for class 'eventlog'
resource_id(x)

# S3 method for class 'eventlog_mapping'
resource_id(x)

# S3 method for class 'activitylog'
resource_id(x)

# S3 method for class 'activitylog_mapping'
resource_id(x)
```

## Arguments

- x:

  [`log`](https://bupaverse.github.io/bupaR/reference/log.md): Object of
  class
  [`eventlog`](https://bupaverse.github.io/bupaR/reference/eventlog.md)
  or
  [`activitylog`](https://bupaverse.github.io/bupaR/reference/activitylog.md),
  or
  [`mapping`](https://bupaverse.github.io/bupaR/reference/mapping.md).

## Methods (by class)

- `resource_id(eventlog)`: Retrieve resource identifier from eventlog

- `resource_id(eventlog_mapping)`: Retrieve resource identifier from
  eventlog mapping

- `resource_id(activitylog)`: Retrieve resource identifier from
  activitylog

- `resource_id(activitylog_mapping)`: Retrieve resource identifier from
  activitylog mapping

## See also

[`eventlog`](https://bupaverse.github.io/bupaR/reference/eventlog.md),
[`mapping`](https://bupaverse.github.io/bupaR/reference/mapping.md)

Other Classifiers:
[`activity_id()`](https://bupaverse.github.io/bupaR/reference/activity_id.md),
[`activity_instance_id()`](https://bupaverse.github.io/bupaR/reference/activity_instance_id.md),
[`case_id()`](https://bupaverse.github.io/bupaR/reference/case_id.md),
[`lifecycle_id()`](https://bupaverse.github.io/bupaR/reference/lifecycle_id.md),
[`set_activity_id()`](https://bupaverse.github.io/bupaR/reference/set_activity_id.md),
[`set_activity_instance_id()`](https://bupaverse.github.io/bupaR/reference/set_activity_instance_id.md),
[`set_case_id()`](https://bupaverse.github.io/bupaR/reference/set_case_id.md),
[`set_lifecycle_id()`](https://bupaverse.github.io/bupaR/reference/set_lifecycle_id.md),
[`set_resource_id()`](https://bupaverse.github.io/bupaR/reference/set_resource_id.md),
[`set_timestamp()`](https://bupaverse.github.io/bupaR/reference/set_timestamp.md),
[`timestamp()`](https://bupaverse.github.io/bupaR/reference/timestamp.md),
[`timestamps()`](https://bupaverse.github.io/bupaR/reference/timestamps.md)
