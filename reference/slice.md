# Slice function for event log

Slice function for event log

## Usage

``` r
slice(.data, ..., .by = NULL, .preserve = FALSE)

# S3 method for class 'log'
slice(.data, ...)

# S3 method for class 'grouped_log'
slice(.data, ...)

# S3 method for class 'eventlog'
slice_activities(.data, ...)

# S3 method for class 'activitylog'
slice_activities(.data, ...)

# S3 method for class 'grouped_log'
slice_activities(.data, ...)

# S3 method for class 'eventlog'
slice_events(.data, ...)

# S3 method for class 'grouped_eventlog'
slice_events(.data, ...)
```

## Arguments

- .data:

  A data frame, data frame extension (e.g. a tibble), or a lazy data
  frame (e.g. from dbplyr or dtplyr). See *Methods*, below, for more
  details.

- ...:

  Additional arguments passed to dplyr

- .by:

  **\[experimental\]**

  \<[`tidy-select`](https://dplyr.tidyverse.org/reference/dplyr_tidy_select.html)\>
  Optionally, a selection of columns to group by for just this
  operation, functioning as an alternative to
  [`group_by()`](https://dplyr.tidyverse.org/reference/group_by.html).
  For details and examples, see
  [?dplyr_by](https://dplyr.tidyverse.org/reference/dplyr_by.html).

- .preserve:

  Relevant when the `.data` input is grouped. If `.preserve = FALSE`
  (the default), the grouping structure is recalculated based on the
  resulting data, otherwise the grouping is kept as is.

## Methods (by class)

- `slice(log)`: Slice n cases of a log

- `slice(grouped_log)`: Slice grouped log: take slice of cases from each
  group.

## Functions

- `slice_activities(eventlog)`: Take a slice of activity instances from
  event log

- `slice_activities(activitylog)`: Take a slice of activity instances
  from activity log

- `slice_activities(grouped_log)`: Take a slice of activity instances
  from grouped event log

- `slice_events(eventlog)`: Take a slice of events from event log

- `slice_events(grouped_eventlog)`: Take a slice of events from grouped
  event log
