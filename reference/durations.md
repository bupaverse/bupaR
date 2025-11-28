# Durations

Computes the throughput times of each case. Throughput time is defined
as the interval between the start of the first event and the completion
of the last event.

## Usage

``` r
durations(log, units = c("auto", "secs", "mins", "hours", "days", "weeks"))
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

- units:

  [`character`](https://rdrr.io/r/base/character.html) (default "auto"):
  The time unit in which the throughput times should be reported. Should
  be one of the following values: "auto" (default), "secs", "mins",
  "hours", "days", "weeks". See also the `units` argument of
  [`difftime`](https://rdrr.io/r/base/difftime.html).
