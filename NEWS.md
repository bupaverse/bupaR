# bupaR 0.5.1 (dev)

## Features

* Added new functions to check if an object `x` inherits from a particular event data
class (`is.log(x)`,`is.eventlog(x)`,`is.activitylog(x)`,`is.grouped_log(x)`,
`is.grouped_eventlog(x)`,`is.grouped_actiivtylog(x)`).

## Bug Fixes

* `group_by(.data, ..., .add = F)` now works correctly on `grouped_eventlog`.
Previously, applying `group_by()` to a `grouped_eventlog` reverted it to a `data.frame`,
which prevented the application of further **bupaR** functions on the returned value. 
* The `"raw"` attribute of metrics in **edeaR** (e.g. `throughput_time`) containing
the original data is now kept after applying `group_by()`. This can be useful for
further analyses on the output of metrics and can be accessed using `attr(log, "raw")`.

## Other

* Added a `NEWS.md` file to track changes to the package.
* Added GitHub Action (`pkgdown`).
* Updated `README.md`.