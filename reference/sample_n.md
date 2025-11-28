# Sample function for eventlog

Sample function for eventlog

## Usage

``` r
sample_n(tbl, size, replace = FALSE, weight = NULL, .env = NULL, ...)

# S3 method for class 'log'
sample_n(tbl, size, replace = FALSE, weight = NULL, .env = NULL, ...)

# S3 method for class 'grouped_log'
sample_n(tbl, size, replace = FALSE, weight = NULL, .env = NULL, ...)
```

## Arguments

- tbl:

  Event log

- size:

  [`integer`](https://rdrr.io/r/base/integer.html): Number of cases to
  sample

- replace:

  [`logical`](https://rdrr.io/r/base/logical.html) (default `FALSE`):
  Sample with replacement `TRUE` or without `FALSE`.

- weight:

  Sampling weights. This must evaluate to a vector of non-negative
  numbers the same length as the input. Weights are automatically
  standardised to sum to 1.

- .env:

  Deprecated; please don't use.

- ...:

  ignored

## Methods (by class)

- `sample_n(log)`: Sample n cases of eventlog

- `sample_n(grouped_log)`: Stratified sampling of a grouped eventlog:
  sample n cases within each group

## See also

[`slice_sample`](https://bupaverse.github.io/bupaR/reference/slice_sample.md)
