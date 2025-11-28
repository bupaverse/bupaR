# Get vector of lifecycle labels.

Retrieve a vector containing all unique lifecycle labels.

## Usage

``` r
lifecycle_labels(log)

# S3 method for class 'eventlog'
lifecycle_labels(log)

# S3 method for class 'activitylog'
lifecycle_labels(log)
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

- `lifecycle_labels(eventlog)`: Retrieve lifecycle labels from an
  [`eventlog`](https://bupaverse.github.io/bupaR/reference/eventlog.md).

- `lifecycle_labels(activitylog)`: Retrieve lifecycle labels from an
  [`activitylog`](https://bupaverse.github.io/bupaR/reference/activitylog.md).

## See also

[`lifecycle_id`](https://bupaverse.github.io/bupaR/reference/lifecycle_id.md)
