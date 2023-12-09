#' Retrieve Transcription Factors Regulating a Given Target Gene
#'
#' This function returns a vector of Transcription Factors (TFs) that regulate a specified Target Gene.
#' It filters the data based on the Target Gene and a validation frequency, and limits the size of the returned vector.
#'
#' @param target_gene A string specifying the name of the Target Gene.
#' @param validation_freq A numeric value representing the validation frequency threshold. Default is 1.
#' @param max_size An integer that limits the maximum size of the returned vector of TFs. Default is NULL, meaning no limit.
#'
#' @return A vector of TFs that regulate the specified Target Gene, limited in size by max_size.
#'
#' @examples
#'
#' # Gets all the transcription factors of the input gene
#' get_TFs("CTCF")
#'
#' # Allows the user to specify the validation frequency of the transcription factors
#' # The default value is 1 and the max value is 4.
#' get_TFs("CTCF", validation_freq = 2)
#'
#' # Allows the user to specify the maximum number of transcription factors to return
#' # The default value is NULL meaning it returns all the transcription factors.
#' get_TFs("CTCF", max_size = 5)
#'
#' @export
get_TFs <- function(target_gene, validation_freq = 1, max_size = NULL) {
  # Ensure the package data is loaded
  data(TF_TG_Valid_Comb, package = "TRNValStandVis")

  # Extract the list of valid Target Genes from the dataset
  valid_genes <- unique(TF_TG_Valid_Comb$Target_Gene)

  # Validate target_gene
  if (!target_gene %in% valid_genes) {
    stop("Invalid Target Gene name provided.")
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

  # Filter the data for the given Target Gene and validation frequency
  filtered_data <- subset(TF_TG_Valid_Comb, Target_Gene == target_gene & Count >= validation_freq)

  # If max_size is specified and is less than the length of filtered_data, return a limited number of TFs
  if (!is.null(max_size) && !is.na(max_size) && max_size < length(filtered_data$TF)) {
    return(filtered_data$TF[1:max_size])
  }

  # Return the vector of TFs
  return(filtered_data$TF)
}

# [END]

