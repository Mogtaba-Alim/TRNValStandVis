#' Plot Validation Scores for Multiple Transcription Factors
#'
#' This function takes a vector of Transcription Factor (TF) names and plots a graph of their names against their Validation Scores.
#'
#' @param tf_names A vector of strings specifying the names of the Transcription Factors.
#' @import ggplot2
#' @examples
#' plot_TF_total_val(c("CTCF", "GATA1", "AHR", "AHRR", "BDP1"))
plot_TF_total_val <- function(tf_names) {
  data(TF_Avg_Valid, package = "TRNValStandVis")

  # Filter the dataset for the specified TFs
  filtered_data <- TF_Avg_Valid[TF_Avg_Valid$TF %in% tf_names, ]

  # Plotting
  ggplot(filtered_data, aes(x = TF, y = Ratio_to_Overall_Avg, fill = TF)) +
    geom_bar(stat = "identity") +
    labs(title = "TF Validation Scores", x = "Transcription Factor", y = "Validation Score") +
    theme_minimal() +
    theme(axis.text.x = element_text(angle = 45, hjust = 1))  # Adjust text angle for better readability
}
