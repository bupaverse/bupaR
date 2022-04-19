
#### eventlog ####

test_that("test first_n on eventlog", {

  load("./testdata/patients.rda")

  first <- patients %>%
    first_n(n = 2)

  instances <- patients %>%
    filter(!!activity_instance_id_(.) %in% c("1", "2")) %>%
    nrow()

  expect_s3_class(first, "eventlog")
  # 2nd activity contains 3 events, so 4 events in total
  expect_equal(dim(first), c(instances, ncol(patients)))
  expect_equal(colnames(first), colnames(patients))

  # `first` should contain first 2 activity instances
  expect_equal(first[[activity_instance_id(first)]], c("1", "2", "2", "2"))
  # Ensure that first 2 activity instances are completely present in `first`
  expect_equal(instances, 4)
})

test_that("test first_n on grouped_eventlog", {

  load("./testdata/patients_grouped.rda")

  first <- patients_grouped %>%
    first_n(n = 2)

  instances <- patients_grouped %>%
    filter(!!activity_instance_id_(.) %in% c("1", "2", "7", "8", "12")) %>%
    nrow()

  expect_s3_class(first, "grouped_eventlog")
  # Events: 4 (John Doe) + 3 (Jane Doe) + 1 (George Doe)
  expect_equal(dim(first), c(instances, ncol(patients_grouped)))
  expect_equal(colnames(first), colnames(patients_grouped))

  # `first` should contain first 2 activity instances, per group (patient)
  expect_equal(first[[activity_instance_id(first)]], c("1", "2", "2", "2", "7", "8", "8", "12"))
  # Ensure that first 2 activity instances per group (patient) are completely present in `first`
  expect_equal(instances, 8)
})


#### activitylog ####

test_that("test first_n on activitylog", {

  load("./testdata/patients_act.rda")

  first <- patients_act %>%
    first_n(n = 3)

  expect_s3_class(first, "activitylog")
  expect_equal(dim(first), c(3, ncol(patients_act)))
  expect_equal(colnames(first), colnames(patients_act))

  # `first` should equal to the first 3 rows of `patients_act`
  expect_equal(first, head(patients_act, n = 3))
})

test_that("test first_n on grouped_activitylog", {

  load("./testdata/patients_act_grouped.rda")

  first <- patients_act_grouped %>%
    first_n(n = 3)

  # complete is always present and last event per activity instance, so this works too
  ordered <- patients_act_grouped %>%
    slice_min(order_by = .data[["complete"]], n = 3) %>%
    arrange(.data[["complete"]])

  expect_s3_class(first, "grouped_activitylog")
  # Activities: 3 (John Doe) + 3 (Jane Doe) + 1 (George Doe)
  expect_equal(dim(first), c(7, ncol(patients_act_grouped)))
  expect_equal(colnames(first), colnames(patients_act_grouped))

  # `first` should equal to the first 3 rows per group of `patients_act_grouped`, except for the 7th column (.order)
  expect_equal(tibble::as_tibble(first[, -7]), tibble::as_tibble(ordered[, -7]))
})