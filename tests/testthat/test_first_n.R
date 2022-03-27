
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
  expect_equal(dim(first), c(4, ncol(patients)))
  expect_equal(colnames(first), colnames(patients))

  # `first` should contain first 2 activity instances
  expect_equal(first[[activity_instance_id(first)]], c("1", "2", "2", "2"))
  # Ensure that first 2 activity instances are completely present in `first`
  expect_equal(instances, 4)
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