
test_that("test lifecycle_warning_eventlog", {

  # Needed to display lifecycle warnings
  rlang::local_options(lifecycle_verbosity = "warning")

  load("./testdata/patients.rda")

  # Works only on exported functions.
  expect_warning(result2 <- case_labels(patients),
                 NA)
  expect_equal(result2, unique(patients[[case_id(patients)]]))
})
