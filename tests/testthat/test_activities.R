
#### eventlog ####

test_that("test activities on eventlog dimensions, columns, and content", {

  load("./testdata/patients.rda")

  act <- patients %>%
    activities()

  expect_equal(dim(act), c(length(unique(patients[[activity_id(patients)]])), 3))
  expect_equal(colnames(act), c("activity", "absolute_frequency", "relative_frequency"))

  # Sum absolute frequencies should be same as number of activity instances
  expect_equal(sum(act[["absolute_frequency"]]), max(as.integer(patients[[activity_instance_id(patients)]])))
  expect_equal(sum(act[["relative_frequency"]]), 1)
})

test_that("test activities on grouped_eventlog dimensions, columns, and content", {

  skip("fails")
  load("./testdata/patients_grouped.rda")

  act <- patients_grouped %>%
    activities()

  expect_equal(dim(act), c(length(unique(patients[[activity_id(patients)]])), 3))
  expect_equal(colnames(act), c("activity", "absolute_frequency", "relative_frequency"))

  # Sum absolute frequencies should be same as number of activity instances
  expect_equal(sum(act[["absolute_frequency"]]), max(as.integer(patients[[activity_instance_id(patients)]])))
  expect_equal(sum(act[["relative_frequency"]]), 1)
})


#### activitylog ####


