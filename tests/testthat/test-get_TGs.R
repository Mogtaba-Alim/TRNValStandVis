context("Test getTG's")
library(TRNValStandVis)

testthat::test_that("Test with TF GATA1 and frequency 2", {
  result <- get_TGs("GATA1", 3, 10)


  expected_result <- c("HEXIM2", "NIPSNAP3A", "FNBP1", "BAD", "RC3H1", "CACNA2D4", "FRS3", "LNPEP", "PRKAB1", "SCD") # Example values

  # Test if the function returns the expected result
  testthat::expect_equal(result, expected_result)
})
