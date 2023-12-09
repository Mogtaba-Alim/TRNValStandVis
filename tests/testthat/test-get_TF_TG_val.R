library(TRNValStandVis)

# Test that valid inputs return the expected output
testthat::test_that("Valid inputs return expected output", {
  # Test with valid parameters
  expect_s3_class(get_TF_TG_val("CTCF"), "data.frame")
  # Additional checks for expected output can be added here
})

# Test that invalid TF name throws an error
testthat::test_that("Invalid TF name throws an error", {
  testthat::expect_error(get_TF_TG_val("invalid_tf_name"))
})

# Test that invalid validation_freq throws an error
testthat::test_that("Invalid validation_freq throws an error", {
  testthat::expect_error(get_TF_TG_val("CTCF", -1))
  testthat::expect_error(get_TF_TG_val("CTCF", "non-numeric"))
  testthat::expect_error(get_TF_TG_val("CTCF", 5))
})

# Test that invalid max_size triggers a warning and is ignored
testthat::test_that("Invalid max_size triggers a warning and is ignored", {
  testthat::expect_warning(get_TF_TG_val("CTCF", 1, -1))
  # Check if the function ignores max_size and proceeds
})

# Test that edge cases are handled correctly
testthat::test_that("Edge cases are handled correctly", {
  # Edge cases for validation_freq and max_size
  testthat::expect_s3_class(get_TF_TG_val("CTCF", 0), "data.frame")
  testthat::expect_s3_class(get_TF_TG_val("CTCF", 4), "data.frame")
  testthat::expect_s3_class(get_TF_TG_val("CTCF", 1, 0), "data.frame")
})

# Test that the output structure is correct
testthat::test_that("Output structure is correct", {
  result <- get_TF_TG_val("CTCF")
  testthat::expect_true(all(c("Target_Gene", "TF_TG_Exp_qual_score") %in% names(result)))
})
