# Convert timestamp format

Function converting the timestamps in the data frame to the appropriate
format.

## Usage

``` r
convert_timestamps(x, columns, format)
```

## Arguments

- x:

  Data.frame containing events or activities.

- columns:

  A character vector with one or more names of columns to convert

- format:

  The format of the timestamps in the original dataset (either ymd_hms,
  dmy_hms, ymd_hm, ymd, dmy, dmy, ...). To be provided without quotation
  marks!

## Value

Data.frame with converted timestamps

## See also

Other Eventlog construction helpers:
[`assign_instance_id()`](https://bupaverse.github.io/bupaR/reference/assign_instance_id.md)
