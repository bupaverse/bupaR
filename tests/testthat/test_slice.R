
library(bupaR)

context("Slice eventlog")

test_that("slice returns eventlog", {
	expect_s3_class(slice(patients, (sample(size = 1, 1:n_cases(patients))):(sample(size = 1, 1:n_cases(patients)))), "eventlog")
	expect_s3_class(slice(sepsis, (sample(size = 1, 1:n_cases(sepsis))):(sample(size = 1, 1:n_cases(sepsis)))), "eventlog")
})

test_that("slice returns eventlog with correct amount of cases", {
	selection <- (sample(size = 1, 1:n_cases(patients))):(sample(size = 1, 1:n_cases(patients)))
	expect_equal(n_cases(slice(patients, selection)), length(selection))
})
