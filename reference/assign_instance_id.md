# Assign activity instance identifier to events

Apply heuristics to create an activity instance identifier, so that an
eventlog can be made.

## Usage

``` r
assign_instance_id(eventlog, case_id, activity_id, timestamp, lifecycle_id)
```

## Arguments

- eventlog:

  data.frame with events

- case_id:

  Case identifier

- activity_id:

  Activity identifier

- timestamp:

  Timestamp

- lifecycle_id:

  Lifecycle identifier

## See also

Other Eventlog construction helpers:
[`convert_timestamps()`](https://bupaverse.github.io/bupaR/reference/convert_timestamps.md)
