library(TRNValStandVis)

testthat::test_that("Test with TF GATA1 and frequency 2", {
  result <- get_TGs("GATA1", 3, 10)
  expected_result <- c("HEXIM2", "NIPSNAP3A", "FNBP1", "BAD", "RC3H1", "CACNA2D4", "FRS3", "LNPEP", "PRKAB1", "SCD")
  # Test if the function returns the expected result
  testthat::expect_equal(result, expected_result)
})

testthat::test_that("Valid inputs return correct results", {
  testthat::expect_type(get_TGs("CTCF"), "character")
  testthat::expect_length(get_TGs("CTCF"), 21587)
  testthat::expect_length(get_TGs("CTCF", validation_freq = 2), 10637)
  testthat::expect_length(get_TGs("CTCF", max_size = 15), 15)
})

testthat::test_that("Invalid tf_name stops with an error", {
  testthat::expect_error(get_TGs("invalid_tf"), "Invalid TF name provided.")
})

testthat::test_that("Invalid validation_freq stops with an error", {
  testthat::expect_error(get_TGs("CTCF", validation_freq = -1))
  testthat::expect_error(get_TGs("CTCF", validation_freq = 5))
  testthat::expect_error(get_TGs("CTCF", validation_freq = "invalid"))
})

testthat::test_that("Invalid max_size results in warning or error", {
  testthat::expect_warning(get_TGs("CTCF", max_size = -1))
  testthat::expect_warning(get_TGs("CTCF", max_size = "invalid"))
})

testthat::test_that("Function works with default parameters", {
  testthat::expect_silent(get_TGs("CTCF"))
})

testthat::test_that("Edge cases are handled correctly", {
  testthat::expect_length(get_TGs("CTCF", validation_freq = 0), 21587)
  testthat::expect_length(get_TGs("CTCF", validation_freq = 3), 1315)
})

testthat::test_that("Data types are handled correctly", {
  testthat::expect_error(get_TGs(123))
  testthat::expect_error(get_TGs("CTCF", validation_freq = "two"))
  testthat::expect_warning(get_TGs("CTCF", max_size = "five"))
})

