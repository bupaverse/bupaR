# Test if the Object is a Log

This function returns `TRUE` if `x` inherits from the specified class,
and `FALSE` for all other objects.

## Usage

``` r
is.log(x)

is.eventlog(x)

is.activitylog(x)

is.grouped_log(x)

is.grouped_eventlog(x)

is.grouped_activitylog(x)
```

## Arguments

- x:

  Any `R` object.

## Value

`is.log` returns `TRUE` if the object inherits from the
[`log`](https://bupaverse.github.io/bupaR/reference/log.md) class,
otherwise `FALSE`.

`is.eventlog` returns `TRUE` if the object inherits from the
[`eventlog`](https://bupaverse.github.io/bupaR/reference/eventlog.md)
class, otherwise `FALSE`.

`is.actvitylog` returns `TRUE` if the object inherits from the
[`activitylog`](https://bupaverse.github.io/bupaR/reference/activitylog.md)
class, otherwise `FALSE`.

`is.grouped_log` returns `TRUE` if the object inherits from the
[`grouped_log`](https://bupaverse.github.io/bupaR/reference/grouped_log.md)
class, otherwise `FALSE`.

`is.grouped_eventlog` returns `TRUE` if the object inherits from the
[`grouped_eventlog`](https://bupaverse.github.io/bupaR/reference/grouped_eventlog.md)
class, otherwise `FALSE`.

`is.grouped_activitylog` returns `TRUE` if the object inherits from the
[`grouped_activitylog`](https://bupaverse.github.io/bupaR/reference/grouped_activitylog.md)
class, otherwise `FALSE`.

## See also

[`log`](https://bupaverse.github.io/bupaR/reference/log.md),[`eventlog`](https://bupaverse.github.io/bupaR/reference/eventlog.md),[`activitylog`](https://bupaverse.github.io/bupaR/reference/activitylog.md),[`grouped_log`](https://bupaverse.github.io/bupaR/reference/grouped_log.md),[`grouped_eventlog`](https://bupaverse.github.io/bupaR/reference/grouped_eventlog.md),[`grouped_activitylog`](https://bupaverse.github.io/bupaR/reference/grouped_activitylog.md)
