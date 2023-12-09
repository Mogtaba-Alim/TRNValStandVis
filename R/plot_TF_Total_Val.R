#' Plot Validation Scores for Multiple Transcription Factors
#'
#' This function takes a vector of Transcription Factor (TF) names and plots a
#' graph of their names against their Validation Scores. The validation score
#' is represented by the Ratio_to_Overall_Avg from the TF_Avg_Valid dataset
#' which is a qualitative value that represents the normalized average
#' validation quality of a specific TF over all TF-TG interactions in the
#' combined dataset that involved that TF.
#'
#' @param tf_names A vector of strings specifying the names of the Transcription Factors.
#'
#' @return A value of 1 indicating that the plot function has run without any errors
#'
#' @importFrom ggplot2 ggplot
#' @importFrom ggplot2 aes
#' @importFrom ggplot2 geom_bar
#' @importFrom ggplot2 labs
#' @importFrom ggplot2 theme_minimal
#' @importFrom ggplot2 theme
#' @importFrom ggplot2 element_text
#'
#'
#' @examples
#' # Plots the the normalized average validation score for an input array of TFs.
#' plot_TF_total_val(c("CTCF", "GATA1", "AHR", "AHRR", "BDP1"))
#'
#' @export
plot_TF_total_val <- function(tf_names) {
  data(TF_Avg_Valid, package = "TRNValStandVis")

  # Validate tf_names (check if they are in the dataset)
  valid_TFs <- unique(TF_Avg_Valid$TF)
  invalid_TFs <- setdiff(tf_names, valid_TFs)
  if (length(invalid_TFs) > 0) {
    stop("The following TF names are invalid: ", paste(invalid_TFs, collapse = ", "))
  }

  # Filter the dataset for the specified TFs
  filtered_data <- TF_Avg_Valid[TF_Avg_Valid$TF %in% tf_names, ]

  # Plotting
  ggplot2::ggplot(filtered_data, ggplot2::aes(x = TF, y = Ratio_to_Overall_Avg, fill = TF)) +
    ggplot2::geom_bar(stat = "identity") +
    ggplot2::labs(title = "TF Validation Scores", x = "Transcription Factor", y = "Validation Score") +
    ggplot2::theme_minimal() +
    ggplot2::theme(axis.text.x = ggplot2::element_text(angle = 45, hjust = 1))  # Adjust text angle for better readability

  return(1)
}

# [END]
