
test_that("test fill on eventlog without .direction", {

  load("./testdata/patients_fill_na.rda")

  patients_fill_na <- patients_fill_na %>%
    fill(resource_id(.))

  expect_s3_class(patients_fill_na, "eventlog")

  print(patients_fill_na)
  expect_false(any(is.na(patients_fill_na[[resource_id(patients_fill_na)]])))
})

test_that("test fill on eventlog with .direction = 'down'", {

  load("./testdata/patients_fill_na.rda")

  patients_fill_na <- patients_fill_na %>%
    fill(resource_id(.), .direction = "down")

  expect_s3_class(patients_fill_na, "eventlog")

  print(patients_fill_na)
  expect_false(any(is.na(patients_fill_na[[resource_id(patients_fill_na)]])))
})