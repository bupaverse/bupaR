# first_n

Select first n activity instances.

## Usage

``` r
first_n(log, n)

# S3 method for class 'eventlog'
first_n(log, n)

# S3 method for class 'activitylog'
first_n(log, n)

# S3 method for class 'grouped_log'
first_n(log, n)
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

- n:

  [`integer`](https://rdrr.io/r/base/integer.html): The number of
  activity instances to select.

## Methods (by class)

- `first_n(eventlog)`: Select first n activity instances of an
  [`eventlog`](https://bupaverse.github.io/bupaR/reference/eventlog.md).

- `first_n(activitylog)`: Select first n activity instances of an
  [`activitylog`](https://bupaverse.github.io/bupaR/reference/activitylog.md).

- `first_n(grouped_log)`: Select first n activity instances of a
  [`grouped_log`](https://bupaverse.github.io/bupaR/reference/grouped_log.md).
