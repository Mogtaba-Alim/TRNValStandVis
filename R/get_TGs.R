#' Retrieve Target Genes for a Given Transcription Factor
#'
#' This function returns a vector of Target Genes associated with a specified Transcription Factor (TF) name.
#' It filters the data based on the TF name and a validation frequency.
#'
#' @param tf_name A string specifying the name of the Transcription Factor.
#' @param validation_freq A numeric value representing the validation frequency threshold. Default is 1. Maximum is 4
#' @param max_size An integer that limits the maximum size of the returned vector of Target Genes. Default is NULL, meaning no limit.
#'
#' @return A vector of Target Genes associated with the specified TF.
#'
#' @examples
#'
#' # Gets all the regulator genes of the input transcription factor.
#' get_TGs("CTCF")
#'
#' # Allows the user to specify the validation frequency of the target genes.
#' # The default value is 1 and the max value is 4.
#' get_TGs("CTCF", validation_freq = 2)
#'
#' # Allows the user to specify the maximum number of target genes to return
#' # The default value is NULL meaning it returns all the target genes.
#' get_TGs("CTCF", max_size = 15)
#'
#' @export
get_TGs <- function(tf_name, validation_freq = 1, max_size = NULL) {
  # Ensure the package data is loaded
  data(TF_TG_Valid_Comb, package = "TRNValStandVis")

  # Extract the list of valid TFs from the dataset
  valid_TFs <- unique(TF_TG_Valid_Comb$TF)

  # Validate tf_name
  if (!tf_name %in% valid_TFs) {
    stop("Invalid TF name provided.")
  }

  # Validate validation_freq
  if (!is.numeric(validation_freq) || validation_freq < 0 || validation_freq > 4) {
    stop("validation_freq must be a non-negative numeric value.")
  }

  # Validate max_size
  if (!is.null(max_size) && (!is.numeric(max_size) || max_size < 0)) {
    warning("max_size must be a non-negative integer. Ignoring max_size and proceeding without a limit.")
    max_size <- NULL
  }

  # Filter the data for the given TF name and validation frequency
  filtered_data <- subset(TF_TG_Valid_Comb, TF == tf_name & Count >= validation_freq)

  # If max_size is specified and is less than the length of filtered_data, return a limited number of genes
  if (!is.null(max_size) && !is.na(max_size) && max_size < length(filtered_data$Target_Gene)) {
    return(filtered_data$Target_Gene[1:max_size])
  }

  # Return the vector of Target Genes
  return(filtered_data$Target_Gene)
}



# [END]
