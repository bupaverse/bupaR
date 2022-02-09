library(bupaR)

patients_fill_na_df <- read.csv("tests/testthat/testdata/patients_fill_na.csv", stringsAsFactors = TRUE) %>%
  mutate(timestamp = as.POSIXct(timestamp, format = "%Y-%m-%d %H:%M:%S", tz = "UTC"))

patients_fill_na <- patients_fill_na_df %>%
  eventlog(case_id = "patient",
           activity_id = "activity",
           activity_instance_id = "activity_instance",
           lifecycle_id = "status",
           timestamp = "timestamp",
           resource_id = "resource")

save(patients_fill_na_df, file = "tests/testthat/testdata/patients_fill_na_df.rda", compress = "gzip")
save(patients_fill_na, file = "tests/testthat/testdata/patients_fill_na.rda", compress = "gzip")

patients_fill_na_grouped_df <- patients_fill_na_df %>%
  group_by(patient)
patients_fill_na_grouped <- patients_fill_na %>%
  group_by(patient)

save(patients_fill_na_grouped_df, file = "tests/testthat/testdata/patients_fill_na_grouped_df.rda", compress = "gzip")
save(patients_fill_na_grouped, file = "tests/testthat/testdata/patients_fill_na_grouped.rda", compress = "gzip")