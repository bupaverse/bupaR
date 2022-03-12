
test_that("test lifecycle_warning_eventlog", {

  # Needed to display lifecycle warnings
  rlang::local_options(lifecycle_verbosity = "warning")

  input <- 1L

  expect_warning(result1 <- lifecycle_warning_eventlog_test_func(eventlog = input),
                 "(eventlog)|(lifecycle_warning_eventlog_test_func)|(deprecated)|(bupaR 0.5.0.)|(log)")
  expect_warning(result2 <- lifecycle_warning_eventlog_test_func(input),
                 NA)
  expect_equal(result1, input)
  expect_equal(result2, input)
})
