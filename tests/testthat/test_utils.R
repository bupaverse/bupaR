
test_that("test lifecycle_warning_eventlog", {

  # Needed to display lifecycle warnings
  rlang::local_options(lifecycle_verbosity = "warning")

  load("./testdata/patients.rda")

  # Works only on exported functions.
  expect_warning(result1 <- case_labels(eventlog = patients),
                 "(eventlog)|(case_labels)|(deprecated)|(bupaR 0.5.0.)|(log)")
  expect_warning(result2 <- case_labels(patients),
                 NA)
  expect_equal(result1, unique(patients[[case_id(patients)]]))
  expect_equal(result2, unique(patients[[case_id(patients)]]))
})
