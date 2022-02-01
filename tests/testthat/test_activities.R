
#### activities ####

test_that("test activities on eventlog dimensions, columns, and content", {

  load("./testdata/patients.rda")

  act <- patients %>%
    activities()

  expect_equal(dim(act), c(4, 3))
  expect_equal(colnames(act), c("activity", "absolute_frequency", "relative_frequency"))

  # Sum absolute frequencies should be same as number of activity instances
  expect_equal(sum(act[["absolute_frequency"]]), as.integer(max(patients[[activity_instance_id(patients)]])))
  expect_equal(sum(act[["relative_frequency"]]), 1)
})

test_that("test activities on grouped_eventlog dimensions, columns, and content", {

  load("./testdata/patients_grouped.rda")

  act <- patients_grouped %>%
    activities()

  expect_equal(dim(act), c(4, 3))
  expect_equal(colnames(act), c("activity", "absolute_frequency", "relative_frequency"))

  # Sum absolute frequencies should be same as number of activity instances
  expect_equal(sum(act[["absolute_frequency"]]), as.integer(max(patients[[activity_instance_id(patients)]])))
  expect_equal(sum(act[["relative_frequency"]]), 1)
})


#### activity_labels ####

test_that("test activity_labels on eventlog", {

  load("./testdata/patients.rda")

  act <- patients %>%
    activity_labels()

  expect_equal(act, unique(patients[[activity_id(patients)]]))
})

test_that("test activity_labels on grouped_eventlog", {

  load("./testdata/patients_grouped.rda")

  act <- patients_grouped %>%
    activity_labels()

  expect_equal(act, unique(patients_grouped[[activity_id(patients_grouped)]]))
})