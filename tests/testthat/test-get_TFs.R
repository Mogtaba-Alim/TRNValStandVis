library(TRNValStandVis)

testthat::test_that("Test with Target Gene CTCF,  frequency 2 amd max size 5", {
  result <- get_TFs("CTCF", 2, max_size = 5)
  expected_result <- c("GATA1", "EGR1", "STAT1", "E2F4", "SPI1")
  testthat::expect_equal(result, expected_result)
  testthat::expect_true(length(result) <= 5)
})

testthat::test_that("Valid inputs return correct results", {
  testthat::expect_type(get_TFs("CTCF"), "character")
  testthat::expect_length(get_TFs("CTCF"), 527)
  testthat::expect_length(get_TFs("CTCF", validation_freq = 2), 106)
  testthat::expect_length(get_TFs("CTCF", max_size = 5), 5)
})

testthat::test_that("Invalid target_gene stops with an error", {
  testthat::expect_error(get_TFs("invalid_gene"), "Invalid Target Gene name provided.")
})

testthat::test_that("Invalid validation_freq stops with an error", {
  testthat::expect_error(get_TFs("CTCF", validation_freq = -1))
  testthat::expect_error(get_TFs("CTCF", validation_freq = 5))
  testthat::expect_error(get_TFs("CTCF", validation_freq = "invalid"))
})

testthat::test_that("Invalid max_size results in warning or error", {
  testthat::expect_warning(get_TFs("CTCF", max_size = -1))
  testthat::expect_warning(get_TFs("CTCF", max_size = "invalid"))
})

testthat::test_that("Function works with default parameters", {
  testthat::expect_silent(get_TFs("CTCF"))
})

testthat::test_that("Edge cases are handled correctly", {
  testthat::expect_length(get_TFs("CTCF", validation_freq = 0), 527)
  testthat::expect_length(get_TFs("CTCF", validation_freq = 3), 7)
})

testthat::test_that("Data types are handled correctly", {
  testthat::expect_error(get_TFs(123))
  testthat::expect_error(get_TFs("CTCF", validation_freq = "two"))
  testthat::expect_warning(get_TFs("CTCF", max_size = "five"))
})
