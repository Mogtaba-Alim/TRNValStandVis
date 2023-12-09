library(TRNValStandVis)

testthat::test_that("Valid inputs run without error", {
  testthat::expect_silent(plot_TF_regulon("CTCF"))
  testthat::expect_silent(plot_TF_regulon("CTCF", max_TFs = 10, max_targets = 10))
})

testthat::test_that("Invalid gene_name stops with an error", {
  testthat::expect_error(plot_TF_regulon("invalid_gene"))
})

testthat::test_that("Invalid max_TFs and max_targets result in warning", {
  testthat::expect_warning(plot_TF_regulon("CTCF", max_TFs = -1))
  testthat::expect_warning(plot_TF_regulon("CTCF", max_targets = "invalid"))
})

testthat::test_that("Function runs with default parameters", {
  testthat::expect_silent(plot_TF_regulon("CTCF"))
})

testthat::test_that("Edge cases are handled", {
  testthat::expect_silent(plot_TF_regulon("CTCF", max_TFs = 1, max_targets = 100))
})

testthat::test_that("Function returns 1 on successful completion", {
  testthat::expect_equal(plot_TF_regulon("CTCF"), 1)
})
