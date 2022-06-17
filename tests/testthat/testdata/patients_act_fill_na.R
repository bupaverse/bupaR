library(bupaR)

patients_act_fill_na_df <- read.csv("tests/testthat/testdata/patients_act_fill_na.csv", stringsAsFactors = TRUE) %>%
  mutate(schedule = as.POSIXct(schedule, format = "%Y-%m-%d %H:%M:%S", tz = "UTC"),
         start = as.POSIXct(start, format = "%Y-%m-%d %H:%M:%S", tz = "UTC"),
         complete = as.POSIXct(complete, format = "%Y-%m-%d %H:%M:%S", tz = "UTC"))

patients_act_fill_na <- patients_act_fill_na_df %>%
  activitylog(case_id = "patient",
              activity_id = "activity",
              timestamps = c("schedule", "start", "complete"),
              resource_id = "resource")

save(patients_act_fill_na_df, file = "tests/testthat/testdata/patients_act_fill_na_df.rda", compress = "gzip")
save(patients_act_fill_na, file = "tests/testthat/testdata/patients_act_fill_na.rda", compress = "gzip")

patients_act_fill_na_grouped_df <- patients_act_fill_na_df %>%
  group_by(patient)
patients_act_fill_na_grouped <- patients_act_fill_na %>%
  group_by(patient)

save(patients_act_fill_na_grouped_df, file = "tests/testthat/testdata/patients_act_fill_na_grouped_df.rda", compress = "gzip")
save(patients_act_fill_na_grouped, file = "tests/testthat/testdata/patients_act_fill_na_grouped.rda", compress = "gzip")
