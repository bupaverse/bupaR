
#### eventlog ####

test_that("test case_labels on eventlog", {

  load("./testdata/patients.rda")

  labels <- patients %>%
    case_labels()

  expect_equal(labels, unique(patients[[case_id(patients)]]))
})

test_that("test case_labels on eventlog with deprecated eventlog argument", {

  rlang::local_options(lifecycle_verbosity = "warning")

  load("./testdata/patients.rda")

  expect_warning(labels <- case_labels(eventlog = patients),
                 "*eventlog.*case_labels.*deprecated.*bupaR 0.5.0.*log.")

  expect_equal(labels, unique(patients[[case_id(patients)]]))
})

test_that("test case_labels on grouped_eventlog", {

  load("./testdata/patients_grouped.rda")

  labels <- patients_grouped %>%
    case_labels()

  expect_equal(labels, unique(patients_grouped[[case_id(patients_grouped)]]))
})

#### activitylog ####

test_that("test case_labels on activitylog", {

  load("./testdata/patients_act.rda")

  labels <- patients_act %>%
    case_labels()

  expect_equal(labels, unique(patients_act[[case_id(patients_act)]]))
})