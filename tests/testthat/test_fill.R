
test_that("test fill on eventlog with default .direction", {

  load("./testdata/patients_fill_na.rda")
  load("./testdata/patients_fill_na_df.rda")

  log <- patients_fill_na %>%
    fill(!!resource_id_(.))

  truth <- patients_fill_na_df %>%
    fill(resource)

  expect_s3_class(log, "eventlog")

  expect_false(any(is.na(log[[resource_id(log)]])))
  expect_equal(log[[resource_id(log)]], truth[["resource"]])
})

test_that("test fill on eventlog with .direction = 'downup'", {

  load("./testdata/patients_fill_na.rda")
  load("./testdata/patients_fill_na_df.rda")

  log <- patients_fill_na %>%
    fill(!!resource_id_(.), .direction = "downup")

  truth <- patients_fill_na_df %>%
    fill(resource, .direction = "downup")

  expect_s3_class(log, "eventlog")

  expect_false(any(is.na(log[[resource_id(log)]])))
  expect_equal(log[[resource_id(log)]], truth[["resource"]])
})

test_that("test fill on grouped_eventlog with default .direction", {

  load("./testdata/patients_fill_na_grouped.rda")
  load("./testdata/patients_fill_na_grouped_df.rda")

  log <- patients_fill_na_grouped %>%
    fill(!!resource_id_(.))

  truth <- patients_fill_na_grouped_df %>%
    fill(resource)

  expect_s3_class(log, "grouped_eventlog")

  # Expect 10th element (first Samanta of Jane Doe) to be NA.
  expect_true(is.na(log[[resource_id(log)]][10]))
  expect_equal(log[[resource_id(log)]], truth[["resource"]])
  expect_equal(group_vars(log), group_vars(patients_fill_na_grouped))
})

test_that("test fill on grouped_eventlog with .direction = 'downup'", {

  load("./testdata/patients_fill_na_grouped.rda")
  load("./testdata/patients_fill_na_grouped_df.rda")

  log <- patients_fill_na_grouped %>%
    fill(!!resource_id_(.), .direction = "downup")

  truth <- patients_fill_na_grouped_df %>%
    fill(resource, .direction = "downup")

  expect_s3_class(log, "grouped_eventlog")

  expect_false(any(is.na(log[[resource_id(log)]])))
  expect_equal(log[[resource_id(log)]], truth[["resource"]])
  expect_equal(group_vars(log), group_vars(patients_fill_na_grouped))
})