# bupaR 0.5.3

## Features

* Added new `rename` method, similar to dplyr's rename, that automatically changes the mapping of the log if the rename concerns any mapping variables. 
* Added new `count` method, to increase compatibility with dplyr. `count` will automatically convert the `log` object to a `tibble`. 

## Bug Fixes

* `group_by(.data, ..., .add = F)` now works correctly on `grouped_eventlog`. Previously, applying `group_by()` to a `grouped_eventlog`
reverted it to a `data.frame`, which prevented the application of further **bupaR** functions on the returned value. 
* The `"raw"` attribute of metrics in **edeaR** (e.g. `throughput_time`) containing the original data is now kept after
applying `group_by()`. This can be useful for further analyses on the output of metrics and can be accessed using `attr(log, "raw")`.
* Fixed bug in `add_start_activity()` and `add_end_activity()` which failed when applied to an `activitylog`. 
* Fixed bug in `activitylog`. Failed when not both start and complete columns where available. 
* Fixed bug in `assign_instance_id`. Failed when data had a column with the name `status`. 

## Other


# bupaR 0.5.1 

## Features

* Added new functions to check if an object `x` inherits from a particular event data class (`is.log(x)`, `is.eventlog(x)`,
`is.activitylog(x)`, `is.grouped_log(x)`, `is.grouped_eventlog(x)`, `is.grouped_actiivtylog(x)`).

## Bug Fixes

* `group_by(.data, ..., .add = F)` now works correctly on `grouped_eventlog`. Previously, applying `group_by()` to a `grouped_eventlog`
reverted it to a `data.frame`, which prevented the application of further **bupaR** functions on the returned value. 
* The `"raw"` attribute of metrics in **edeaR** (e.g. `throughput_time`) containing the original data is now kept after
applying `group_by()`. This can be useful for further analyses on the output of metrics and can be accessed using `attr(log, "raw")`.
* Fixed bug in `add_start_activity()` and `add_end_activity()` which failed when applied to an `activitylog`. 
* Fixed bug in `activitylog`. Failed when not both start and complete columns where available. 
* Fixed bug in `assign_instance_id`. Failed when data had a column with the name `status`. 

## Other

* Added a `NEWS.md` file to track changes to the package.
* Added GitHub Action (`pkgdown`).
* Updated `README.md`.