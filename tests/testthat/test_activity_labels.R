
#### eventlog ####

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

#### activitylog ####
