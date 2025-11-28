# last_n

Select last n activity instances

## Usage

``` r
last_n(log, n)

# S3 method for class 'eventlog'
last_n(log, n)

# S3 method for class 'activitylog'
last_n(log, n)

# S3 method for class 'grouped_log'
last_n(log, n)
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

- `last_n(eventlog)`: Select last n activity instances of an
  [`eventlog`](https://bupaverse.github.io/bupaR/reference/eventlog.md).

- `last_n(activitylog)`: Select last n activity instances of an
  [`activitylog`](https://bupaverse.github.io/bupaR/reference/activitylog.md).

- `last_n(grouped_log)`: Select last n activity instances of a
  [`grouped_log`](https://bupaverse.github.io/bupaR/reference/grouped_log.md).
