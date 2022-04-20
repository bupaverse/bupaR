
#### eventlog ####

test_that("test lifecycles on eventlog", {

  load("./testdata/patients.rda")

  lifecycles <- patients %>%
    lifecycles()

  expect_s3_class(lifecycles, "tbl_df")
  expect_equal(dim(lifecycles), c(length(lifecycle_labels(patients)), 3))
  expect_equal(colnames(lifecycles), c("status", "absolute_frequency", "relative_frequency"))

  # Sum absolute frequencies should be same as number of events
  expect_equal(sum(lifecycles[["absolute_frequency"]]), n_events(patients))
  expect_equal(sum(lifecycles[["relative_frequency"]]), 1)
})

test_that("test lifecycles on grouped_eventlog", {

  load("./testdata/patients_grouped.rda")

  lifecycles <- patients_grouped %>%
    lifecycles()

  expect_s3_class(lifecycles, c("grouped_df", "tbl_df"))
  # 7 life cycles: 1 (George Doe) + 3 (Jane Doe) + 3 (John Doe)
  expect_equal(dim(lifecycles), c(7, 4))
  expect_equal(colnames(lifecycles), c("patient", "status", "absolute_frequency", "relative_frequency"))

  # Sum absolute frequencies should be same as number of events
  expect_equal(sum(lifecycles[["absolute_frequency"]]), sum(n_events(patients_grouped)[["n_events"]]))
  # Sum of relative frequencies should be same as number of patients
  expect_equal(sum(lifecycles[["relative_frequency"]]), sum(n_cases(patients_grouped)[["n_cases"]]))
})


#### activitylog ####

test_that("test lifecycles on activitylog", {

  load("./testdata/patients_act.rda")

  lifecycles <- patients_act %>%
    lifecycles()

  expect_s3_class(lifecycles, "tbl_df")
  expect_equal(dim(lifecycles), c(length(lifecycle_labels(patients_act)), 3))
  expect_equal(colnames(lifecycles), c("lifecycle_id", "absolute_frequency", "relative_frequency"))

  # Sum absolute frequencies should be same as number of events
  expect_equal(sum(lifecycles[["absolute_frequency"]]), n_events(patients_act))
  expect_equal(sum(lifecycles[["relative_frequency"]]), 1)
})

test_that("test lifecycles on grouped_activitylog", {

  load("./testdata/patients_act_grouped.rda")

  lifecycles <- patients_act_grouped %>%
    lifecycles()

  expect_s3_class(lifecycles, c("grouped_df", "tbl_df"))
  # 7 life cycles: 1 (George Doe) + 3 (Jane Doe) + 3 (John Doe)
  expect_equal(dim(lifecycles), c(7, 4))
  expect_equal(colnames(lifecycles), c("patient", "lifecycle_id", "absolute_frequency", "relative_frequency"))

  # Sum absolute frequencies should be same as number of events
  expect_equal(sum(lifecycles[["absolute_frequency"]]), sum(n_events(patients_act_grouped)[["n_events"]]))
  expect_equal(sum(lifecycles[["relative_frequency"]]), sum(n_cases(patients_act_grouped)[["n_cases"]]))
})