rm(list = ls(all.names = TRUE))
gc()

source("tests/benchmarks/utils.R")

f <- file(getFilename(), open = "wt")
sink(file = f, type = "output")
sink(file = f, type = "message")

devtools::load_all()

hb <- hospital_billing
bm <- bench::mark(hb %>% cases(), iterations = 25)

print(bm)

close(f)