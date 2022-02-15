
test_that("test case_list on eventlog", {

  load("./testdata/patients_loop.rda")

  cases <- patients_loop %>%
    case_list()

  expect_equal(dim(cases), c(n_cases(patients_loop), 3))
  expect_equal(colnames(cases), c("patient", "trace", "trace_id"))

  expect_equal(cases[["trace"]][1], "check-in,surgery,treatment,surgery,surgery,check-out")   # John Doe's trace
  expect_equal(cases[["trace"]][2], "check-in,surgery,treatment,treatment,check-out")         # Jane Doe's trace
  expect_equal(cases[["trace_id"]], c(1, 2))
})

test_that("test case_list on grouped_eventlog", {

  load("./testdata/patients_loop_grouped.rda")

  cases <- patients_loop_grouped %>%
    case_list()

  expect_equal(dim(cases), c(sum(n_cases(patients_loop_grouped)[["n_cases"]]), 3))
  expect_equal(colnames(cases), c("patient", "trace", "trace_id"))

  expect_equal(cases[["trace"]][1], "check-in,surgery,treatment,surgery,surgery,check-out")   # John Doe's trace
  expect_equal(cases[["trace"]][2], "check-in,surgery,treatment,treatment,check-out")         # Jane Doe's trace
  expect_equal(cases[["trace_id"]], c(1, 2))
})