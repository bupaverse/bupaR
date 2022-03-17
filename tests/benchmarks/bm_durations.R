rm(list = ls(all.names = TRUE))
gc()

devtools::load_all()

hb <- hospital_billing
bm <- bench::mark(hb %>% durations(), iterations = 25)

print(bm)

# A tibble: 1 x 13
#expression              min   median `itr/sec` mem_alloc `gc/sec` n_itr  n_gc total_time result                memory               time       gc
#<bch:expr>         <bch:tm> <bch:tm>     <dbl> <bch:byt>    <dbl> <int> <dbl>   <bch:tm> <list>                <list>               <list>     <list>
#1 hb %>% durations()     1.2s    1.39s     0.719    5.43MB     5.90    25   205      34.8s <tibble [10,000 x 2]> <Rprofmem [575 x 3]> <bench_tm> <tibble>