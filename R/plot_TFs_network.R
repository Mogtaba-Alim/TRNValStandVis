#' Plot Combined Regulation Graph for Up to Three Genes
#'
#' This function plots a combined graph showing all the transcription factors (TFs) that regulate up to three given genes
#' and all the target genes regulated by them. The input genes, their regulators, and their target genes are colored differently.
#'
#' @param gene_names A vector of up to three gene names.
#' @param max_TFs An integer limiting the maximum number of TFs shown for each gene. Default is NULL, meaning no limit.
#' @param max_targets An integer limiting the maximum number of target genes shown for each gene. Default is NULL, meaning no limit.
#' @import igraph
#' @examples
#' plot_TFs_network(c("CTCF", "GATA1"))
#' plot_TFs_network(c("CTCF", "GATA1", "STAT1"), max_TFs = 10, max_targets = 10)
#'
#' @export
plot_TFs_network <- function(gene_names, max_TFs = NULL, max_targets = NULL) {
  if(length(gene_names) > 3) {
    stop("Maximum of 3 genes are allowed")
  }

  # Load your package data
  data(TF_TG_Valid_Comb, package = "TRNValStandVis")

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
  graph <- graph_from_data_frame(edges, directed = TRUE)

  # Set node colors: input genes in one color, TFs in another, target genes in a third color
  V(graph)$color <- ifelse(names(V(graph)) %in% gene_names, "red",
                           ifelse(names(V(graph)) %in% all_TFs, "orange", "green"))

  # Plot the graph
  plot(graph, vertex.color = V(graph)$color, edge.arrow.size = 0.5)
}
