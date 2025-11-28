# Eventlog

A function to instantiate an object of class `eventlog` by specifying a
`data.frame` or `tibble` and appropriate case, activity and timestamp
classifiers.

## Usage

``` r
eventlog(
  eventlog,
  case_id,
  activity_id,
  activity_instance_id,
  lifecycle_id,
  timestamp,
  resource_id,
  order,
  validate
)

ieventlog(eventlog)
```

## Arguments

- eventlog:

  The data object to be used as event log. This can be a `data.frame` or
  `tibble`.

- case_id:

  The case classifier of the event log. A character vector containing
  variable names of length 1 or more.

- activity_id:

  The activity classifier of the event log. A character vector
  containing variable names of length 1 or more.

- activity_instance_id:

  The activity instance classifier of the event log.

- lifecycle_id:

  The life cycle classifier of the event log.

- timestamp:

  The timestamp of the event log. Should refer to a Date or POSIXct
  field.

- resource_id:

  The resource identifier of the event log. A character vector
  containing variable names of length 1 or more.

- order:

  Configure how to handle sort events with equal timestamps: auto will
  use the order in the original data, alphabetical will sort the
  activity labels by alphabet, sorted will assume that the data frame is
  already correctly sorted and has a column '.order', providing a column
  name will use this column for ordering (can be numeric of character).
  The latter will never overrule timestamp orderings.

- validate:

  When `TRUE` some basic checks are run on the contents of the event log
  such as that activity instances are not connected to more than one
  case or activity. Using `FALSE` improves the performance by skipping
  those checks.

## See also

[`case_id`](https://bupaverse.github.io/bupaR/reference/case_id.md),
[`activity_id`](https://bupaverse.github.io/bupaR/reference/activity_id.md),
[`activity_instance_id`](https://bupaverse.github.io/bupaR/reference/activity_instance_id.md),[`lifecycle_id`](https://bupaverse.github.io/bupaR/reference/lifecycle_id.md),
[`timestamp`](https://bupaverse.github.io/bupaR/reference/timestamp.md)

## Examples

``` r
if (FALSE) { # \dontrun{
data <- data.frame(case = rep("A",5),
activity_id = c("A","B","C","D","E"),
activity_instance_id = 1:5,
lifecycle_id = rep("complete",5),
timestamp = 1:5,
resource = rep("resource 1", 5))
eventlog(data,case_id = "case",
activity_id = "activity_id",
activity_instance_id = "activity_instance_id",
lifecycle_id = "lifecycle_id",
timestamp = "timestamp",
resource_id = "resource")
} # }
```
