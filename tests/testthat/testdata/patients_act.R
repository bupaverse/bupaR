library(bupaR)
library(tidyr)

patients_act_df <- read.csv("tests/testthat/testdata/patients_act.csv", stringsAsFactors = TRUE) %>%
  mutate(schedule = as.POSIXct(schedule, format = "%Y-%m-%d %H:%M:%S", tz = "UTC"),
         start = as.POSIXct(start, format = "%Y-%m-%d %H:%M:%S", tz = "UTC"),
         complete = as.POSIXct(complete, format = "%Y-%m-%d %H:%M:%S", tz = "UTC"))

patients_act <- patients_act_df %>%
  activitylog(case_id = "patient",
              activity_id = "activity",
  			  timestamps = c("schedule", "start", "complete"),
              resource_id = "resource")

save(patients_act_df, file = "tests/testthat/testdata/patients_act_df.rda", compress = "gzip")
save(patients_act, file = "tests/testthat/testdata/patients_act.rda", compress = "gzip")

patients_act_grouped_df <- patients_act_df %>%
  group_by(patient)

patients_act_grouped <- patients_act %>%
  group_by(patient)

save(patients_act_grouped_df, file = "tests/testthat/testdata/patients_act_grouped_df.rda", compress = "gzip")
save(patients_act_grouped, file = "tests/testthat/testdata/patients_act_grouped.rda", compress = "gzip")
