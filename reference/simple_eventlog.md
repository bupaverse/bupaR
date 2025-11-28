# Simple Eventlog

**\[superseded\]**

A function to instantiate an object of class `eventlog` by specifying a
`data.frame` or `tibble` and the minimally required case identifier,
activity identifier and timestamp.

This function is superseded by the introduction of the activitylog
format. Eventlogs in this 'simple' format can be seen as log of
activities, and be created with
[`activitylog()`](https://bupaverse.github.io/bupaR/reference/activitylog.md).
If required, the resulting activity log can be transformed back to the
eventlog format using `to_eventlog`.

## Usage

``` r
simple_eventlog(
  eventlog,
  case_id = NULL,
  activity_id = NULL,
  timestamp = NULL,
  resource_id = NULL,
  order = "auto",
  return_type = c("eventlog", "activitylog")
)

isimple_eventlog(eventlog)
```

## Arguments

- eventlog:

  The data object to be used as event log. This can be a `data.frame` or
  `tibble`.

- case_id:

  The case classifier of the event log.

- activity_id:

  The activity classifier of the event log.

- timestamp:

  The timestamp of the event log.

- resource_id:

  The resource classifier of the event log (optional).

- order:

  Configure how to handle sort events with equal timestamps: auto will
  use the order in the original data, alphabetical will sort the
  activity labels by alphabet, sorted will assume that the data frame is
  already correctly sorted and has a column '.order', providing a column
  name will use this column for ordering (can be numeric of character).
  The latter will never overrule timestamp orderings.

- return_type:

  Whether to return eventlog (default) or activitylog object.

## See also

[`eventlog`](https://bupaverse.github.io/bupaR/reference/eventlog.md),[`case_id`](https://bupaverse.github.io/bupaR/reference/case_id.md),
[`activity_id`](https://bupaverse.github.io/bupaR/reference/activity_id.md),
[`activity_instance_id`](https://bupaverse.github.io/bupaR/reference/activity_instance_id.md),[`lifecycle_id`](https://bupaverse.github.io/bupaR/reference/lifecycle_id.md),
[`timestamp`](https://bupaverse.github.io/bupaR/reference/timestamp.md)

## Examples

``` r
if (FALSE) { # \dontrun{
data <- data.frame(case = rep("A",5),
activity_id = c("A","B","C","D","E"),
timestamp = date_decimal(1:5))
simple_eventlog(data,case_id = "case",
activity_id = "activity_id",
timestamp = "timestamp")
} # }
```
