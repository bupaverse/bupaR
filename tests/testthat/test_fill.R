
test_that("test fill on eventlog with default .direction", {

  load("./testdata/patients_fill_na.rda")

  log <- patients_fill_na %>%
    fill(resource_id(.))

  expect_s3_class(log, "eventlog")

  expect_false(any(is.na(log[[resource_id(log)]])))
})

test_that("test fill on eventlog with .direction = 'down'", {

  load("./testdata/patients_fill_na.rda")

  log <- patients_fill_na %>%
    fill(resource_id(.), .direction = "down")

  expect_s3_class(log, "eventlog")

  expect_false(any(is.na(log[[resource_id(log)]])))
})

test_that("test fill on grouped_eventlog with default .direction", {

  load("./testdata/patients_fill_na_grouped.rda")

  log <- patients_fill_na_grouped %>%
    fill(resource_id(.))

  expect_s3_class(log, "grouped_eventlog")

  expect_false(any(is.na(log[[resource_id(log)]])))
  expect_equal(group_vars(log), group_vars(patients_fill_na_grouped))
})