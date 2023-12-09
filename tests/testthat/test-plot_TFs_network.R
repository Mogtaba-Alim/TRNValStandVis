library(TRNValStandVis)

testthat::test_that("Valid inputs run without error", {
  testthat::expect_silent(plot_TFs_network(c("CTCF", "GATA1")))
  testthat::expect_silent(plot_TFs_network(c("CTCF")))
  testthat::expect_silent(plot_TFs_network(c("CTCF", "GATA1", "STAT1")))
})

testthat::test_that("Invalid gene_names stop with an error", {
  testthat::expect_error(plot_TFs_network(c("invalid_gene1", "invalid_gene2")))
})

testthat::test_that("More than three gene names stop with an error", {
  testthat::expect_error(plot_TFs_network(c("Gene1", "Gene2", "Gene3", "Gene4")))
})

testthat::test_that("Empty gene_names vector stops with an error", {
  testthat::expect_error(plot_TFs_network(c()))
})

testthat::test_that("Invalid max_TFs and max_targets result in warning", {
  testthat::expect_warning(plot_TFs_network(c("CTCF"), max_TFs = -1))
  testthat::expect_warning(plot_TFs_network(c("CTCF"), max_targets = "invalid"))
})

testthat::test_that("Function returns 1 on successful completion", {
  testthat::expect_equal(plot_TFs_network(c("CTCF", "GATA1")), 1)
})
