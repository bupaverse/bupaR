
test_that("test case_list on eventlog", {

  load("./testdata/patients_loop.rda")

  cases <- patients_loop %>%
    case_list()

  expect_equal(nrow(cases), n_cases(patients_loop))
  expect_equal(cases[["trace"]][1], "check-in,surgery,treatment,surgery,surgery,check-out")   # John Doe's trace
  expect_equal(cases[["trace"]][2], "check-in,surgery,treatment,treatment,check-out")         # Jane Doe's trace
  expect_equal(cases[["trace_id"]], c(1, 2))
})

test_that("test case_list on grouped_eventlog", {

  load("./testdata/patients_loop_grouped.rda")

  cases <- patients_loop_grouped %>%
    case_list()

  expect_equal(nrow(cases), sum(n_cases(patients_loop_grouped)[["n_cases"]]))
  expect_equal(cases[["trace"]][1], "check-in,surgery,treatment,surgery,surgery,check-out")   # John Doe's trace
  expect_equal(cases[["trace"]][2], "check-in,surgery,treatment,treatment,check-out")         # Jane Doe's trace
  expect_equal(cases[["trace_id"]], c(1, 2))
})