
test_that("test activity unite on eventlog", {

  load("./testdata/patients.rda")

  act <- patients %>%
    act_unite("procedure" = c("treatment", "surgery"))

  expect_true(any(act[[activity_id(act)]] == "procedure"))
  expect_false(any(act[[activity_id(act)]] == "treatment"))
  expect_false(any(act[[activity_id(act)]] == "surgery"))
})

test_that("test activity unite on grouped_eventlog", {

  load("./testdata/patients_grouped.rda")

  act <- patients_grouped %>%
    act_unite("procedure" = c("treatment", "surgery"))

  expect_true(any(act[[activity_id(act)]] == "procedure"))
  expect_false(any(act[[activity_id(act)]] == "treatment"))
  expect_false(any(act[[activity_id(act)]] == "surgery"))
})

test_that("test activity unite fails when supplying unknown level", {

  load("./testdata/patients.rda")

  expect_warning(
    act <- patients %>%
      act_unite("procedure" = c("treatment", "Blood test")),
    "*Unknown levels*")
})