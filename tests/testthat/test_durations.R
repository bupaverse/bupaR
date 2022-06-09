
#### eventlog ####

test_that("test durations on eventlog", {

  load("./testdata/patients.rda")

  durations <- patients %>%
    durations()

  expect_equal(dim(durations), c(n_cases(patients), 2))
  expect_equal(colnames(durations), c("patient", "duration"))

  expect_s3_class(durations[["duration"]], "difftime")
  expect_equal(as.numeric(durations[["duration"]]), c(109150, 89555, 0))
})

test_that("test durations on eventlog with units = 'hours'", {

  load("./testdata/patients.rda")

  durations <- patients %>%
    durations(units = "hours")

  expect_equal(dim(durations), c(n_cases(patients), 2))
  expect_equal(colnames(durations), c("patient", "duration"))

  expect_s3_class(durations[["duration"]], "difftime")
  expect_equal(units(durations[["duration"]]), "hours")
  expect_equal(as.numeric(durations[["duration"]]), c(109150 / 3600, 89555 / 3600, 0))
})

test_that("test durations on eventlog with units outside allowed domain", {

  load("./testdata/patients.rda")

  expect_error(
    durations <- patients %>%
      durations(units = "milliseconds"),
    ".*must be one of \"auto\", \"secs\", \"mins\", \"hours\", \"days\", or.*\"weeks\", not \"milliseconds\".*")
})

test_that("test durations on grouped_eventlog", {

  load("./testdata/patients_grouped.rda")

  durations <- patients_grouped %>%
    durations()

  expect_equal(dim(durations), c(sum(n_cases(patients_grouped)[["n_cases"]]), 2))
  expect_equal(colnames(durations), c("patient", "duration"))

  expect_s3_class(durations[["duration"]], "difftime")
  expect_equal(as.numeric(durations[["duration"]]), c(109150, 89555, 0))
})


#### activitylog ####

test_that("test durations on activitylog", {

  load("./testdata/patients_act.rda")

  durations <- patients_act %>%
    durations()

  expect_equal(dim(durations), c(n_cases(patients_act), 2))
  expect_equal(colnames(durations), c("patient", "duration"))

  expect_s3_class(durations[["duration"]], "difftime")
  expect_equal(as.numeric(durations[["duration"]]), c(109150, 89555, 0))
})
