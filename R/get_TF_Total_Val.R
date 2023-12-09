#' Retrieve Score for a Given Transcription Factor from tf_metrics
#'
#' This function returns the Ratio_to_Overall_Avg score for a specified Transcription Factor (TF)
#' from the tf_metrics dataset.
#'
#' @param tf_name A string specifying the name of the Transcription Factor.
#' @return The Ratio_to_Overall_Avg score for the specified TF.
#' @examples
#'
#' # Gets the normalized average validation score for a specific TF.
#' get_TF_Total_Val("CTCF")
#'
#' @export
get_TF_Total_Val <- function(tf_name) {
  # Load necessary data
  data(TF_Avg_Valid, package = "TRNValStandVis")

  # Extract the list of valid TFs from the dataset
  valid_TFs <- unique(TF_Avg_Valid$TF)

  # Validate tf_name
  if (!tf_name %in% valid_TFs) {
    stop("Invalid TF name provided.")
  }

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

# [END]

