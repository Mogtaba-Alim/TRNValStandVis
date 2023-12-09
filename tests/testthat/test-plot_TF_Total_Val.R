library(TRNValStandVis)

testthat::test_that("Valid inputs run without error", {
  testthat::expect_silent(plot_TF_total_val(c("CTCF", "GATA1")))
  testthat::expect_silent(plot_TF_total_val("CTCF"))
})

testthat::test_that("Invalid tf_names stop with an error", {
  testthat::expect_error(plot_TF_total_val(c("invalid_tf1", "invalid_tf2")))
})

testthat::test_that("Empty vector is handled correctly", {
  testthat::expect_error(plot_TF_total_val(c()), "Empty input vector.")
})
