# Collapse activity labels of a sub process into a single activity

Collapse activity labels of a sub process into a single activity

## Usage

``` r
act_collapse(log, ..., method)

# S3 method for class 'eventlog'
act_collapse(log, ..., method = c("entry_points", "consecutive"))

# S3 method for class 'activitylog'
act_collapse(log, ..., method = c("entry_points", "consecutive"))

# S3 method for class 'grouped_log'
act_collapse(log, ..., method = c("entry_points", "consecutive"))
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
  vector will be collapsed into one activity with the name of the
  vector.

- method:

  Defines how activities are collapsed: "entry_points" heuristically
  learns which of the specified activities occur at the start and end of
  the subprocess and collapses accordingly. "consecutive" collapses
  consecutive sequences of the activities.

## Details

There are different strategies to collapse activity labels (argument
´method´). The "entry_points" method aims to learn the start and end
activities of the sub process, by looking at the first and last activity
in each case over the whole log. Subsequently, it will create a new
instance of the sub process each time there is an end activity followed
by a start activity. This strategy will not take into account other
activities happening in the mean time. The "consecutive" method will
create an instance each time a new sequence of sub activities is
started. This strategy will thus only take into account interruptions of
the other activity labels.

## Methods (by class)

- `act_collapse(eventlog)`: Collapse activity labels of a subprocess
  into a single activity

- `act_collapse(activitylog)`: Collapse activity labels of a subprocess
  into a single activity

- `act_collapse(grouped_log)`: Collapse activity labels of a subprocess
  into a single activity

## See also

Other Activity processing functions:
[`act_recode()`](https://bupaverse.github.io/bupaR/reference/act_recode.md),
[`act_unite()`](https://bupaverse.github.io/bupaR/reference/act_unite.md)
