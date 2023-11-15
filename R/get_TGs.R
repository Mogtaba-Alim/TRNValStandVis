#' Retrieve Target Genes for a Given Transcription Factor
#'
#' This function returns a vector of Target Genes associated with a specified Transcription Factor (TF) name.
#' It filters the data based on the TF name and a validation frequency.
#'
#' @param tf_name A string specifying the name of the Transcription Factor.
#' @param validation_freq A numeric value representing the validation frequency threshold. Default is 1.
#' @param max_size An integer that limits the maximum size of the returned vector of Target Genes. Default is NULL, meaning no limit.
#' @return A vector of Target Genes associated with the specified TF.
#' @examples
#' get_TGs("CTCF")
#' get_TGs("CTCF", validation_freq = 2)
#'
#' @export
get_TGs <- function(tf_name, validation_freq = 1, max_size = NULL) {
  # Ensure the package data is loaded
  data(TF_TG_Valid_Comb, package = "TRNValStandVis")

  # Filter the data for the given TF name and validation frequency
  filtered_data <- subset(TF_TG_Valid_Comb, TF == tf_name & Count >= validation_freq)

  # If max_size is specified and is less than the length of filtered_data, return a limited number of genes
  if (!is.null(max_size) && max_size < length(filtered_data$Target_Gene)) {
    return(filtered_data$Target_Gene[1:max_size])
  }

  # Return the vector of Target Genes
  return(filtered_data$Target_Gene)
}


# [END]
