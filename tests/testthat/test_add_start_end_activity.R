
test_that("test add_end_activity on eventlog", {

  load("./testdata/patients.rda")

  patients <- patients %>%
    add_end_activity(label = "end case")

  john_end <- patients[patients["patient"] == "John Doe" & patients["activity"] == "end case",]
  jane_end <- patients[patients["patient"] == "Jane Doe" & patients["activity"] == "end case",]

  expect_s3_class(patients, "eventlog")

  # Expect event for each case with "end case" activity and instance ID {case}-end.
  expect_equal(nrow(john_end), 1)
  expect_equal(john_end[[timestamp(patients)]], as.POSIXct("2017-05-11 14:52:37", format = "%Y-%m-%d %H:%M:%S", tz = "UTC"))
  expect_equal(john_end[[activity_instance_id(patients)]], "John Doe-end")
  expect_equal(nrow(jane_end), 1)
  expect_equal(jane_end[[timestamp(patients)]], as.POSIXct("2017-05-12 10:46:22", format = "%Y-%m-%d %H:%M:%S", tz = "UTC"))
  expect_equal(jane_end[[activity_instance_id(patients)]], "Jane Doe-end")
})

test_that("test add_end_activity on grouped_eventlog", {

  load("./testdata/patients_grouped.rda")

  patients <- patients_grouped %>%
    add_end_activity(label = "end case")

  john_end <- patients[patients["patient"] == "John Doe" & patients["activity"] == "end case",]
  jane_end <- patients[patients["patient"] == "Jane Doe" & patients["activity"] == "end case",]

  expect_s3_class(patients, "grouped_eventlog")

  # Expect event for each case with "end case" activity and instance ID {case}-end.
  expect_equal(nrow(john_end), 1)
  expect_equal(john_end[[timestamp(patients)]], as.POSIXct("2017-05-11 14:52:37", format = "%Y-%m-%d %H:%M:%S", tz = "UTC"))
  expect_equal(john_end[[activity_instance_id(patients)]], "John Doe-end")
  expect_equal(nrow(jane_end), 1)
  expect_equal(jane_end[[timestamp(patients)]], as.POSIXct("2017-05-12 10:46:22", format = "%Y-%m-%d %H:%M:%S", tz = "UTC"))
  expect_equal(jane_end[[activity_instance_id(patients)]], "Jane Doe-end")

  # Expect that grouping vars remain
  expect_equal(groups(patients), groups(patients_grouped))
})

test_that("test add_start_activity on eventlog", {

  load("./testdata/patients.rda")

  patients <- patients %>%
    add_start_activity(label = "start case")

  john_start <- patients[patients["patient"] == "John Doe" & patients["activity"] == "start case",]
  jane_start <- patients[patients["patient"] == "Jane Doe" & patients["activity"] == "start case",]

  expect_s3_class(patients, "eventlog")

  # Expect event for each case with "start case" activity and instance ID {case}-start.
  expect_equal(nrow(john_start), 1)
  expect_equal(john_start[[timestamp(patients)]], as.POSIXct("2017-05-10 08:33:25", format = "%Y-%m-%d %H:%M:%S", tz = "UTC"))
  expect_equal(john_start[[activity_instance_id(patients)]], "John Doe-start")
  expect_equal(nrow(jane_start), 1)
  expect_equal(jane_start[[timestamp(patients)]], as.POSIXct("2017-05-11 09:53:45", format = "%Y-%m-%d %H:%M:%S", tz = "UTC"))
  expect_equal(jane_start[[activity_instance_id(patients)]], "Jane Doe-start")
})

test_that("test add_start_activity on grouped_eventlog", {

  load("./testdata/patients_grouped.rda")

  patients <- patients_grouped %>%
    add_start_activity(label = "start case")

  john_start <- patients[patients["patient"] == "John Doe" & patients["activity"] == "start case",]
  jane_start <- patients[patients["patient"] == "Jane Doe" & patients["activity"] == "start case",]

  expect_s3_class(patients, "grouped_eventlog")

  # Expect event for each case with "start case" activity and instance ID {case}-start.
  expect_equal(nrow(john_start), 1)
  expect_equal(john_start[[timestamp(patients)]], as.POSIXct("2017-05-10 08:33:25", format = "%Y-%m-%d %H:%M:%S", tz = "UTC"))
  expect_equal(john_start[[activity_instance_id(patients)]], "John Doe-start")
  expect_equal(nrow(jane_start), 1)
  expect_equal(jane_start[[timestamp(patients)]], as.POSIXct("2017-05-11 09:53:45", format = "%Y-%m-%d %H:%M:%S", tz = "UTC"))
  expect_equal(jane_start[[activity_instance_id(patients)]], "Jane Doe-start")

  # Expect that grouping vars remain
  expect_equal(groups(patients), groups(patients_grouped))
})