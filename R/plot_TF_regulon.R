#' Plot Regulation Graph for a Gene with Size Limits
#'
#' This function plots a graph showing all the transcription factors (TFs) that regulate a given gene
#' and all the target genes regulated by it, with optional limits on the number of TFs and targets shown.
#'
#' @param gene_name A string specifying the name of the gene.
#' @param max_TFs An integer limiting the maximum number of TFs shown. Default is NULL, meaning no limit.
#' @param max_targets An integer limiting the maximum number of target genes shown. Default is NULL, meaning no limit.
#' @importFrom igraph graph_from_data_frame
#' @importFrom igraph V
#' @importFrom igraph plot
#' @examples
#' plot_TF_regulon("CTCF")
#' plot_TF_regulon("CTCF", max_TFs = 10, max_targets = 10)
#'
#' @export
plot_TF_regulon <- function(gene_name, max_TFs = NULL, max_targets = NULL) {
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
    warning("max_TFs must be a non-negative integer. Ignoring max_TFs and proceeding without a limit.")
    max_TFs <- NULL
  }

  # Validate max_targets
  if (!is.null(max_targets) && (!is.numeric(max_targets) || max_targets < 0)) {
    warning("max_targets must be a non-negative integer. Ignoring max_targets and proceeding without a limit.")
    max_targets <- NULL
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

  # Plot the graph
  igraph::plot(graph, edge.arrow.size = 0.5)
}


# [END]
