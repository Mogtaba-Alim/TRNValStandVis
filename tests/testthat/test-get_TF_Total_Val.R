context("Tests for get_TF_Total_Val function")
library(TRNValStandVis)

# Test with a known TF
testthat::test_that("Correct score is returned for a known TF", {
  known_tf <- "CTCF"
  known_score <- 1.076605

  testthat::expect_equal(get_TF_Total_Val(known_tf), known_score)
})

# Test with an unknown TF
testthat::test_that("NA and warning are returned for an unknown TF", {
  unknown_tf <- "UnknownTF"

  # Expect a warning
  testthat::expect_warning(score <- get_TF_Total_Val(unknown_tf), "TF not found in the dataset.")

  # Expect NA as the return value
  testthat::expect_true(is.na(score))
})

