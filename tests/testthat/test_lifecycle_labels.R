
#### eventlog ####

test_that("test lifecycle_labels on eventlog", {

  load("./testdata/patients.rda")

  labels <- patients %>%
    lifecycle_labels()

  expect_is(labels, "factor")
  expect_equal(labels, factor(c("complete", "schedule", "start"), levels = c("complete", "schedule", "start")))
})

test_that("test lifecycle_labels on grouped_eventlog", {

  load("./testdata/patients_grouped.rda")

  labels <- patients_grouped %>%
    lifecycle_labels()

  expect_is(labels, "factor")
  expect_equal(labels, factor(c("complete", "schedule", "start"), levels = c("complete", "schedule", "start")))
})


#### activitylog ####

test_that("test lifecycle_labels on activitylog", {

  load("./testdata/patients_act.rda")

  labels <- patients_act %>%
    lifecycle_labels()

  expect_is(labels, "factor")
  expect_equal(labels, factor(c("complete", "schedule", "start"), levels = c("complete", "schedule", "start")))
})

test_that("test lifecycle_labels on grouped_activitylog", {

  load("./testdata/patients_act_grouped.rda")

  labels <- patients_act_grouped %>%
    lifecycle_labels()

  expect_is(labels, "factor")
  expect_equal(labels, factor(c("complete", "schedule", "start"), levels = c("complete", "schedule", "start")))
})