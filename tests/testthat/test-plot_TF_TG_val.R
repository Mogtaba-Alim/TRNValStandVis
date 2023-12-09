library(TRNValStandVis)

testthat::test_that("Valid inputs run without error", {
  testthat::expect_silent(plot_TF_TG_val("CTCF"))
  testthat::expect_silent(plot_TF_TG_val("CTCF", validation_freq = 2, max_size = 10))
})

testthat::test_that("Invalid tf_name stops with an error", {
  testthat::expect_error(plot_TF_TG_val("invalid_tf"))
})

testthat::test_that("Invalid validation_freq stops with an error", {
  testthat::expect_error(plot_TF_TG_val("CTCF", validation_freq = -1))
  testthat::expect_error(plot_TF_TG_val("CTCF", validation_freq = 5))
  testthat::expect_error(plot_TF_TG_val("CTCF", validation_freq = "invalid"))
})

testthat::test_that("Invalid max_size results in warning or error", {
  testthat::expect_warning(plot_TF_TG_val("CTCF", max_size = -1))
  testthat::expect_warning(plot_TF_TG_val("CTCF", max_size = "invalid"))
})

testthat::test_that("Function runs with default parameters", {
  testthat::expect_silent(plot_TF_TG_val("CTCF"))
})

testthat::test_that("Edge cases are handled", {
  testthat::expect_silent(plot_TF_TG_val("CTCF", max_size = 1))
  testthat::expect_silent(plot_TF_TG_val("CTCF", max_size = 100))
})
