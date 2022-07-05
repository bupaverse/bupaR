
#### eventlog ####

test_that("test last_n on eventlog", {

  load("./testdata/patients.rda")

  last <- patients %>%
    last_n(n = 2)

  instances <- patients %>%
    filter(!!activity_instance_id_(.) %in% c("11", "12")) %>%
    nrow()

  expect_s3_class(last, "eventlog")
  expect_equal(dim(last), c(instances, ncol(patients)))
  expect_equal(colnames(last), colnames(patients))

  # `last` should contain last 2 activity instances
  expect_equal(last[[activity_instance_id(last)]], c("12", "11"))
  # Ensure that last 2 activity instances are completely present in `last`
  expect_equal(instances, 2)
})

test_that("test last_n on grouped_eventlog", {

  load("./testdata/patients_grouped.rda")

  last <- patients_grouped %>%
    last_n(n = 2)

  instances <- patients_grouped %>%
    filter(!!activity_instance_id_(.) %in% c("5", "6", "10", "11", "12")) %>%
    nrow()

  expect_s3_class(last, "grouped_eventlog")
  # Events: 3 (John Doe) + 3 (Jane Doe) + 1 (George Doe)
  expect_equal(dim(last), c(instances, ncol(patients_grouped)))
  expect_equal(colnames(last), colnames(patients_grouped))

  # `last` should contain last 2 activity instances, per group (patient)
  expect_equal(last[[activity_instance_id(last)]], c("12","10", "10", "11", "5","5","6"))
  # Ensure that last 2 activity instances per group (patient) are completely present in `last`
  expect_equal(instances, 7)
})


#### activitylog ####

test_that("test last_n on activitylog", {

  load("./testdata/patients_act.rda")

  last <- patients_act %>%
    last_n(n = 3)

  # complete is always present and last event per activity instance, so this works too
  ordered <- patients_act %>%
    arrange(.data[["complete"]]) %>%
    tail(n = 3)

  expect_s3_class(last, "activitylog")
  expect_equal(dim(last), c(3, ncol(patients_act)))
  expect_equal(colnames(last), colnames(patients_act))

  # `last` should equal to the last 3 rows of `patients_act`, except for the 7th column (.order)
  expect_equal(last[, -7], ordered[, -7])
})

test_that("test last_n on grouped_activitylog", {

  load("./testdata/patients_act_grouped.rda")
  skip("TODO: rewrite ordered fails")

  last <- patients_act_grouped %>%
    last_n(n = 3)

  # complete is always present and last event per activity instance, so this works too
  ordered <- patients_act_grouped %>%
    slice_max(order_by = .data[["complete"]], n = 3) %>%
    arrange(.data[["complete"]])

  expect_s3_class(last, "grouped_activitylog")
  # Activities: 3 (John Doe) + 3 (Jane Doe) + 1 (George Doe)
  expect_equal(dim(last), c(7, ncol(patients_act_grouped)))
  expect_equal(colnames(last), colnames(patients_act_grouped))

  # `last` should equal to the last 3 rows per group of `patients_act_grouped`, except for the 7th column (.order)
  expect_equal(tibble::as_tibble(last[, -7]), tibble::as_tibble(ordered[, -7]))
})
