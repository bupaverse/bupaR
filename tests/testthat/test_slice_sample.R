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

  load("./testdata/patients.rda")

  # Sample takes 2 out of 3 patients
  sample <- patients %>%
    slice_sample(prop = 0.7)

  instances <- patients[patients[[case_id(patients)]] %in% sample[[case_id(patients)]],]

  # Ensure output class
  expect_s3_class(sample, "eventlog")
  # Ensure that 2 cases are selected
  expect_equal(length(unique(sample[[case_id(patients)]])), 2)
  # Ensure that selected cases are completely present in `sample`
  expect_equal(nrow(sample), nrow(instances))
  expect_equal(colnames(sample), colnames(patients))


})

test_that("test slice_sample on grouped_eventlog", {

  set.seed(18)

  # Sample takes: check-in (Jane Doe), check-out (Jane Doe), register (George Doe), surgery (Jane Doe), treatment (Jane Doe) (fixed seed)
  eventdataR::patients %>%
  	mutate(group = as.numeric(patient) > 200) %>%
    group_by(group) -> grouped_data

  n_groups <- grouped_data %>% summarize %>% nrow()

  sample <- grouped_data %>%
    slice_sample(n = 1)

  instances <- grouped_data[grouped_data[[case_id(grouped_data)]] %in% sample[[case_id(grouped_data)]],]

  # Ensure output class
  expect_s3_class(sample, "grouped_eventlog")
  # Ensure that 1 x ngroups cases are selected
  expect_equal(length(unique(sample[[case_id(grouped_data)]])), n_groups)
  # Ensure that selected cases are completely present in `sample`
  expect_equal(nrow(sample), nrow(instances))
  expect_equal(sort(colnames(sample)), sort(colnames(grouped_data)))
})

test_that("test slice_sample on grouped_eventlog with n > n_cases of a group", {
	skip("problem with grouped eventlogs")
  eventdataR::patients %>%
  	mutate(group = as.numeric(patient) > 200) %>%
  	group_by(group) -> grouped_data

  expect_error(
    sample <- grouped_data %>%
      slice_sample(n = 2001),
    ".*cannot take a sample larger than the population when 'replace = FALSE'*")
})

#### activitylog ####

test_that("test slice_sample on activitylog", {


	load("./testdata/patients_act.rda")

	# Sample takes 2 out of 3 patients
	sample <- patients_act %>%
		slice_sample(n = 2)

	instances <- patients_act[patients_act[[case_id(patients_act)]] %in% sample[[case_id(patients_act)]],]

	# Ensure output class
	expect_s3_class(sample, "activitylog")
	# Ensure that 2 cases are selected
	expect_equal(length(unique(sample[[case_id(patients_act)]])), 2)
	# Ensure that selected cases are completely present in `sample`
	expect_equal(nrow(sample), nrow(instances))
	expect_equal(colnames(sample), colnames(patients_act))

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

	eventdataR::patients_act %>%
		mutate(group = as.numeric(patient) > 200) %>%
		group_by(group) -> grouped_data

	n_groups <- grouped_data %>% summarize %>% nrow()

	sample <- grouped_data %>%
		slice_sample(n = 1)

	instances <- grouped_data[grouped_data[[case_id(grouped_data)]] %in% sample[[case_id(grouped_data)]],]

	# Ensure output class
	expect_s3_class(sample, "grouped_activitylog")
	# Ensure that 1 x ngroups cases are selected
	expect_equal(length(unique(sample[[case_id(grouped_data)]])), n_groups)
	# Ensure that selected cases are completely present in `sample`
	expect_equal(nrow(sample), nrow(instances))
	expect_equal(sort(colnames(sample)), sort(colnames(grouped_data)))
})
