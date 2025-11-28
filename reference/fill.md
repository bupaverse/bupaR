# Fill event log

Fill event log

## Usage

``` r
fill(data, ..., .direction = c("down", "up", "downup", "updown"))
```

## Arguments

- data:

  [`log`](https://bupaverse.github.io/bupaR/reference/log.md): Object of
  class
  [`eventlog`](https://bupaverse.github.io/bupaR/reference/eventlog.md)
  or
  [`activitylog`](https://bupaverse.github.io/bupaR/reference/activitylog.md).

- ...:

  Additional arguments passed to tidyr

- .direction:

  Direction in which to fill missing values. Currently either "down"
  (the default), "up", "downup" (i.e. first down and then up) or
  "updown" (first up and then down).
