# Create activity log

Create activity log

## Usage

``` r
activitylog(activitylog, case_id, activity_id, resource_id, timestamps, order)
```

## Arguments

- activitylog:

  The data object to be used as activity log. This can be a `data.frame`
  or `tibble`.

- case_id:

  The case classifier of the activity log. A character vector containing
  variable names of length 1 or more.

- activity_id:

  The activity classifier of the activity log. A character vector
  containing variable names of length 1 or more.

- resource_id:

  The resource identifier of the activity log. A character vector
  containing variable names of length 1 or more.

- timestamps:

  The columns with timestamps refering to different lifecycle events. A
  character vector of 1 or more. These should have one of the following
  names:
  "schedule","assign","reassign","start","suspend","resume","abort_activity","abort_case","complete","manualskip","autoskip".
  These columns should be of the Date or POSIXct class.

- order:

  Configure how to handle sort events with equal timestamps: auto will
  use the order in the original data, alphabetical will sort the
  activity labels by alphabet, sorted will assume that the data frame is
  already correctly sorted and has a column '.order', providing a column
  name will use this column for ordering (can be numeric of character).
  The latter will never overrule timestamp orderings.
