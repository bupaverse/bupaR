library(bupaR)

patients_df <- read.csv("tests/testthat/testdata/patients.csv", stringsAsFactors = TRUE) %>%
  mutate(timestamp = as.POSIXct(timestamp, format = "%Y-%m-%d %H:%M:%S", tz = "UTC"))

patients <- patients_df %>%
  eventlog(case_id = "patient",
           activity_id = "activity",
           activity_instance_id = "activity_instance",
           lifecycle_id = "status",
           timestamp = "timestamp",
           resource_id = "resource")

save(patients_df, file = "tests/testthat/testdata/patients_df.rda", compress = "gzip")
save(patients, file = "tests/testthat/testdata/patients.rda", compress = "gzip")

patients_grouped_df <- patients_df %>%
  group_by(patient)

patients_grouped <- patients %>%
  group_by(patient)

save(patients_grouped_df, file = "tests/testthat/testdata/patients_grouped_df.rda", compress = "gzip")
save(patients_grouped, file = "tests/testthat/testdata/patients_grouped.rda", compress = "gzip")