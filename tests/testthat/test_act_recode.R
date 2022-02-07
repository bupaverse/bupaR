
test_that("test activity recode on eventlog", {

  load("./testdata/patients.rda")

  act <- patients %>%
    act_recode("registration" = "check-in",
               "discharge" = "check-out")

  expect_true(any(act[[activity_id(act)]] == "registration"))
  expect_true(any(act[[activity_id(act)]] == "discharge"))
  expect_false(any(act[[activity_id(act)]] == "check-in"))
  expect_false(any(act[[activity_id(act)]] == "check-out"))
})

test_that("test activity recode on grouped_eventlog", {

  load("./testdata/patients_grouped.rda")

  act <- patients_grouped %>%
    act_recode("registration" = "check-in",
               "discharge" = "check-out")

  expect_true(any(act[[activity_id(act)]] == "registration"))
  expect_true(any(act[[activity_id(act)]] == "discharge"))
  expect_false(any(act[[activity_id(act)]] == "check-in"))
  expect_false(any(act[[activity_id(act)]] == "check-out"))
})

test_that("test activity recode fails when supplying unknown level", {

  load("./testdata/patients.rda")

  expect_warning(
    act <- patients %>%
      act_recode("Lab exam" = "Blood test"),
    "*Unknown levels*")
})