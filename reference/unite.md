# Unite multiple columns into one.

Unite multiple columns into one.

## Usage

``` r
unite(data, col, ..., sep = "_", remove = TRUE, na.rm = FALSE)

# S3 method for class 'eventlog'
unite(data, col, ..., sep = "_", remove = T)

# S3 method for class 'activtylog'
unite(data, col, ..., sep = "_", remove = T)

# S3 method for class 'grouped_eventlog'
unite(data, col, ..., sep = "_", remove = T)
```

## Arguments

- data:

  Eventlog

- col:

  The name of the new column, as a string or symbol.

  This argument is passed by expression and supports
  [quasiquotation](https://rlang.r-lib.org/reference/topic-inject.html)
  (you can unquote strings and symbols). The name is captured from the
  expression with
  [`rlang::ensym()`](https://rlang.r-lib.org/reference/defusing-advanced.html)
  (note that this kind of interface where symbols do not represent
  actual objects is now discouraged in the tidyverse; we support it here
  for backward compatibility).

- ...:

  Additional arguments passed to tidyr

- sep:

  Separator to use between values.

- remove:

  If `TRUE`, remove input columns from output data frame.

- na.rm:

  If `TRUE`, missing values will be removed prior to uniting each value.

## Methods (by class)

- `unite(eventlog)`: Unite columns in eventlog

- `unite(activtylog)`: Unite columns in activitylog

- `unite(grouped_eventlog)`: Unite columns in grouped eventlog
