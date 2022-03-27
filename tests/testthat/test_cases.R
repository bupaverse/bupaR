
#### eventlog ####

test_that("test cases on eventlog", {

  load("./testdata/patients.rda")

  cases <- patients %>%
    cases()

  expect_equal(dim(cases), c(n_cases(patients), 10))
  expect_equal(colnames(cases), c("patient", "trace_length", "number_of_activities", "start_timestamp", "complete_timestamp",
                                  "trace", "trace_id", "duration", "first_activity", "last_activity"))

  expect_equal(cases[["trace_length"]], c(1, 5, 6))
  expect_equal(cases[["number_of_activities"]], c(1, 4, 4))
  expect_equal(cases[["start_timestamp"]][1], as.POSIXct("2017-05-12 08:52:23", format = "%Y-%m-%d %H:%M:%S", tz = "UTC"))    # George start
  expect_equal(cases[["complete_timestamp"]][1], as.POSIXct("2017-05-12 08:52:23", format = "%Y-%m-%d %H:%M:%S", tz = "UTC")) # George complete
  expect_equal(cases[["start_timestamp"]][2], as.POSIXct("2017-05-11 09:53:46", format = "%Y-%m-%d %H:%M:%S", tz = "UTC"))    # Jane start
  expect_equal(cases[["complete_timestamp"]][2], as.POSIXct("2017-05-12 10:46:21", format = "%Y-%m-%d %H:%M:%S", tz = "UTC")) # Jane complete
  # trace, trace_id & duration_in_days checked in case_list and durations, resp.
  expect_equal(cases[["first_activity"]], factor(c("register", "check-in", "check-in")))
  expect_equal(cases[["last_activity"]], factor(c("register", "check-out", "check-out")))
})

test_that("test cases on eventlog with activity NA", {

  load("./testdata/patients.rda")

  patients <- patients %>%
    mutate(activity = as.factor(ifelse(patient == "George Doe", NA, as.character(activity))))

  cases <- patients %>%
    cases()

  expect_equal(cases[["first_activity"]], factor(c(NA, "check-in", "check-in")))
  expect_equal(cases[["last_activity"]], factor(c(NA, "check-out", "check-out")))
})

test_that("test cases on grouped_eventlog", {

  load("./testdata/patients_grouped.rda")

  cases <- patients_grouped %>%
    cases()

  expect_equal(dim(cases), c(sum(n_cases(patients_grouped)[["n_cases"]]), 10))
  expect_equal(colnames(cases), c("patient", "trace_length", "number_of_activities", "start_timestamp", "complete_timestamp",
                                  "trace", "trace_id", "duration", "first_activity", "last_activity"))

  expect_equal(cases[["trace_length"]], c(1, 5, 6))
  expect_equal(cases[["number_of_activities"]], c(1, 4, 4))
  expect_equal(cases[["start_timestamp"]][1], as.POSIXct("2017-05-12 08:52:23", format = "%Y-%m-%d %H:%M:%S", tz = "UTC"))    # George start
  expect_equal(cases[["complete_timestamp"]][1], as.POSIXct("2017-05-12 08:52:23", format = "%Y-%m-%d %H:%M:%S", tz = "UTC")) # George complete
  expect_equal(cases[["start_timestamp"]][2], as.POSIXct("2017-05-11 09:53:46", format = "%Y-%m-%d %H:%M:%S", tz = "UTC"))    # Jane start
  expect_equal(cases[["complete_timestamp"]][2], as.POSIXct("2017-05-12 10:46:21", format = "%Y-%m-%d %H:%M:%S", tz = "UTC")) # Jane complete
  # trace, trace_id & duration_in_days checked in case_list and durations, resp.
  expect_equal(cases[["first_activity"]], factor(c("register", "check-in", "check-in")))
  expect_equal(cases[["last_activity"]], factor(c("register", "check-out", "check-out")))
})

#### activitylog ####

test_that("test cases on activitylog", {

  load("./testdata/patients_act.rda")

  cases <- patients_act %>%
    cases()

  expect_equal(dim(cases), c(n_cases(patients_act), 10))
  expect_equal(colnames(cases), c("patient", "trace_length", "number_of_activities", "start_timestamp", "complete_timestamp",
                                  "trace", "trace_id", "duration", "first_activity", "last_activity"))

  expect_equal(cases[["trace_length"]], c(1, 5, 6))
  expect_equal(cases[["number_of_activities"]], c(1, 4, 4))
  expect_equal(cases[["start_timestamp"]][1], as.POSIXct("2017-05-12 08:52:23", format = "%Y-%m-%d %H:%M:%S", tz = "UTC"))
  expect_equal(cases[["complete_timestamp"]][1], as.POSIXct("2017-05-12 08:52:23", format = "%Y-%m-%d %H:%M:%S", tz = "UTC"))
  # trace, trace_id & duration_in_days checked in case_list and durations, resp.
  expect_equal(cases[["first_activity"]], factor(c("register", "check-in", "check-in")))
  expect_equal(cases[["last_activity"]], factor(c("register", "check-out", "check-out")))
})

test_that("test cases on grouped_activitylog", {

  skip("grouped_activitylog not fully functional yet")
})