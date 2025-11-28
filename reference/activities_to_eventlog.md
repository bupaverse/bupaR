# Create event log from list of activity instances

**\[superseded\]**

This function is superseded. For new code we recommend using
activitylog() to create an activitylog, and if needed to_eventlog() to
transform it into an eventlog.

## Usage

``` r
activities_to_eventlog(
  activity_log,
  case_id,
  activity_id,
  resource_id,
  timestamps,
  order = "auto"
)
```

## Arguments

- activity_log:

  A data.frame where each row is an activity instances

- case_id:

  Column name of the case identifier

- activity_id:

  Column name of the activity identifier

- resource_id:

  Column name of the resource identifier

- timestamps:

  A vector of column names containing different timestamp. To column
  names will be transformed to lifecycle identifiers

- order:

  Configure how to handle sort events with equal timestamps: auto will
  use the order in the original data, alphabetical will sort the
  activity labels by alphabet, sorted will assume that the data frame is
  already correctly sorted and has a column '.order', providing a column
  name will use this column for ordering (can be numeric of character).
  The latter will never overrule timestamp orderings.
