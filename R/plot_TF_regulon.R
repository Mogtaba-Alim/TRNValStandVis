#' Plot Regulation Graph for a Gene with Size Limits
#'
#' This function plots a graph showing all the transcription factors (TFs) that regulate a given gene
#' and all the target genes regulated by it, with optional limits on the number of TFs and targets shown.
#'
#' @param gene_name A string specifying the name of the gene.
#' @param max_TFs An integer limiting the maximum number of TFs shown. Default is NULL, meaning no limit.
#' @param max_targets An integer limiting the maximum number of target genes shown. Default is NULL, meaning no limit.
#'
#' @return A value of 1 indicating that the plot function has run without any errors.
#' @return The output graph shows the input gene and it's target genes in orange
#' @return and it's regulating TF's in green. With arrows point from TF to TG.
#'
#' @importFrom igraph graph_from_data_frame
#' @importFrom igraph V
#' @importFrom igraph layout_with_fr
#'
#' @examples
#' # Plots the regulon of the gene CTCF showing it's regulators and targets
#' plot_TF_regulon("CTCF")
#'
#' # Allows you to specify the maximum number of regulators and targets.
#' # The default is 30 genes for each to create the optimum output.
#' # There is no maximum and if the value set is greater than the available
#' # genes then all available genes are plotted.
#' plot_TF_regulon("CTCF", max_TFs = 10, max_targets = 10)
#'
#' @export
plot_TF_regulon <- function(gene_name, max_TFs = 30, max_targets = 30) {
  # Ensure the package data is loaded
  data(TF_TG_Valid_Comb, package = "TRNValStandVis")

  # Extract the list of valid genes from the dataset
  valid_genes <- unique(c(TF_TG_Valid_Comb$TF, TF_TG_Valid_Comb$Target_Gene))

  # Validate gene_name
  if (!gene_name %in% valid_genes) {
    stop("Invalid gene name provided.")
  }

  # Validate max_TFs
  if (!is.null(max_TFs) && (!is.numeric(max_TFs) || max_TFs < 0)) {
    warning("max_TFs must be a non-negative integer. Ignoring max_TFs and proceeding with default limit.")
    max_TFs <- 30
  }

  # Validate max_targets
  if (!is.null(max_targets) && (!is.numeric(max_targets) || max_targets < 0)) {
    warning("max_targets must be a non-negative integer. Ignoring max_targets and proceeding with default limit.")
    max_targets <- 30
  }

  # Extract TFs regulating the gene and apply max_TFs limit if specified
  regulating_TFs <- subset(TF_TG_Valid_Comb, Target_Gene == gene_name)$TF
  if (!is.null(max_TFs) && length(regulating_TFs) > max_TFs) {
    regulating_TFs <- head(regulating_TFs, max_TFs)
  }

  # Extract target genes regulated by the gene and apply max_targets limit if specified
  target_genes <- subset(TF_TG_Valid_Comb, TF == gene_name)$Target_Gene
  if (!is.null(max_targets) && length(target_genes) > max_targets) {
    target_genes <- head(target_genes, max_targets)
  }

  # Create edges for the graph
  edges_from_TFs <- data.frame(from = regulating_TFs, to = gene_name)
  edges_to_targets <- data.frame(from = gene_name, to = target_genes)
  edges <- rbind(edges_from_TFs, edges_to_targets)

  # Create graph
  graph <- igraph::graph_from_data_frame(edges, directed = TRUE)

  # Set node colors: TFs in one color, target genes in another, and the main gene in a third color
  igraph::V(graph)$color <- ifelse(names(igraph::V(graph)) == gene_name, "red",
                                   ifelse(names(igraph::V(graph)) %in% regulating_TFs, "orange", "green"))

  # Choose a layout that spaces nodes more
  layout <- igraph::layout_with_fr(graph)


  # Plot the graph with title and improved layout
  plot(graph, layout = layout, edge.arrow.size = 0.5, main = "Transcription Factor Regulon",
       vertex.label.cex = 0.7)

  # Add a legend to the plot (adjust position and size)
  legend("topright", inset = c(0, -0.02), legend = c("Gene", "Regulator", "Target"),
         col = c("red", "orange", "green"), pch = 21, pt.cex = 1, cex = 0.7, box.lty=0)

  return(1)
}


# [END]
