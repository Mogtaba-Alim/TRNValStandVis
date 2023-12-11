#' Launch Shiny App for TRNValStandVis
#'
#' A function that launches the Shiny app for the TRNValStandVis package.
#' This app visualizes, validates, and standardizes TF-TG interactions
#' and Transcription Regulatory Networks (TRN). For more information
#' on the package, refer to its GitHub repository.
#'
#' @return No return value but opens up a Shiny page.
#'
#' @examples
#' \dontrun{
#'
#' TRNValStandVis::runTRNValStandVis()
#' }
#'
#' @references
#'
#' @export
#' @importFrom shiny runApp

runTRNValStandVis <- function() {
  appDir <- system.file("shiny-scripts",
                        package = "TRNValStandVis")
  actionShiny <- shiny::runApp(appDir, display.mode = "normal")
  return(actionShiny)
}
