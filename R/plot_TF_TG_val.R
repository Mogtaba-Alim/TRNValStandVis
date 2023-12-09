#' Plot Target Gene Validation Scores for a Given TF with Frequency and Size Filters
#'
#' This function plots the target genes against their TF_TG_Exp_qual_score for a specified Transcription Factor (TF),
#' considering the frequency of the count and limiting the number of target genes based on max_size.
#' Each target gene is represented by a different color to form a spectrum.
#' The TF_TG_Exp_qual_score in the TF_TG_Valid_Comb datasets is a qualitative
#' score for each TF-TG interaction based on validation across datasets and in
#' comparison to other TF-TG's in the combined datasets.
#'
#' @param tf_name A string specifying the name of the Transcription Factor.
#' @param validation_freq A numeric value representing the validation frequency threshold. Default is 1. Maximum is 4.
#' @param max_size An integer that limits the maximum number of target genes for which scores are plotted. Default is 30, for optimal visualization.
#'
#' @return The plot graph.
#'
#' @importFrom ggplot2 ggplot
#' @importFrom ggplot2 aes
#' @importFrom ggplot2 geom_point
#' @importFrom ggplot2 scale_color_viridis_d
#' @importFrom ggplot2 labs
#' @importFrom ggplot2 theme
#' @importFrom ggplot2 element_text
#'
#' @examples
#'
#' # Plot the validation score of the target genes of the input TF.
#' plot_TF_TG_val("CTCF")
#'
#' # Allow the user to specify the validation frequency of the target genes
#' # that are to be displayed, a number between 1 and 4. Also allows the user
#' # to specify the number of target genes to show using max_size. The default
#' # value is 30 to optimize the graph visual.
#' plot_TF_TG_val("CTCF", validation_freq = 2, max_size = 10)
#'
#'
#' @export
plot_TF_TG_val <- function(tf_name, validation_freq = 1, max_size = 30) {
  data(TF_TG_Valid_Comb, package = "TRNValStandVis")

  # Validate tf_name (assuming valid_TFs is the unique TFs in TF_TG_Valid_Comb)
  valid_TFs <- unique(TF_TG_Valid_Comb$TF)
  if (!tf_name %in% valid_TFs) {
    stop("Invalid TF name provided.")
  }

  # Validate validation_freq
  if (!is.numeric(validation_freq) || validation_freq < 0 || validation_freq > 4) {
    stop("validation_freq must be a non-negative numeric value.")
  }

  # Validate max_size
  if (!is.null(max_size) && (!is.numeric(max_size) || max_size < 1)) {
    warning("max_size must be a non-negative integer. Ignoring max_size and proceeding with available data.")
    max_size <- NULL
  }

  # Filter data for the given TF and validation frequency
  filtered_data <- subset(TF_TG_Valid_Comb, TF == tf_name & Count >= validation_freq)

  # Apply max_size limit if specified
  if (!is.null(max_size) && nrow(filtered_data) > max_size) {
    filtered_data <- head(filtered_data, max_size)
  }

  # Plotting
  return(ggplot2::ggplot(filtered_data, ggplot2::aes(x = Target_Gene, y = TF_TG_Exp_qual_score, color = Target_Gene)) +
    ggplot2::geom_point() +
    ggplot2::scale_color_viridis_d() +
    ggplot2::labs(title = paste(tf_name, "Target Gene Validation Scores"),
                  x = "Target Gene",
                  y = "Validation Score") +
    ggplot2::theme(axis.text.x = ggplot2::element_text(angle = 90, hjust = 1, face = "italic" )))  # Adjust text angle for better readability if many genes

}


# [END]
