
context("Eventlog parsing")

read_testdata <- function () {
  read.csv("./testdata/patients.csv") %>%
    mutate(timestamp = as.POSIXct(timestamp, format = "%Y-%m-%d %H:%M:%S", tz = "UTC"))
}
test_that("test eventlog without error", {

	patients <- read_testdata()

	expect_error(
		patientslog <- patients %>%
			eventlog(case_id = "patient",
					 activity_id = "activity",
					 activity_instance_id = "activity_instance",
					 lifecycle_id = "status",
					 timestamp = "timestamp",
					 resource_id = "resource"),
	NA)

})
test_that("test eventlog without warning", {

	patients <- read_testdata()

	expect_warning(
		patientslog <- patients %>%
			eventlog(case_id = "patient",
					 activity_id = "activity",
					 activity_instance_id = "activity_instance",
					 lifecycle_id = "status",
					 timestamp = "timestamp",
					 resource_id = "resource"),
		NA)

})
test_that("test eventlog correctly parsing dataset", {

  patients <- read_testdata()
  patientslog <- patients %>%
    eventlog(case_id = "patient",
             activity_id = "activity",
             activity_instance_id = "activity_instance",
             lifecycle_id = "status",
             timestamp = "timestamp",
             resource_id = "resource")

  expect_s3_class(patientslog, "eventlog")
  expect_equal(nrow(patients), nrow(patientslog))
})

test_that("test eventlog multiple value arg", {

  patients_multicase <- read.csv("./testdata/patients_multicase.csv") %>%
    mutate(timestamp = as.POSIXct(timestamp, format = "%Y-%m-%d %H:%M:%S", tz = "UTC"))
  patientslog <- patients_multicase %>%
    eventlog(case_id = c("patient_firstname", "patient_lastname"),
             activity_id = "activity",
             activity_instance_id = "activity_instance",
             lifecycle_id = "status",
             timestamp = "timestamp",
             resource_id = "resource")

  expect_equal(case_id(patientslog), "patient_firstname_patient_lastname")
  expect_equal(patientslog[[case_id(patientslog)]][1], "John_Doe")
})

test_that("test eventlog timestamp no POSIXct arg", {

  patients_noPOSIXct <- read.csv("./testdata/patients.csv")

  expect_error(
    patientslog <- patients_noPOSIXct %>%
      eventlog(case_id = "patient",
               activity_id = "activity",
               activity_instance_id = "activity_instance",
               lifecycle_id = "status",
               timestamp = "timestamp",
               resource_id = "resource"),
    "*POSIXct*")
})

test_that("test eventlog timestamp Date arg", {

	patients_noPOSIXct <- read.csv("./testdata/patients.csv") %>%
		mutate(timestamp = as.POSIXct(timestamp, format = "%Y-%m-%d", tz = "UTC"))

	expect_error(
		patientslog <- patients_noPOSIXct %>%
			eventlog(case_id = "patient",
					 activity_id = "activity",
					 activity_instance_id = "activity_instance",
					 lifecycle_id = "status",
					 timestamp = "timestamp",
					 resource_id = "resource"),
		NA)
})

test_that("test eventlog order arg 'auto'", {

  patientslog <- read_testdata() %>%
    eventlog(case_id = "patient",
             activity_id = "activity",
             activity_instance_id = "activity_instance",
             lifecycle_id = "status",
             timestamp = "timestamp",
             resource_id = "resource",
             order = "auto")

  expect_equal(patientslog$.order, seq_len(nrow(patientslog)))
})

test_that("test eventlog order arg 'alphabetical'", {

  patients_ordering <- read.csv("./testdata/patients_ordering.csv") %>%
    mutate(timestamp = as.POSIXct(timestamp, format = "%Y-%m-%d %H:%M:%S", tz = "UTC"))

  patientslog <- patients_ordering %>%
    eventlog(case_id = "patient",
             activity_id = "activity",
             activity_instance_id = "activity_instance",
             lifecycle_id = "status",
             timestamp = "timestamp",
             resource_id = "resource",
             order = "alphabetical")

  expect_equal(patientslog$.order, c(1, 8, 9, 3, 4, 5, 6, 7, 2))
})

test_that("test eventlog order arg sort column", {

  patients_ordering <- read.csv("./testdata/patients_ordering.csv") %>%
    mutate(timestamp = as.POSIXct(timestamp, format = "%Y-%m-%d %H:%M:%S", tz = "UTC"))

  patientslog <- patients_ordering %>%
    eventlog(case_id = "patient",
             activity_id = "activity",
             activity_instance_id = "activity_instance",
             lifecycle_id = "status",
             timestamp = "timestamp",
             resource_id = "resource",
             order = "resource")

  expect_equal(patientslog$.order, c(6, 4, 5, 1, 2, 3, 8, 9, 7))
})

test_that("test eventlog order arg 'sorted' missing .order column", {

  expect_error(
    read_testdata() %>%
      eventlog(case_id = "patient",
               activity_id = "activity",
               activity_instance_id = "activity_instance",
               lifecycle_id = "status",
               timestamp = "timestamp",
               resource_id = "resource",
               order = "sorted"),
    "Order should be a character with value 'auto', 'alphabetical', 'sorted', or a valid column-name")
})

test_that("test eventlog order arg out of range", {

  expect_error(
    read_testdata() %>%
      eventlog(case_id = "patient",
               activity_id = "activity",
               activity_instance_id = "activity_instance",
               lifecycle_id = "status",
               timestamp = "timestamp",
               resource_id = "resource",
               order = "random"),
    "Order should be a character with value 'auto', 'alphabetical', 'sorted', or a valid column-name")
})

test_that("test eventlog mandatory args", {

  patients <- read_testdata()

  expect_error(
    patients %>%
      eventlog(activity_id = "activity",
               activity_instance_id = "activity_instance",
               lifecycle_id = "status",
               timestamp = "timestamp",
               resource_id = "resource"),
    "*case_id*")
  expect_error(
    patients %>%
      eventlog(case_id = "patient",
               activity_instance_id = "activity_instance",
               lifecycle_id = "status",
               timestamp = "timestamp",
               resource_id = "resource"),
    "*activity_id*")
  expect_error(
    patients %>%
      eventlog(case_id = "patient",
               activity_id = "activity",
               lifecycle_id = "status",
               timestamp = "timestamp",
               resource_id = "resource"),
    "*activity_instance_id*")
  expect_error(
    patients %>%
      eventlog(case_id = "patient",
               activity_id = "activity",
               activity_instance_id = "activity_instance",
               timestamp = "timestamp",
               resource_id = "resource"),
    "*lifecycle_id*")
  expect_error(
    patients %>%
      eventlog(case_id = "patient",
               activity_id = "activity",
               activity_instance_id = "activity_instance",
               lifecycle_id = "status",
               resource_id = "resource"),
    "*timestamp*")
  expect_error(
    patients %>%
      eventlog(case_id = "patient",
               activity_id = "activity",
               activity_instance_id = "activity_instance",
               lifecycle_id = "status",
               timestamp = "timestamp"),
    "*resource_id*")
})
