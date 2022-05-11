rlang
#### eventlog ####

test_that("test sample_n on eventlog", {

  set.seed(1000)

  load("./testdata/patients.rda")

  # Sample takes Jane Doe and George Doe (fixed seed)
  sample <- patients %>%
    sample_n(size = 2)

  instances <- patients %>%
    filter(.data[[case_id(.)]] %in% c("Jane Doe", "George Doe")) %>%
    pull(activity_instance)

  expect_s3_class(sample, "eventlog")
  # Number of activity instances: Jane Doe (9) + George Doe (1) = 10
  expect_equal(dim(sample), c(length(instances), ncol(patients)))
  expect_equal(colnames(sample), colnames(patients))

  # `sample` should contain the activity instances from Jane Doe and George Doe
  expect_equal(sample[[activity_instance_id(sample)]], instances)
  # Ensure that Jane Doe (9) + George Doe (1) = 10 are completely present in `sample`
  expect_equal(length(instances), 10)
})

test_that("test sample_n on eventlog with size > n_cases", {

  set.seed(1000)

  load("./testdata/patients.rda")

  sample <- patients %>%
    sample_n(size = 4)
})

#### activitylog ####

test_that("test sample_n on activitylog", {

  load("./testdata/patients_act.rda")

  sample <- patients_act %>%
    bupaR::sample_n(size = 2)

  print(sample)
})