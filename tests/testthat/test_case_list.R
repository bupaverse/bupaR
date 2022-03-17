
#### eventlog ####

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

test_that("test case_list on eventlog with .keep_trace_list = TRUE", {

  load("./testdata/patients_loop.rda")

  cases <- patients_loop %>%
    case_list(.keep_trace_list = TRUE)

  expect_equal(dim(cases), c(n_cases(patients_loop), 4))
  expect_equal(colnames(cases), c("patient", "trace_list", "trace", "trace_id"))

  expect_type(cases$trace_list, "list")
  expect_type(cases$trace_list[[1]], "character")
  expect_equal(cases$trace_list[1], list(c("check-in", "surgery", "treatment", "surgery", "surgery", "check-out")))  # John Doe's trace
  expect_equal(cases$trace_list[2], list(c("check-in", "surgery", "treatment", "treatment", "check-out")))           # Jane Doe's trace
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

#### activitylog ####

test_that("test case_list on actvitylog", {

  load("./testdata/patients_act.rda")

  cases <- patients_act %>%
    case_list()

  expect_equal(dim(cases), c(n_cases(patients_act), 3))
  expect_equal(colnames(cases), c("patient", "trace", "trace_id"))

  expect_equal(cases[["trace"]][1], "check-in,surgery,treatment,surgery,surgery,check-out")   # John Doe's trace
  expect_equal(cases[["trace"]][2], "check-in,surgery,treatment,treatment,check-out")         # Jane Doe's trace
  expect_equal(cases[["trace"]][3], "register")                                               # George Doe's trace
  expect_equal(cases[["trace_id"]], c(1, 2, 3))
})

test_that("test case_list on activitylog with .keep_trace_list = TRUE", {

  load("./testdata/patients_act.rda")

  cases <- patients_act %>%
    case_list(.keep_trace_list = TRUE)

  expect_equal(dim(cases), c(n_cases(patients_act), 4))
  expect_equal(colnames(cases), c("patient", "trace_list", "trace", "trace_id"))

  expect_type(cases$trace_list, "list")
  expect_type(cases$trace_list[[1]], "character")
  expect_equal(cases[["trace"]][1], "check-in,surgery,treatment,surgery,surgery,check-out")   # John Doe's trace
  expect_equal(cases[["trace"]][2], "check-in,surgery,treatment,treatment,check-out")         # Jane Doe's trace
  expect_equal(cases[["trace"]][3], "register")                                               # George Doe's trace
  expect_equal(cases[["trace_id"]], c(1, 2, 3))
})

test_that("test case_list on grouped_activitylog", {

  skip("grouped_activitylog not fully functional yet")
  load("./testdata/patients_act_grouped.rda")

  cases <- patients_act_grouped %>%
    case_list()

  expect_equal(dim(cases), c(sum(n_cases(patients_act_grouped)[["n_cases"]]), 3))
  expect_equal(colnames(cases), c("patient", "trace", "trace_id"))

  expect_equal(cases[["trace"]][1], "check-in,surgery,treatment,surgery,surgery,check-out")   # John Doe's trace
  expect_equal(cases[["trace"]][2], "check-in,surgery,treatment,treatment,check-out")         # Jane Doe's trace
  expect_equal(cases[["trace"]][3], "register")                                               # George Doe's trace
  expect_equal(cases[["trace_id"]], c(1, 2, 3))
})