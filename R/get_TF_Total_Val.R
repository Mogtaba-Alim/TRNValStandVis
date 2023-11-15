#' Retrieve Score for a Given Transcription Factor from tf_metrics
#'
#' This function returns the Ratio_to_Overall_Avg score for a specified Transcription Factor (TF)
#' from the tf_metrics dataset.
#'
#' @param tf_name A string specifying the name of the Transcription Factor.
#' @return The Ratio_to_Overall_Avg score for the specified TF.
#' @examples
#' get_TF_Total_Val("CTCF")
#'
#' @export
get_TF_Total_Val <- function(tf_name) {

  data(TF_Avg_Valid, package = "TRNValStandVis")

  # Filter for the specified TF and retrieve the score
  score <- subset(TF_Avg_Valid, TF == tf_name)$Ratio_to_Overall_Avg

  # Check if the TF was found and return the score
  if (length(score) == 0) {
    warning("TF not found in the dataset.")
    return(NA)
  } else {
    return(score)
  }
}
