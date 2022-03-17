
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