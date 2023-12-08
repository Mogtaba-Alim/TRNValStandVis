testthat::context("Test get_TF's")
library(TRNValStandVis)

testthat::test_that("Test with Target Gene CTCF,  frequency 2 amd max size 5", {
  result <- get_TFs("CTCF", 2, max_size = 5)


  expected_result <- c("GATA1", "EGR1", "STAT1", "E2F4", "SPI1")


  testthat::expect_equal(result, expected_result)


  testthat::expect_true(length(result) <= 5)
})
