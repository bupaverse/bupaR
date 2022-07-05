rm(list = ls(all.names = TRUE))
gc()

source("tests/benchmarks/utils.R")

f <- file(getFilename(), open = "wt")
sink(file = f, type = "output")
sink(file = f, type = "message")

devtools::load_all()

hb <- hospital_billing
bm <- bench::mark(hb %>% cases(), iterations = 10)

print(bm)

close(f)
sink()

# A tibble: 1 x 13
#expression          min   median `itr/sec` mem_alloc `gc/sec` n_itr  n_gc total_time result                     memory     time            gc
#<bch:expr>     <bch:tm> <bch:tm>     <dbl> <bch:byt>    <dbl> <int> <dbl>   <bch:tm> <list>                     <list>     <list>          <list>
#1 hb %>% cases()    3.32s    3.54s     0.275    64.9MB     3.50    10   127      36.3s <data.table [10,000 x 10]> <Rprofmem> <bench_tm [10]> <tibble>