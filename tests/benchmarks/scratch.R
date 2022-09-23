
generate_str <- function (n, length) {
  stringi::stri_join(stringi::stri_rand_strings(n, length, "[A-Za-z0-9]"), collapse = ",")
}

# stri_sub is fastest
results <- bench::press(
  n = c(5, 20, 100, 1000),
  length = c(1, 4, 10, 100),
  {
    dat <- generate_str(n, length)
    bench::mark(
      first_regex = stringi::stri_extract_first_regex(rand_strings, "^[^,]*"),
      stringi_split = stringi::stri_split_fixed(rand_strings, ",")[[1L]][1L],
      strsplit = strsplit(rand_strings, split = ",")[[1L]][1L],
      substr = substr(rand_strings, start = 1L, stop = stringr::str_locate(rand_strings, ",") - 1L),
      stri_sub = stringi::stri_sub(rand_strings, to = stringi::stri_locate_first_fixed(rand_strings, ",")[1L] - 1L, use_matrix = FALSE),
      iterations = 10000,
      check = TRUE)
  }
)

# Working with . is fastest.
hb <- data.table(hospital_billing)
bench::mark(
  SD = hb[, .SD[which.min(timestamp)], by = case_id, .SDcols = "timestamp"],
  I = hb[hb[, .I[which.min(timestamp)], by = case_id]$V1][, .(case_id, timestamp)],
  dot = hb[, .(ts = min(timestamp)), by = case_id],
  dot_c = hb[, .(ts = min(timestamp)), by = c("case_id")],
  iterations = 25,
  check = FALSE
)
# A tibble: 4 x 13
#expression      min   median `itr/sec` mem_alloc `gc/sec` n_itr  n_gc total_time result memory                  time            gc
#<bch:expr> <bch:tm> <bch:tm>     <dbl> <bch:byt>    <dbl> <int> <dbl>   <bch:tm> <list> <list>                  <list>          <list>
#1 SD            1.41s    1.59s     0.629  162.76MB     4.33    25   172      39.7s <NULL> <Rprofmem [39,137 x 3]> <bench_tm [25]> <tibble [25 x 3]>
#2 I           21.45ms  24.33ms    39.2      2.67MB     3.13    25     2    638.1ms <NULL> <Rprofmem [66 x 3]>     <bench_tm [25]> <tibble [25 x 3]>
#3 dot          4.06ms   4.76ms   205.       1.81MB     0       25     0    121.9ms <NULL> <Rprofmem [30 x 3]>     <bench_tm [25]> <tibble [25 x 3]>
#4 dot_c        4.62ms   5.07ms   182.       1.81MB     7.29    25     1    137.1ms <NULL> <Rprofmem [32 x 3]>     <bench_tm [25]> <tibble [25 x 3]>

# DT with keys is fastest
x <- data.table(Id  = stri_rand_strings(10000, 3, "[A-Za-z0-9]"),
                X1  = sample.int(100000, 10000, replace = FALSE),
                key = "Id")
y <- data.table(Id  = stri_rand_strings(10000, 3, "[A-Za-z0-9]"),
                Y1  = sample.int(100000, 10000, replace = FALSE),
                key = "Id")
bench::mark(
  DT = x[y, on = "Id", nomatch = 0],
  merge = merge(x, y, on = "Id"),
  iterations = 25,
  check = FALSE
)
# A tibble: 2 x 13
#expression      min   median `itr/sec` mem_alloc `gc/sec` n_itr  n_gc total_time result memory              time            gc
#<bch:expr> <bch:tm> <bch:tm>     <dbl> <bch:byt>    <dbl> <int> <dbl>   <bch:tm> <list> <list>              <list>          <list>
#1 DT           2.44ms   2.77ms      348.     329KB      0      25     0     71.9ms <NULL> <Rprofmem [23 x 3]> <bench_tm [25]> <tibble [25 x 3]>
#2 merge        2.83ms   3.21ms      290.     329KB     12.1    24     1     82.8ms <NULL> <Rprofmem [24 x 3]> <bench_tm [25]> <tibble [25 x 3]>
#
# Without keys:
# A tibble: 2 x 13
#expression      min   median `itr/sec` mem_alloc `gc/sec` n_itr  n_gc total_time result memory              time            gc
#<bch:expr> <bch:tm> <bch:tm>     <dbl> <bch:byt>    <dbl> <int> <dbl>   <bch:tm> <list> <list>              <list>          <list>
#1 DT            8.3ms   10.9ms      94.8     419KB        0    25     0      264ms <NULL> <Rprofmem [32 x 3]> <bench_tm [25]> <tibble [25 x 3]>
#2 merge        8.97ms   10.7ms      91.9     414KB        0    25     0      272ms <NULL> <Rprofmem [26 x 3]> <bench_tm [25]> <tibble [25 x 3]>


