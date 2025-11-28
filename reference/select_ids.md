# Select identifiers from log

Select identifiers from log

## Usage

``` r
select_ids(log, ...)

# S3 method for class 'log'
select_ids(log, ...)
```

## Arguments

- log:

  [`log`](https://bupaverse.github.io/bupaR/reference/log.md): Object of
  class [`log`](https://bupaverse.github.io/bupaR/reference/log.md),
  [`eventlog`](https://bupaverse.github.io/bupaR/reference/eventlog.md),
  or
  [`activitylog`](https://bupaverse.github.io/bupaR/reference/activitylog.md).

- ...:

  One or more of the following: activity_id, case_id,
  activity_instance_id, resource_id, lifecycle_id

## Methods (by class)

- `select_ids(log)`: Select identifiers from log

## Examples

``` r
library(eventdataR)

patients %>% select_ids(activity_id, case_id)
#> # A tibble: 5,442 × 2
#>    handling     patient
#>    <fct>        <chr>  
#>  1 Registration 1      
#>  2 Registration 2      
#>  3 Registration 3      
#>  4 Registration 4      
#>  5 Registration 5      
#>  6 Registration 6      
#>  7 Registration 7      
#>  8 Registration 8      
#>  9 Registration 9      
#> 10 Registration 10     
#> # ℹ 5,432 more rows

```
