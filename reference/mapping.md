# Mapping

Prints the mapping of an event log object.

## Usage

``` r
mapping(log)

# S3 method for class 'eventlog'
mapping(log)

# S3 method for class 'activitylog'
mapping(log)
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

- `mapping(eventlog)`: Retrieve identifier mapping from eventlog

- `mapping(activitylog)`: Retrieve identifier mapping from activitylog
