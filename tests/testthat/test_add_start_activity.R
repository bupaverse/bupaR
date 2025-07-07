
#### eventlog ####

test_that("test add_start_activity on eventlog", {

  load("./testdata/patients.rda")

  start <- patients %>%
    add_start_activity()

  start_activities <- start %>%
    filter(stringr::str_ends(.data[[activity_instance_id(.)]], "-start")) %>%
    arrange(.data[[timestamp(.)]])

  # For each case, an additional activity instance is added.
  expect_equal(dim(start), c(nrow(patients) + n_cases(patients), ncol(patients)))
  expect_equal(colnames(start), colnames(patients))

  expect_s3_class(start, "eventlog")

  # Expect event for each case with "Start" activity and instance ID {case}-start.
  expect_equal(nrow(start_activities), n_cases(patients))
  expect_equal(start_activities[[timestamp(start_activities)]], as.POSIXct(c("2017-05-10 08:33:25", "2017-05-11 09:53:45", "2017-05-12 08:52:22"), format = "%Y-%m-%d %H:%M:%S", tz = "UTC"))
  expect_equal(start_activities[[activity_instance_id(start_activities)]], c("John Doe-start", "Jane Doe-start", "George Doe-start"))
  expect_true(all(start_activities[[activity_id(start_activities)]] == "Start"))
})

test_that("test add_start_activity on eventlog with arg `label`", {

  load("./testdata/patients.rda")

  start <- patients %>%
    add_start_activity(label = "start case")

  start_activities <- start %>%
    filter(stringr::str_ends(.data[[activity_instance_id(.)]], "-start")) %>%
    arrange(.data[[timestamp(.)]])

  # For each case, an additional activity instance is added.
  expect_equal(dim(start), c(nrow(patients) + n_cases(patients), ncol(patients)))
  expect_equal(colnames(start), colnames(patients))

  expect_s3_class(start, "eventlog")

  # Expect event for each case with "start case" activity and instance ID {case}-start.
  expect_equal(nrow(start_activities), n_cases(patients))
  expect_equal(start_activities[[timestamp(start_activities)]], as.POSIXct(c("2017-05-10 08:33:25", "2017-05-11 09:53:45", "2017-05-12 08:52:22"), format = "%Y-%m-%d %H:%M:%S", tz = "UTC"))
  expect_equal(start_activities[[activity_instance_id(start_activities)]], c("John Doe-start", "Jane Doe-start", "George Doe-start"))
  expect_true(all(start_activities[[activity_id(start_activities)]] == "start case"))
})

test_that("test add_start_activity on eventlog fails with invalid arg `label`", {

  load("./testdata/patients.rda")

  # `label` should be character.
  expect_snapshot_error(
    patients %>%
      add_start_activity(label = 1)
  )

  # `label` should not be already present in log.
  expect_snapshot_error(
    patients %>%
      add_start_activity(label = "check-in")
  )
})

test_that("test add_start_activity on grouped_eventlog", {

  load("./testdata/patients_grouped.rda")

  start <- patients_grouped %>%
    add_start_activity()

  start_activities <- start %>%
    filter(stringr::str_ends(.data[[activity_instance_id(.)]], "-start")) %>%
    arrange(.data[[timestamp(.)]])

  # For each case, an additional activity instance is added.
  expect_equal(dim(start), c(nrow(patients_grouped) + sum(n_cases(patients_grouped)$n_cases), ncol(patients_grouped)))
  expect_equal(colnames(start), colnames(patients_grouped))

  expect_s3_class(start, "grouped_eventlog")

  # Expect that grouping vars remain
  expect_equal(groups(start), groups(patients_grouped))

  # Expect event for each case with "Start" activity and instance ID {case}-start.
  expect_equal(nrow(start_activities), sum(n_cases(patients_grouped)$n_cases))
  expect_equal(start_activities[[timestamp(start_activities)]], as.POSIXct(c("2017-05-10 08:33:25", "2017-05-11 09:53:45", "2017-05-12 08:52:22"), format = "%Y-%m-%d %H:%M:%S", tz = "UTC"))
  expect_equal(start_activities[[activity_instance_id(start_activities)]], c("John Doe-start", "Jane Doe-start", "George Doe-start"))
  expect_true(all(start_activities[[activity_id(start_activities)]] == "Start"))
})

