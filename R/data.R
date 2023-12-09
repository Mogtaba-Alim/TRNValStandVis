#' Dataset of all the TF-TG interactions combined from the four sources.
#'
#' This dataset combines data from the ChEA3, hTFtarget, MSigDB and TFLink to
#' create a dataset of all the TF-TG interactions available in all the 4 datasets.
#' To process the data, all genes that did not have a translatable HGNC symbol,
#' even in alternate nomenclatures was removed. Based on the count of appearance
#' of a TF-TG in the datasets a validation score was created.
#' TF_TG_Exp_qual_score is a qualitative score for each TF-TG interaction based
#' on validation across datasets and in comparison to other TF-TG's in the
#'combined datasets.
#'
#'
#' Description of the dataset.
#'
#' @format A data frame with 5 columns:
#' \describe{
#'   \item{TF}{Transcription Factor name in HGNC. }
#'   \item{Target_Gene}{Target Gene name in HGNC.}
#'   \item{Count}{Frequency of TF-TG across the datasets.}
#'   \item{TF_TG_Exp_qual_score}{Exponential validation score of TF-TG based on frequency}
#'   \item{Ratio_to_TF_Avg}{Normalized validation score based on TF_TG_Exp_qual_score.}
#'
#'   ...
#' }
#' @name TF_TG_Valid_Comb
#' @docType data
#' @usage data(TF_TG_Valid_Comb)
#'
#' @examples
#' \dontrun{
#'  TF_TG_Valid_Comb
#' }
#'
"TF_TG_Valid_Comb"

#' Dataset of the overall validation score of individual Transcription Factors.
#'
#' This dataset maps every HGNC standardized TF to its overall avg validation score
#' over all it TF-TG interactions. Ratio_to_Overall_Avg is a qualitative value
#' that represents the normalized average validation quality of a specific TF
#' over all TF-TG interactions in the combined dataset that involved that TF.
#'
#' @format A dataframe with 2 columns:
#' \describe{
#'   \item{TF}{Transcription Factor name in HGNC. }
#'   \item{Ratio_to_Overall_Avg}{Normalized Average validation score for all TFs interactions.}
#'
#'   ...
#' }
#'
#' @name TF_Avg_Valid
#' @docType data
#' @usage data(TF_Avg_Valid)
#'
#' @examples
#' \dontrun{
#'  TF_Avg_Valid
#' }
#'
"TF_Avg_Valid"
