#' Plot Combined Regulation Graph for Up to Three Genes
#'
#' This function plots a combined graph showing all the transcription factors (TFs) that regulate up to three given genes
#' and all the target genes regulated by them. The input genes, their regulators, and their target genes are colored differently.
#'
#' @param gene_names A vector of up to three gene names.
#' @param max_TFs An integer limiting the maximum number of TFs shown for each gene. Default is NULL, meaning no limit.
#' @param max_targets An integer limiting the maximum number of target genes shown for each gene. Default is NULL, meaning no limit.
#'
#' @return A value of 1 indicating that the plot function has run without any errors.
#' @return The output graph shows the input genex and there target genes in orange
#' @return and there regulating TF's in green. With arrows pointing from TF to TG.
#'
#' @importFrom igraph graph_from_data_frame
#' @importFrom igraph V
#'
#'
#' @examples
#'
#' # Plots the combined regulons of the input array of genes. Shows the
#' # transcription factors that act on the genes as well as the target genes.
#' plot_TFs_network(c("CTCF", "GATA1"))
#'
#' # Allows the user to specify the maximum number of transcription factors for
#' # each gene using max_TFs with a default value of 10 and a maximum number of
#' # target genes for each input gene with a default value of 10.
#' plot_TFs_network(c("CTCF", "GATA1", "STAT1"), max_TFs = 10, max_targets = 10)
#'
#' @export
plot_TFs_network <- function(gene_names, max_TFs = 10, max_targets = 10) {
  # Validate gene_names length
  if (length(gene_names) > 3) {
    stop("Maximum of 3 genes are allowed.")
  }

  if (length(gene_names) < 1) {
    stop("Empty input gene array.")
  }

  # Load your package data
  data(TF_TG_Valid_Comb, package = "TRNValStandVis")

  # Validate gene_names
  valid_genes <- unique(c(TF_TG_Valid_Comb$TF, TF_TG_Valid_Comb$Target_Gene))
  invalid_genes <- setdiff(gene_names, valid_genes)
  if (length(invalid_genes) > 0) {
    stop("Invalid gene names provided: ", paste(invalid_genes, collapse = ", "))
  }

  # Validate max_TFs
  if (!is.null(max_TFs) && (!is.numeric(max_TFs) || max_TFs < 0)) {
    warning("max_TFs must be a non-negative integer. Ignoring max_TFs and proceeding with default limit.")
    max_TFs <- 10
  }

  # Validate max_targets
  if (!is.null(max_targets) && (!is.numeric(max_targets) || max_targets < 0)) {
    warning("max_targets must be a non-negative integer. Ignoring max_targets and proceeding with default limit.")
    max_targets <- NULL
  }

  edges <- data.frame(from = character(), to = character())
  all_TFs <- character()
  all_targets <- character()

  for (gene in gene_names) {
    # Extract TFs regulating the gene and apply max_TFs limit if specified
    regulating_TFs <- subset(TF_TG_Valid_Comb, Target_Gene == gene)$TF
    if (!is.null(max_TFs) && length(regulating_TFs) > max_TFs) {
      regulating_TFs <- head(regulating_TFs, max_TFs)
    }

    # Extract target genes regulated by the gene and apply max_targets limit if specified
    target_genes <- subset(TF_TG_Valid_Comb, TF == gene)$Target_Gene
    if (!is.null(max_targets) && length(target_genes) > max_targets) {
      target_genes <- head(target_genes, max_targets)
    }

    # Combine TFs and targets for all genes
    all_TFs <- c(all_TFs, regulating_TFs)
    all_targets <- c(all_targets, target_genes)

    # Create edges for the graph
    edges_from_TFs <- data.frame(from = regulating_TFs, to = gene)
    edges_to_targets <- data.frame(from = gene, to = target_genes)
    edges <- rbind(edges, edges_from_TFs, edges_to_targets)
  }

  # Create graph
  graph <- igraph::graph_from_data_frame(edges, directed = TRUE)

  # Set node colors: input genes in one color, TFs in another, target genes in a third color
  igraph::V(graph)$color <- ifelse(names(igraph::V(graph)) %in% gene_names, "red",
                                   ifelse(names(igraph::V(graph)) %in% all_TFs, "orange", "green"))

  # Plot the graph
  plot(graph, vertex.color = igraph::V(graph)$color, edge.arrow.size = 0.5)

  return(1)
}

 # [END]
