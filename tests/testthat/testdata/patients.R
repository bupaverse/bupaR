library(bupaR)

patients <- read.csv("tests/testthat/testdata/patients.csv") %>%
  mutate(timestamp = as.POSIXct(timestamp, format = "%Y-%m-%d %H:%M:%S")) %>%
  eventlog(case_id = "patient",
           activity_id = "activity",
           activity_instance_id = "activity_instance",
           lifecycle_id = "status",
           timestamp = "timestamp",
           resource_id = "resource")

save(patients, file = "tests/testthat/testdata/patients.rda", compress = "gzip")

patients_grouped <- patients %>%
  group_by(patient)

save(patients_grouped, file = "tests/testthat/testdata/patients_grouped.rda", compress = "gzip")