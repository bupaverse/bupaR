
test_that("test cases on eventlog", {

  load("./testdata/patients.rda")

  cases <- patients %>%
    cases()

  expect_equal(dim(cases), c(n_cases(patients), 10))
  expect_equal(colnames(cases), c("patient", "trace_length", "number_of_activities", "start_timestamp", "complete_timestamp",
                                  "trace", "trace_id", "duration_in_days", "first_activity", "last_activity"))

  expect_equal(cases[["trace_length"]], c(4, 5))
  expect_equal(cases[["number_of_activities"]], c(4, 4))
  expect_equal(cases[["start_timestamp"]][1], as.POSIXct("2017-05-11 09:53:46", format = "%Y-%m-%d %H:%M:%S", tz = "UTC"))
  expect_equal(cases[["complete_timestamp"]][1], as.POSIXct("2017-05-12 10:46:21", format = "%Y-%m-%d %H:%M:%S", tz = "UTC"))
  # trace, trace_id & duration_in_days checked in case_list and durations, resp.
  expect_true(all(cases[["first_activity"]] == "check-in"))
  expect_true(all(cases[["last_activity"]] == "check-out"))
})

test_that("test cases on grouped_eventlog", {

  load("./testdata/patients_grouped.rda")

  cases <- patients_grouped %>%
    cases()

  expect_equal(dim(cases), c(sum(n_cases(patients_grouped)[["n_cases"]]), 10))
  expect_equal(colnames(cases), c("patient", "trace_length", "number_of_activities", "start_timestamp", "complete_timestamp",
                                  "trace", "trace_id", "duration_in_days", "first_activity", "last_activity"))

  expect_equal(cases[["trace_length"]], c(4, 5))
  expect_equal(cases[["number_of_activities"]], c(4, 4))
  expect_equal(cases[["start_timestamp"]][1], as.POSIXct("2017-05-11 09:53:46", format = "%Y-%m-%d %H:%M:%S", tz = "UTC"))
  expect_equal(cases[["complete_timestamp"]][1], as.POSIXct("2017-05-12 10:46:21", format = "%Y-%m-%d %H:%M:%S", tz = "UTC"))
  # trace, trace_id & duration_in_days checked in case_list and durations, resp.
  expect_true(all(cases[["first_activity"]] == "check-in"))
  expect_true(all(cases[["last_activity"]] == "check-out"))
})