# Unite activity labels

Recode two or different more activity labels two a uniform activity
label

## Usage

``` r
act_unite(log, ...)

# S3 method for class 'log'
act_unite(log, ...)

# S3 method for class 'grouped_log'
act_unite(log, ...)
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

  A series of named character vectors. The activity labels in each
  vector will be replaced with the name.

## Methods (by class)

- `act_unite(log)`: Unite activity labels in event log

- `act_unite(grouped_log)`: Unite activity labels of event log

## See also

[`eventlog`](https://bupaverse.github.io/bupaR/reference/eventlog.md),
[`activity_id`](https://bupaverse.github.io/bupaR/reference/activity_id.md),
[`act_recode`](https://bupaverse.github.io/bupaR/reference/act_recode.md)

Other Activity processing functions:
[`act_collapse()`](https://bupaverse.github.io/bupaR/reference/act_collapse.md),
[`act_recode()`](https://bupaverse.github.io/bupaR/reference/act_recode.md)