test_that("test add_start_activity on grouped_eventlog with arg `label`", {

  load("./testdata/patients_grouped.rda")

  start <- patients_grouped %>%
    add_start_activity(label = "start case")

  start_activities <- start %>%
    filter(stringr::str_ends(.data[[activity_instance_id(.)]], "-start")) %>%
    arrange(.data[[timestamp(.)]])

  # For each case, an additional activity instance is added.
  expect_equal(dim(start), c(nrow(patients_grouped) + sum(n_cases(patients_grouped)$n_cases), ncol(patients_grouped)))
  expect_equal(colnames(start), colnames(patients_grouped))

  expect_s3_class(start, "grouped_eventlog")

  # Expect that grouping vars remain
  expect_equal(groups(start), groups(patients_grouped))

  # Expect event for each case with "start case" activity and instance ID {case}-start.
  expect_equal(nrow(start_activities), sum(n_cases(patients_grouped)$n_cases))
  expect_equal(start_activities[[timestamp(start_activities)]], as.POSIXct(c("2017-05-10 08:33:25", "2017-05-11 09:53:45", "2017-05-12 08:52:22"), format = "%Y-%m-%d %H:%M:%S", tz = "UTC"))
  expect_equal(start_activities[[activity_instance_id(start_activities)]], c("John Doe-start", "Jane Doe-start", "George Doe-start"))
  expect_true(all(start_activities[[activity_id(start_activities)]] == "start case"))
})


#### activitylog ####

test_that("test add_start_activity on activitylog", {

  load("./testdata/patients_act.rda")

  start <- patients_act %>%
    add_start_activity()

  start_activities <- start %>%
    filter(.data[[activity_id(patients_act)]] == "Start") %>%
    arrange(.data[["complete"]])

  # For each case, an additional activity is added.
  expect_equal(dim(start), c(nrow(patients_act) + n_cases(patients_act), ncol(patients_act)))
  expect_equal(colnames(start), colnames(patients_act))

  expect_s3_class(start, "activitylog")

  # Expect "Start" activity for each case.
  expect_equal(nrow(start_activities), n_cases(patients_act))
  expect_equal(start_activities[["complete"]], as.POSIXct(c("2017-05-10 08:33:25", "2017-05-11 09:53:45", "2017-05-12 08:52:22"), format = "%Y-%m-%d %H:%M:%S", tz = "UTC"))
  expect_true(all(start_activities[[activity_id(start_activities)]] == "Start"))
})

test_that("test add_start_activity on activitylog with arg `label`", {

  load("./testdata/patients_act.rda")

  start <- patients_act %>%
    add_start_activity(label = "start case")

  start_activities <- start %>%
    filter(.data[[activity_id(patients_act)]] == "start case") %>%
    arrange(.data[["complete"]])

  # For each case, an additional activity instance is added.
  expect_equal(dim(start), c(nrow(patients_act) + n_cases(patients_act), ncol(patients_act)))
  expect_equal(colnames(start), colnames(patients_act))

  expect_s3_class(start, "activitylog")

  # Expect "start case" activity for each case.
  expect_equal(nrow(start_activities), n_cases(patients_act))
  expect_equal(start_activities[["complete"]], as.POSIXct(c("2017-05-10 08:33:25", "2017-05-11 09:53:45", "2017-05-12 08:52:22"), format = "%Y-%m-%d %H:%M:%S", tz = "UTC"))
  expect_true(all(start_activities[[activity_id(start_activities)]] == "start case"))
})