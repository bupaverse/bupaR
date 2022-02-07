library(bupaR)

patients_fill_na <- read.csv("tests/testthat/testdata/patients_fill_na.csv") %>%
  mutate(timestamp = as.POSIXct(timestamp, format = "%Y-%m-%d %H:%M:%S", tz = "UTC")) %>%
  eventlog(case_id = "patient",
           activity_id = "activity",
           activity_instance_id = "activity_instance",
           lifecycle_id = "status",
           timestamp = "timestamp",
           resource_id = "resource")

save(patients_fill_na, file = "tests/testthat/testdata/patients_fill_na.rda", compress = "gzip")

patients_fill_na_grouped <- patients_fill_na %>%
  group_by(patient)

save(patients_fill_na_grouped, file = "tests/testthat/testdata/patients_fill_na_grouped.rda", compress = "gzip")