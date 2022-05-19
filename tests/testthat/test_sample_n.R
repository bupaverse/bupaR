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
  expect_equal(length(instances), 10L)
})

test_that("test sample_n on eventlog with size > n_cases", {

  set.seed(1000)

  load("./testdata/patients.rda")

  expect_error(
    sample <- patients %>%
    sample_n(size = 4),
    ".*Size parameter.*larger than number of cases.*replace = T.*")
})

test_that("test sample_n on grouped_eventlog", {

  set.seed(1000)

  load("./testdata/patients.rda")

  # Sample takes: check-in (Jane Doe), check-out (Jane Doe), register (George Doe), surgery (Jane Doe), treatment (John Doe) (fixed seed)
  sample <- patients %>%
    group_by(.data[[activity_id(.)]]) %>%
    sample_n(size = 1)

  instances <- patients %>%
    filter(.data[[activity_instance_id(.)]] %in% c("3", "7", "8", "11", "12")) %>%
    pull(activity_instance)

  expect_s3_class(sample, "grouped_eventlog")
  # Number of activity instances: check-in (1) + check-out (1) + register (1) + surgery (2) + treatment (2) = 7
  expect_equal(dim(sample), c(length(instances), ncol(patients)))
  expect_equal(colnames(sample), c("activity", "patient", "timestamp", "status", "activity_instance", "resource", ".order"))

  # `sample` should contain the activity instances from Jane Doe and George Doe
  expect_equal(stringi::stri_sort(sample[[activity_instance_id(sample)]], numeric = TRUE), instances)
  # Ensure that all activity instances are completely present in `sample`
  expect_equal(length(instances), 7L)
})

#### activitylog ####

test_that("test sample_n on activitylog", {

  set.seed(1000)

  load("./testdata/patients_act.rda")

  sample <- patients_act %>%
    sample_n(size = 2)

  print(sample)
})

test_that("test sample_n on activitylog with size > n_cases", {

  set.seed(1000)

  load("./testdata/patients_act.rda")

  expect_error(
    sample <- patients_act %>%
      sample_n(size = 4),
    ".*Size parameter.*larger than number of cases.*replace = T.*")
})

test_that("test sample_n on grouped_activitylog", {

  set.seed(1000)

  load("./testdata/patients_act.rda")

  # Sample takes: ... (fixed seed) => treatment is sampled twice, not sure why...
  sample <- patients_act %>%
    mutate(id = dplyr::row_number()) %>%
    group_by(.data[[activity_id(.)]]) %>%
    sample_n(size = 1)

  print(sample)

  # TODO: tests need to be updated!

  instances <- patients_act %>%
    mutate(id = dplyr::row_number()) %>%
    filter(.data[["id"]] %in% c(7, 8, 9, 10, 11, 12)) %>%
    pull(id)

  expect_s3_class(sample, "grouped_activitylog")
  # Number of activity instances:
  expect_equal(dim(sample), c(length(instances), ncol(patients_act)))
  expect_equal(colnames(sample), c("activity", "patient", "timestamp", "status", "activity_instance", "resource", ".order"))

  # `sample` should contain the activity instances from Jane Doe and George Doe
  #expect_equal(stringi::stri_sort(sample[[activity_instance_id(sample)]], numeric = TRUE), instances)
  # Ensure that all activity instances are completely present in `sample`
  expect_equal(length(instances), 7L)
})