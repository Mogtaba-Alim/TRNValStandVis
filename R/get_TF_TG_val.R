#' Retrieve validation score for All Target Genes of a Given TF
#'
#' This function returns the validation score for all target genes of a specified Transcription Factor (TF),
#' considering the frequency of the count, and limits the number of target genes based on max_size.
#'
#' @param tf_name A string specifying the name of the Transcription Factor.
#' @param validation_freq A numeric value representing the validation frequency threshold. Default is 1.
#' @param max_size An integer that limits the maximum number of target genes for which scores are returned. Default is NULL, meaning no limit.
#' @return A data frame with columns for target genes and their corresponding TF_TG_Exp_qual_score.
#' @importFrom dplyr filter
#' @importFrom dplyr arrange
#' @examples
#' get_TF_TG_val("CTCF")
#' get_TF_TG_val("CTCF", validation_freq = 3, max_size = 10)
#'
#' @export
#'
get_TF_TG_val <- function(tf_name, validation_freq = 1, max_size = NULL) {
  # Load necessary data
  data(TF_TG_Valid_Comb, package = "TRNValStandVis")

  # Extract the list of valid TFs from the dataset
  valid_TFs <- unique(TF_TG_Valid_Comb$TF)

  # Validate tf_name
  if (!tf_name %in% valid_TFs) {
    stop("Invalid TF name provided.")
  }

  # Validate validation_freq
  if (!is.numeric(validation_freq) || validation_freq < 0 || validation_freq > 4) {
    stop("validation_freq must be a non-negative numeric value less than 4.")
  }

  # Validate max_size
  if (!is.null(max_size) && (!is.numeric(max_size) || max_size < 0)) {
    warning("max_size must be a non-negative integer. Ignoring max_size and proceeding without a limit.")
    max_size <- NULL
  }

  # Filter data for the given TF and validation frequency
  filtered_data <- TF_TG_Valid_Comb %>%
    dplyr::filter(TF == tf_name, Count >= validation_freq) %>%
    dplyr::arrange(desc(TF_TG_Exp_qual_score))

  # Apply max_size limit if specified
  if (!is.null(max_size)) {
    filtered_data <- head(filtered_data, max_size)
  }

  # Return the relevant columns
  return(filtered_data[, c('Target_Gene', 'TF_TG_Exp_qual_score')])
}

# [END]
