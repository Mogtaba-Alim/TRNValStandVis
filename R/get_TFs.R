#' Retrieve Transcription Factors Regulating a Given Target Gene
#'
#' This function returns a vector of Transcription Factors (TFs) that regulate a specified Target Gene.
#' It filters the data based on the Target Gene and a validation frequency, and limits the size of the returned vector.
#'
#' @param target_gene A string specifying the name of the Target Gene.
#' @param validation_freq A numeric value representing the validation frequency threshold. Default is 1.
#' @param max_size An integer that limits the maximum size of the returned vector of TFs. Default is NULL, meaning no limit.
#' @return A vector of TFs that regulate the specified Target Gene, limited in size by max_size.
#' @examples
#' get_TFs("Gene1")
#' get_TFs("Gene2", validation_freq = 2)
#' get_TFs("Gene3", max_size = 5)
#'
#' @export
get_TFs <- function(target_gene, validation_freq = 1, max_size = NULL) {
  # Ensure the package data is loaded
  data(TF_TG_Valid_Comb, package = "TRNValStandVis")

  # Filter the data for the given Target Gene and validation frequency
  filtered_data <- subset(TF_TG_Valid_Comb, Target_Gene == target_gene & Count >= validation_freq)

  # If max_size is specified and is less than the length of filtered_data, return a limited number of TFs
  if (!is.null(max_size) && max_size < length(filtered_data$TF)) {
    return(filtered_data$TF[1:max_size])
  }

  # Return the vector of TFs
  return(filtered_data$TF)
}
