library(TRNValStandVis)

# Test with a known TF
testthat::test_that("Correct score is returned for a known TF", {
  known_tf <- "CTCF"
  known_score <- 1.07660522

  testthat::expect_equal(get_TF_Total_Val(known_tf), known_score)
})

# Test with an unknown TF
testthat::test_that("NA and warning are returned for an unknown TF", {
  unknown_tf <- "UnknownTF"

  # Expect an error
  testthat::expect_error(score <- get_TF_Total_Val(unknown_tf), "Invalid TF name provided.")

  # Expect the score variable to not exist
  testthat::expect_error(score, "object 'score' not found")
})

