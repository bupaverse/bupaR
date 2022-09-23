
test_that("slice returns eventlog", {
	skip("TODO: rewrite slice tests")
	expect_s3_class(slice(patients, (sample(size = 1, 1:n_cases(patients))):(sample(size = 1, 1:n_cases(patients)))), "eventlog")
})

test_that("slice returns eventlog with correct amount of cases", {
	skip("TODO: rewrite slice tests")
	selection <- (sample(size = 1, 1:n_cases(patients))):(sample(size = 1, 1:n_cases(patients)))
	expect_equal(n_cases(slice(patients, selection)), length(selection))
})
