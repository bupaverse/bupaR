#### eventlog ####

test_that("test slice_sample on eventlog", {

  set.seed(1000)

  load("./testdata/patients.rda")

  # Sample takes Jane Doe and George Doe (fixed seed)
  sample <- patients %>%
    slice_sample(n = 2)

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

test_that("test slice_sample on eventlog with n > n_cases", {

  set.seed(1000)

  load("./testdata/patients.rda")

  expect_error(
    sample <- patients %>%
      slice_sample(n = 4),
    ".*Cannot take a sample (.*) larger than the population (.*) when 'replace = FALSE'.*")
})

test_that("test slice_sample on eventlog with argument prop", {

  set.seed(1000)

  load("./testdata/patients.rda")

  # Sample takes Jane Doe and George Doe (fixed seed)
  sample <- patients %>%
    slice_sample(prop = 0.7)

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

test_that("test slice_sample on grouped_eventlog", {

  set.seed(18)

  load("./testdata/patients.rda")

  # Sample takes: check-in (Jane Doe), check-out (Jane Doe), register (George Doe), surgery (Jane Doe), treatment (Jane Doe) (fixed seed)
  sample <- patients %>%
    group_by(.data[[activity_id(.)]]) %>%
    slice_sample(n = 1)

  instances <- patients %>%
    filter(.data[[case_id(.)]] %in% c("Jane Doe", "George Doe")) %>%
    pull(activity_instance)

  expect_s3_class(sample, "grouped_eventlog")
  # Number of activity instances: check-in (1) + check-out (1) + register (1) + surgery (2) + treatment (5) = 10
  expect_equal(dim(sample), c(length(instances), ncol(patients)))
  expect_equal(colnames(sample), c("activity", "patient", "timestamp", "status", "activity_instance", "resource", ".order"))

  # `sample` should contain the activity instances from Jane Doe and George Doe
  expect_equal(sample[[activity_instance_id(sample)]], instances)
  # Ensure that all activity instances are completely present in `sample`
  expect_equal(length(instances), 10L)
})

test_that("test slice_sample on grouped_eventlog with n > n_cases of a group", {

  set.seed(1000)

  load("./testdata/patients_grouped.rda")

  expect_error(
    sample <- patients_grouped %>%
      slice_sample(n = 4),
    ".*cannot take a sample larger than the population when 'replace = FALSE'*")
})

#### activitylog ####

test_that("test slice_sample on activitylog", {

  set.seed(1000)

  load("./testdata/patients_act.rda")

  # Sample takes Jane Doe and George Doe (fixed seed)
  # Add row number to validate rows
  sample <- patients_act %>%
    mutate(id = dplyr::row_number()) %>%
    slice_sample(n = 2)

  instances <- patients_act %>%
    mutate(id = dplyr::row_number()) %>%
    filter(.data[[case_id(.)]] %in% c("Jane Doe", "George Doe")) %>%
    pull(id)

  expect_s3_class(sample, "activitylog")
  # Number of activities: Jane Doe (5) + George Doe (1) = 6
  # Number of columns: ncol(patients_act) + 1 (id column to validate)
  expect_equal(dim(sample), c(length(instances), ncol(patients_act) + 1))
  expect_equal(colnames(sample), c(colnames(patients_act), "id"))

  # `sample` should contain the activities from Jane Doe and George Doe
  expect_equal(sample[["id"]], instances)
  # Ensure that Jane Doe (5) + George Doe (1) = 6 are completely present in `sample`
  expect_equal(length(instances), 6L)
})

test_that("test slice_sample on activitylog with n > n_cases", {

  set.seed(1000)

  load("./testdata/patients_act.rda")

  expect_error(
    sample <- patients_act %>%
      slice_sample(n = 4),
    ".*Cannot take a sample (.*) larger than the population (.*) when 'replace = FALSE'.*")
})

test_that("test slice_sample on grouped_activitylog", {

  set.seed(18)

  load("./testdata/patients_act.rda")

  # Sample takes: check-in (Jane Doe), check-out (Jane Doe), register (George Doe), surgery (Jane Doe), treatment (Jane Doe) (fixed seed)
  # Add row number to validate rows
  sample <- patients_act %>%
    mutate(id = dplyr::row_number()) %>%
    group_by(.data[[activity_id(.)]]) %>%
    slice_sample(n = 1)

  instances <- patients_act %>%
    mutate(id = dplyr::row_number()) %>%
    filter(.data[[case_id(.)]] %in% c("Jane Doe", "George Doe")) %>%
    pull(id)

  expect_s3_class(sample, "grouped_activitylog")
  # Number of activities: Jane Doe (5) + George Doe (1) = 6
  # Number of columns: ncol(patients_act) + 1 (id column to validate)
  expect_equal(dim(sample), c(length(instances), ncol(patients_act) + 1))
  expect_equal(colnames(sample), c("activity", "patient", "schedule", "start", "complete", "resource", ".order", "id"))

  # `sample` should contain the activities from Jane Doe and George Doe
  expect_equal(sample[["id"]], instances)
  # Ensure that Jane Doe (5) + George Doe (1) = 6 are completely present in `sample`
  expect_equal(length(instances), 6L)
})