% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_TF_TG_val.R
\name{get_TF_TG_val}
\alias{get_TF_TG_val}
\title{Retrieve validation score for All Target Genes of a Given TF}
\usage{
get_TF_TG_val(tf_name, validation_freq = 1, max_size = NULL)
}
\arguments{
\item{tf_name}{A string specifying the name of the Transcription Factor.}

\item{validation_freq}{A numeric value representing the validation frequency threshold. Default is 1.}

\item{max_size}{An integer that limits the maximum number of target genes for which scores are returned. Default is NULL, meaning no limit.}
}
\value{
A data frame with columns for target genes and their corresponding TF_TG_Exp_qual_score.
}
\description{
This function returns the validation score for all target genes of a specified Transcription Factor (TF),
considering the frequency of the count, and limits the number of target genes based on max_size.
}
\examples{
get_TF_TG_val("CTCF")
get_TF_TG_val("CTCF", validation_freq = 3, max_size = 10)

}