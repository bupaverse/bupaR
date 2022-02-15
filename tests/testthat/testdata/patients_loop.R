library(bupaR)

patients_df <- read.csv("tests/testthat/testdata/patients_loop.csv", stringsAsFactors = TRUE) %>%
  mutate(timestamp = as.POSIXct(timestamp, format = "%Y-%m-%d %H:%M:%S", tz = "UTC"))

patients_loop <- patients_df %>%
  eventlog(case_id = "patient",
           activity_id = "activity",
           activity_instance_id = "activity_instance",
           lifecycle_id = "status",
           timestamp = "timestamp",
           resource_id = "resource",
           validate = FALSE)

save(patients_loop, file = "tests/testthat/testdata/patients_loop.rda", compress = "gzip")

patients_loop_grouped <- patients_loop %>%
  group_by(patient)

save(patients_loop_grouped, file = "tests/testthat/testdata/patients_loop_grouped.rda", compress = "gzip")