x <- data.table(X = sample.int(1000, 10000, replace = TRUE),
                Y = stri_rand_strings(10000, 3, "[A-Za-z0-9]"))

# setorderv is fastest.
bench::mark(
  setorder = setorder(x, X, Y),
  setorderv = setorderv(x, c("X", "Y")),
  order = x[order(X, Y)],
  base_order = x[base:::order(X, Y)],
  iterations = 1000,
  check = FALSE
)


x <- data.table(X = sample.int(1000, 10000, replace = TRUE),
                Y = stri_rand_strings(10000, 3, "[A-Za-z0-9]"),
                Z = stri_rand_strings(10000, 1, "[A-Z]"))

bench::mark(
  setorder = x[, setorder(.SD, X), by = Z],
  order = x[order(X), .SD, by = Z],
  iterations = 1000,
  check = FALSE
)

generate_nas <- function (n, pct) {
  data.frame(X = sample.int(1000, n, replace = TRUE)) %>%
    mutate(X = ifelse(row_number(.) %in% sample(1:n(), size = ((pct * 100) * n() / 100)), NA, X))
}

# lenght(which(!is.na())) is fastest
results <- bench::press(
  n = c(100, 1000, 10000),
  pct = c(0.05, 0.1, 0.25, 0.5),
{
  dat <- generate_nas(n, pct)
  bench::mark(
    na.omit = length(na.omit(dat$X)),
    which = length(which(!is.na(dat$X))),
    iterations = 10000,
    check = TRUE)
}
)

# A tibble: 24 x 15
# expression     n   pct      min   median `itr/sec` mem_alloc `gc/sec` n_itr  n_gc total_time result    memory              time                gc
# <bch:expr> <dbl> <dbl> <bch:tm> <bch:tm>     <dbl> <bch:byt>    <dbl> <int> <dbl>   <bch:tm> <list>    <list>              <list>              <list>
# 1 na.omit      100  0.05   51.2us   68.1us    13154.     239KB    105.   9921    79   754.22ms <int [1]> <Rprofmem [10 x 3]> <bench_tm [10,000]> <tibble [10,000 x 3]>
# 2 which        100  0.05   28.4us   37.2us    21860.     154KB     61.4  9972    28   456.18ms <int [1]> <Rprofmem [4 x 3]>  <bench_tm [10,000]> <tibble [10,000 x 3]>
# 3 na.omit     1000  0.05   55.7us   68.8us    11979.     239KB     52.9  9956    44   831.14ms <int [1]> <Rprofmem [10 x 3]> <bench_tm [10,000]> <tibble [10,000 x 3]>
# 4 which       1000  0.05   28.6us     37us    22727.     154KB     63.8  9972    28   438.77ms <int [1]> <Rprofmem [4 x 3]>  <bench_tm [10,000]> <tibble [10,000 x 3]>
# 5 na.omit    10000  0.05     53us   64.6us    13123.     239KB     58.0  9956    44   758.68ms <int [1]> <Rprofmem [10 x 3]> <bench_tm [10,000]> <tibble [10,000 x 3]>
# 6 which      10000  0.05   26.5us   32.8us    28239.     154KB     79.3  9972    28   353.13ms <int [1]> <Rprofmem [4 x 3]>  <bench_tm [10,000]> <tibble [10,000 x 3]>
# 7 na.omit      100  0.1    63.1us   70.1us    12902.     243KB     58.3  9955    45   771.56ms <int [1]> <Rprofmem [10 x 3]> <bench_tm [10,000]> <tibble [10,000 x 3]>
# 8 which        100  0.1    29.1us     36us    24967.     153KB     70.1  9972    28   399.41ms <int [1]> <Rprofmem [4 x 3]>  <bench_tm [10,000]> <tibble [10,000 x 3]>
# 9 na.omit     1000  0.1    62.3us   72.7us    12265.     243KB     55.4  9955    45   811.63ms <int [1]> <Rprofmem [10 x 3]> <bench_tm [10,000]> <tibble [10,000 x 3]>
# 10 which       1000  0.1    29.1us   35.5us    25763.     153KB     74.9  9971    29   387.03ms <int [1]> <Rprofmem [4 x 3]>  <bench_tm [10,000]> <tibble [10,000 x 3]>
# 11 na.omit    10000  0.1    62.8us   69.8us    13151.     243KB     60.8  9954    46   756.89ms <int [1]> <Rprofmem [10 x 3]> <bench_tm [10,000]> <tibble [10,000 x 3]>
# 12 which      10000  0.1    29.3us   35.9us    26060.     153KB     73.2  9972    28   382.66ms <int [1]> <Rprofmem [4 x 3]>  <bench_tm [10,000]> <tibble [10,000 x 3]>
# 13 na.omit      100  0.25   91.7us   99.6us     9439.     254KB     45.5  9952    48      1.05s <int [1]> <Rprofmem [10 x 3]> <bench_tm [10,000]> <tibble [10,000 x 3]>
# 14 which        100  0.25   35.3us   41.9us    22048.     147KB     59.7  9973    27   452.33ms <int [1]> <Rprofmem [4 x 3]>  <bench_tm [10,000]> <tibble [10,000 x 3]>
# 15 na.omit     1000  0.25   90.4us  100.2us     9219.     254KB     45.4  9951    49      1.08s <int [1]> <Rprofmem [10 x 3]> <bench_tm [10,000]> <tibble [10,000 x 3]>
# 16 which       1000  0.25   35.5us   41.8us    22068.     147KB     62.0  9972    28   451.88ms <int [1]> <Rprofmem [4 x 3]>  <bench_tm [10,000]> <tibble [10,000 x 3]>
# 17 na.omit    10000  0.25   89.7us  100.1us     9154.     254KB     45.1  9951    49      1.09s <int [1]> <Rprofmem [10 x 3]> <bench_tm [10,000]> <tibble [10,000 x 3]>
# 18 which      10000  0.25   35.1us   42.3us    21929.     147KB     61.6  9972    28   454.73ms <int [1]> <Rprofmem [4 x 3]>  <bench_tm [10,000]> <tibble [10,000 x 3]>
# 19 na.omit      100  0.5   116.6us    130us     7149.     274KB     38.1  9947    53      1.39s <int [1]> <Rprofmem [10 x 3]> <bench_tm [10,000]> <tibble [10,000 x 3]>
# 20 which        100  0.5    42.1us   47.7us    19369.     137KB     52.4  9973    27    514.9ms <int [1]> <Rprofmem [4 x 3]>  <bench_tm [10,000]> <tibble [10,000 x 3]>
# 21 na.omit     1000  0.5   117.2us    129us     7104.     274KB     37.9  9947    53       1.4s <int [1]> <Rprofmem [10 x 3]> <bench_tm [10,000]> <tibble [10,000 x 3]>
# 22 which       1000  0.5    42.2us   48.5us    19374.     137KB     52.5  9973    27   514.77ms <int [1]> <Rprofmem [4 x 3]>  <bench_tm [10,000]> <tibble [10,000 x 3]>
# 23 na.omit    10000  0.5   115.8us  126.8us     7360.     274KB     40.0  9946    54      1.35s <int [1]> <Rprofmem [10 x 3]> <bench_tm [10,000]> <tibble [10,000 x 3]>
# 24 which      10000  0.5    41.3us   48.1us    19192.     137KB     52.0  9973    27   519.64ms <int [1]> <Rprofmem [4 x 3]>  <bench_tm [10,000]> <tibble [10,000 x 3]>



