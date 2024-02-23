
<!-- README.md is generated from README.Rmd. Please edit that file -->

# bupaR <a href="https://bupaverse.github.io/bupaR/"><img src="man/figures/logo.png" align="right" height="50" /></a>

<!-- badges: start -->

[![CRAN
status](https://www.r-pkg.org/badges/version/bupaR)](https://CRAN.R-project.org/package=bupaR/)
[![GitHub
version](https://img.shields.io/badge/GitHub-0.5.1-blue)](https://github.com/bupaverse/bupaR)
[![R-CMD-check](https://github.com/bupaverse/bupaR/workflows/R-CMD-check/badge.svg/)](https://github.com/bupaverse/bupaR/actions/)
[![codecov](https://codecov.io/gh/bupaverse/bupaR/branch/dev/graph/badge.svg?token=40OgWBneWv/)](https://app.codecov.io/gh/bupaverse/bupaR/)
[![Lifecycle:
stable](https://lifecycle.r-lib.org/articles/figures/lifecycle-stable.svg)](https://lifecycle.r-lib.org/articles/stages.html#stable/)
<!-- badges: end -->

**bupaR** is an open-source suite for the handling and analysis of
business process data in [`R`](https://www.r-project.org/) developed by
the Business Informatics research group at Hasselt University, Belgium.
It builds upon the concept of an event log which is a logbook of events
which have happened and were recorded within the execution of a business
process.

[Read more](https://bupar.net/)

## Installation

You can install **bupaR** from [CRAN](https://cran.r-project.org/) with:

``` r
install.packages("bupaR")
```

### Development Version

You can install the development version of **bupaR** from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("bupaverse/bupaR")
```

## Cheat Sheet

<a href="https://bupar.net/materials/20170904%20poster%20bupaR.pdf"><img src="https://bupar.net/images/poster.PNG" width="630" height="443"/></a>

## Example

The [bupaR Documentation](https://bupaverse.github.io/docs/) website
contains more details on getting started with *Business Process
Analysis* using **bupaR**.

``` r
library(bupaR)
#> 
#> Attaching package: 'bupaR'
#> The following object is masked from 'package:stats':
#> 
#>     filter
#> The following object is masked from 'package:utils':
#> 
#>     timestamp
library(eventdataR)

# Get a list of all cases in the patients event log:
patients %>%
  cases()
#> # A tibble: 500 × 10
#>   patient trace_…¹ numbe…² start_timestamp     complete_timestamp  trace trace…³
#>   <chr>      <int>   <int> <dttm>              <dttm>              <chr>   <dbl>
#> 1 1              6       6 2017-01-02 11:41:53 2017-01-09 19:45:45 Regi…       4
#> 2 10             5       5 2017-01-06 05:58:54 2017-01-10 15:41:59 Regi…       7
#> 3 100            5       5 2017-04-11 16:34:31 2017-04-22 09:58:07 Regi…       7
#> 4 101            5       5 2017-04-16 06:38:58 2017-04-23 02:55:23 Regi…       7
#> 5 102            5       5 2017-04-16 06:38:58 2017-04-22 10:50:04 Regi…       7
#> # … with 495 more rows, 3 more variables: duration <drtn>,
#> #   first_activity <fct>, last_activity <fct>, and abbreviated variable names
#> #   ¹​trace_length, ²​number_of_activities, ³​trace_id
```
