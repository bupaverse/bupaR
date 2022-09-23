
#### eventlog ####

test_that("test add_end_activity on eventlog", {

  load("./testdata/patients.rda")

  end <- patients %>%
    add_end_activity()

  end_activities <- end %>%
    filter(stringr::str_ends(.data[[activity_instance_id(.)]], "-end")) %>%
    arrange(.data[[timestamp(.)]])

  # For each case, an additional activity instance is added.
  expect_equal(dim(end), c(nrow(patients) + n_cases(patients), ncol(patients)))
  expect_equal(colnames(end), colnames(patients))

  expect_s3_class(end, "eventlog")

  # Expect event for each case with "End" activity and instance ID {case}-end.
  expect_equal(nrow(end_activities), n_cases(patients))
  expect_equal(end_activities[[timestamp(end_activities)]], as.POSIXct(c("2017-05-11 14:52:37", "2017-05-12 08:52:24", "2017-05-12 10:46:22"), format = "%Y-%m-%d %H:%M:%S", tz = "UTC"))
  expect_equal(end_activities[[activity_instance_id(end_activities)]], c("John Doe-end", "George Doe-end", "Jane Doe-end"))
  expect_true(all(end_activities[[activity_id(end_activities)]] == "End"))
})

test_that("test add_end_activity on eventlog with arg `label`", {

  load("./testdata/patients.rda")

  end <- patients %>%
    add_end_activity(label = "end case")

  end_activities <- end %>%
    filter(stringr::str_ends(.data[[activity_instance_id(.)]], "-end")) %>%
    arrange(.data[[timestamp(.)]])

  # For each case, an additional activity instance is added.
  expect_equal(dim(end), c(nrow(patients) + n_cases(patients), ncol(patients)))
  expect_equal(colnames(end), colnames(patients))

  expect_s3_class(end, "eventlog")

  # Expect event for each case with "end case" activity and instance ID {case}-end.
  expect_equal(nrow(end_activities), n_cases(patients))
  expect_equal(end_activities[[timestamp(end_activities)]], as.POSIXct(c("2017-05-11 14:52:37", "2017-05-12 08:52:24", "2017-05-12 10:46:22"), format = "%Y-%m-%d %H:%M:%S", tz = "UTC"))
  expect_equal(end_activities[[activity_instance_id(end_activities)]], c("John Doe-end", "George Doe-end", "Jane Doe-end"))
  expect_true(all(end_activities[[activity_id(end_activities)]] == "end case"))
})

test_that("test add_end_activity on eventlog fails with invalid arg `label`", {

  load("./testdata/patients.rda")

  # `label` should be character.
  expect_snapshot_error(
    patients %>%
      add_end_activity(label = 1)
  )

  # `label` should not be already present in log.
  expect_snapshot_error(
    patients %>%
      add_end_activity(label = "check-out")
  )
})

test_that("test add_end_activity on grouped_eventlog", {

  load("./testdata/patients_grouped.rda")

  end <- patients_grouped %>%
    add_end_activity()

  end_activities <- end %>%
    filter(stringr::str_ends(.data[[activity_instance_id(.)]], "-end")) %>%
    arrange(.data[[timestamp(.)]])

  # For each case, an additional activity instance is added.
  expect_equal(dim(end), c(nrow(patients_grouped) + sum(n_cases(patients_grouped)$n_cases), ncol(patients_grouped)))
  expect_equal(colnames(end), colnames(patients_grouped))

  expect_s3_class(end, "grouped_eventlog")

  # Expect that grouping vars remain
  expect_equal(groups(end), groups(patients_grouped))

  # Expect event for each case with "End" activity and instance ID {case}-end.
  expect_equal(nrow(end_activities), sum(n_cases(patients_grouped)$n_cases))
  expect_equal(end_activities[[timestamp(end_activities)]], as.POSIXct(c("2017-05-11 14:52:37", "2017-05-12 08:52:24", "2017-05-12 10:46:22"), format = "%Y-%m-%d %H:%M:%S", tz = "UTC"))
  expect_equal(end_activities[[activity_instance_id(end_activities)]], c("John Doe-end", "George Doe-end", "Jane Doe-end"))
  expect_true(all(end_activities[[activity_id(end_activities)]] == "End"))
})

test_that("test add_end_activity on grouped_eventlog with arg `label`", {

  load("./testdata/patients_grouped.rda")

  end <- patients_grouped %>%
    add_end_activity(label = "end case")

  end_activities <- end %>%
    filter(stringr::str_ends(.data[[activity_instance_id(.)]], "-end")) %>%
    arrange(.data[[timestamp(.)]])

  # For each case, an additional activity instance is added.
  expect_equal(dim(end), c(nrow(patients_grouped) + sum(n_cases(patients_grouped)$n_cases), ncol(patients_grouped)))
  expect_equal(colnames(end), colnames(patients_grouped))

  expect_s3_class(end, "grouped_eventlog")

  # Expect that grouping vars remain
  expect_equal(groups(end), groups(patients_grouped))

  # Expect event for each case with "end case" activity and instance ID {case}-end.
  expect_equal(nrow(end_activities), sum(n_cases(patients_grouped)$n_cases))
  expect_equal(end_activities[[timestamp(end_activities)]], as.POSIXct(c("2017-05-11 14:52:37", "2017-05-12 08:52:24", "2017-05-12 10:46:22"), format = "%Y-%m-%d %H:%M:%S", tz = "UTC"))
  expect_equal(end_activities[[activity_instance_id(end_activities)]], c("John Doe-end", "George Doe-end", "Jane Doe-end"))
  expect_true(all(end_activities[[activity_id(end_activities)]] == "end case"))
})


#### activitylog ####

test_that("test add_end_activity on activitylog", {

  load("./testdata/patients_act.rda")

  end <- patients_act %>%
    add_end_activity()

  end_activities <- end %>%
    edeaR::filter_activity("End") %>%
    arrange(.data[["complete"]])

  # For each case, an additional activity is added.
  expect_equal(dim(end), c(nrow(patients_act) + n_cases(patients_act), ncol(patients_act)))
  expect_equal(colnames(end), colnames(patients_act))

  expect_s3_class(end, "activitylog")

  # Expect "End" activity for each case.
  expect_equal(nrow(end_activities), n_cases(patients_act))
  expect_equal(end_activities[["complete"]], as.POSIXct(c("2017-05-11 14:52:37", "2017-05-12 08:52:24", "2017-05-12 10:46:22"), format = "%Y-%m-%d %H:%M:%S", tz = "UTC"))
  expect_true(all(end_activities[[activity_id(end_activities)]] == "End"))
})

test_that("test add_end_activity on activitylog with arg `label`", {

  load("./testdata/patients_act.rda")

  end <- patients_act %>%
    add_end_activity(label = "end case")

  end_activities <- end %>%
    edeaR::filter_activity("end case") %>%
    arrange(.data[["complete"]])

  # For each case, an additional activity instance is added.
  expect_equal(dim(end), c(nrow(patients_act) + n_cases(patients_act), ncol(patients_act)))
  expect_equal(colnames(end), colnames(patients_act))

  expect_s3_class(end, "activitylog")

  # Expect "end case" activity for each case.
  expect_equal(nrow(end_activities), n_cases(patients_act))
  expect_equal(end_activities[["complete"]], as.POSIXct(c("2017-05-11 14:52:37", "2017-05-12 08:52:24", "2017-05-12 10:46:22"), format = "%Y-%m-%d %H:%M:%S", tz = "UTC"))
  expect_true(all(end_activities[[activity_id(end_activities)]] == "end case"))
})