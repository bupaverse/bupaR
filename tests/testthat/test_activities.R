
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

  load("./testdata/patients_grouped.rda")

  act <- patients_grouped %>%
    activities()

  # 9 activities: 1 (George Doe) + 4 (Jane Doe) + 4 (John Doe)
  expect_equal(dim(act), c(9, 4))
  expect_equal(colnames(act), c("patient", "activity", "absolute_frequency", "relative_frequency"))

  # Sum absolute frequencies should be same as number of activity instances
  expect_equal(sum(act[["absolute_frequency"]]), max(as.integer(patients_grouped[[activity_instance_id(patients_grouped)]])))
  # sum of relative frequencies should be same as number of patients
  expect_equal(sum(act[["relative_frequency"]]), sum(n_cases(patients_grouped)[["n_cases"]]))
})


#### activitylog ####


