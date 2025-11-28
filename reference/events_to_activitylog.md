# Events to activities

**\[deprecated\]** Create an activity log starting from an event log or
regular data.frame. This function is deprecated and replaced by the
function `activitylog` (for dataframe) and `to_activitylog` for
eventlogs.

## Usage

``` r
events_to_activitylog(
  eventlog,
  case_id,
  activity_id,
  activity_instance_id,
  lifecycle_id,
  timestamp,
  resource_id,
  ...
)
```

## Arguments

- eventlog:

  The event log to be converted. An object of class `eventlog` or
  `data.frame`

- case_id:

  If eventlog is data.frame, the case classifier of the event log. A
  character vector containing variable names of length 1 or more.

- activity_id:

  If eventlog is data.frame, the activity classifier of the event log. A
  character vector containing variable names of length 1 or more.

- activity_instance_id:

  If eventlog is data.frame, the activity instance classifier of the
  event log.

- lifecycle_id:

  If eventlog is data.frame, the life cycle classifier of the event log.

- timestamp:

  If eventlog is data.frame, the timestamp of the event log. Should
  refer to a Date or POSIXct field.

- resource_id:

  If eventlog is data.frame, the resource identifier of the event log. A
  character vector containing variable names of length 1 or more.

- ...:

  Additional argments, i.e. for fixing resource inconsistencies