x <- data.table(X = sample.int(1000, 10000, replace = TRUE),
                Y = stri_rand_strings(10000, 3, "[A-Za-z0-9]"),
                Z = stri_rand_strings(10000, 1, "[A-Z]"))

# slice_sample is much faster!
bench::mark(
  sample_n = dplyr::sample_n(x, size = 100),
  slice_sample = dplyr::slice_sample(x, n = 100),
  iterations = 1000,
  check = FALSE
)

# A tibble: 2 x 13
#expression        min   median `itr/sec` mem_alloc `gc/sec` n_itr  n_gc total_time result memory     time       gc
#<bch:expr>   <bch:tm> <bch:tm>     <dbl> <bch:byt>    <dbl> <int> <dbl>   <bch:tm> <list> <list>     <list>     <list>
#1 sample_n       5.17ms   5.71ms      164.     167KB     2.67   984    16      5.98s <NULL> <Rprofmem> <bench_tm> <tibble>
#2 slice_sample  887.4us 998.75us      894.     113KB     3.59   996     4      1.11s <NULL> <Rprofmem> <bench_tm> <tibble>


load("tests/testthat/testdata/patients.rda")
i <- 1
stop <- FALSE

while (!stop) {
  set.seed(i)

  case_ids <- patients %>%
    group_by(.data[[activity_id(.)]]) %>%
    distinct(.data[[case_id(.)]]) %>%
    dplyr::slice_sample(n = 1)

  if (!("John Doe" %in% case_ids[["patient"]])) {
    stop <- TRUE
  }

  i <- i + 1
}

# No real difference
bench::mark(
  .data = eventdataR::patients %>% arrange(desc(.data[[timestamp(.)]])),
  sym = eventdataR::patients %>% arrange(desc(!!timestamp_(.))),
  iterations = 1000,
  check = TRUE
)