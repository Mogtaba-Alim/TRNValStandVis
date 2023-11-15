#' Plot Target Gene Validation Scores for a Given TF with Frequency and Size Filters
#'
#' This function plots the target genes against their TF_TG_Exp_qual_score for a specified Transcription Factor (TF),
#' considering the frequency of the count and limiting the number of target genes based on max_size.
#' Each target gene is represented by a different color to form a spectrum.
#'
#' @param tf_name A string specifying the name of the Transcription Factor.
#' @param validation_freq A numeric value representing the validation frequency threshold. Default is 1.
#' @param max_size An integer that limits the maximum number of target genes for which scores are plotted. Default is NULL, meaning no limit.
#' @import ggplot2
#' @examples
#' plot_TF_TG_val("CTCF")
#' plot_TF_TG_val("CTCF", validation_freq = 2, max_size = 10)
#'
#'
#' @export
plot_TF_TG_val <- function(tf_name, validation_freq = 1, max_size = NULL) {
  data(TF_TG_Valid_Comb, package = "TRNValStandVis")

  # Filter data for the given TF and validation frequency
  filtered_data <- subset(TF_TG_Valid_Comb, TF == tf_name & Count >= validation_freq)

  # Apply max_size limit if specified
  if (!is.null(max_size) && nrow(filtered_data) > max_size) {
    filtered_data <- head(filtered_data, max_size)
  }

  # Plotting
  ggplot(filtered_data, aes(x = Target_Gene, y = TF_TG_Exp_qual_score, color = Target_Gene)) +
    geom_point() +
    scale_color_viridis_d() +
    labs(title = paste(tf_name, "Target Gene Validation Scores"),
         x = "Target Gene",
         y = "Validation Score") +
    theme(axis.text.x = element_text(angle = 90, hjust = 1))  # Adjust text angle for better readability if many genes
}
