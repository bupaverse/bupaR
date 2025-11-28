# Recode activity labels

Recode one or more activity labels through specifying their old and new
label

## Usage

``` r
act_recode(log, ...)

# S3 method for class 'log'
act_recode(log, ...)

# S3 method for class 'grouped_log'
act_recode(log, ...)
```

## Arguments

- log:

  [`log`](https://bupaverse.github.io/bupaR/reference/log.md): Object of
  class [`log`](https://bupaverse.github.io/bupaR/reference/log.md) or
  derivatives
  ([`grouped_log`](https://bupaverse.github.io/bupaR/reference/grouped_log.md),
  [`eventlog`](https://bupaverse.github.io/bupaR/reference/eventlog.md),
  [`activitylog`](https://bupaverse.github.io/bupaR/reference/activitylog.md),
  etc.).

- ...:

  A sequence of named character vectors of length one where the names
  gives the new label and the value gives the old label. Labels not
  mentioned will be left unchanged.

## Methods (by class)

- `act_recode(log)`: Recode activity labels of event log

- `act_recode(grouped_log)`: Recode activity labels of event log

## See also

[`eventlog`](https://bupaverse.github.io/bupaR/reference/eventlog.md),
[`activity_id`](https://bupaverse.github.io/bupaR/reference/activity_id.md),
[`act_unite`](https://bupaverse.github.io/bupaR/reference/act_unite.md)

Other Activity processing functions:
[`act_collapse()`](https://bupaverse.github.io/bupaR/reference/act_collapse.md),
[`act_unite()`](https://bupaverse.github.io/bupaR/reference/act_unite.md)
