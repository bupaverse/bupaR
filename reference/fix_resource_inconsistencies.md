# Fix resource inconsistencies

Fix resource inconsistencies

## Usage

``` r
fix_resource_inconsistencies(
  eventlog,
  filter_condition,
  overwrite_missings,
  detected_problems,
  details
)

# S3 method for class 'activitylog'
fix_resource_inconsistencies(
  eventlog,
  filter_condition = NULL,
  overwrite_missings = FALSE,
  detected_problems = NULL,
  details = TRUE
)

# S3 method for class 'eventlog'
fix_resource_inconsistencies(
  eventlog,
  filter_condition = NULL,
  overwrite_missings = FALSE,
  detected_problems = NULL,
  details = TRUE
)
```

## Arguments

- eventlog:

  Event log object

- filter_condition:

  Condition that is used to extract a subset of the activity log prior
  to the application of the function

- overwrite_missings:

  If events are missing, overwrite the resource if other events within
  activity instance are performed by single resource. Default FALSE.

- detected_problems:

  If available, the problems detected that need to be fixed. If not
  available, the function detect_resource_inconsistenties will be
  called.

- details:

  Show details

## Methods (by class)

- `fix_resource_inconsistencies(activitylog)`: activitylog Fix
  activitylog

- `fix_resource_inconsistencies(eventlog)`: eventlog Fix eventlog
