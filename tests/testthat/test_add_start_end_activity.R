
test_that("test add_end_activity on eventlog", {

  load("./testdata/patients.rda")

  patients <- patients %>%
    add_end_activity(label = "end case")

  john_end <- patients[patients["patient"] == "John Doe" & patients["activity"] == "end case",]

  expect_equal(nrow(john_end), 1)
})
