
library(shiny)
library(shinyalert)

ui <- fluidPage(
  titlePanel("TRNValStandVis: Visualization, Standardization and Validation of TF-TG Interactions"),
  tabsetPanel(
    tabPanel("Home",
             fluidPage(
               h4("About TRNValStandVis"),
               p("TRNValStandVis is an R package for visualizing, validating, and standardizing Transcription Factor (TF) - Target Genes (TG) interactions and Transcription Regulatory Networks (TRN). It combines data from four datasets, ensuring HGNC compliance, and includes tools for evaluating and comparing the quality of TF-TG interactions."),
               fluidRow(
                 column(6,
                        h4("Function: get_TF_TG_val"),
                        p("Returns validity scores for all TGs of a given TF."),
                        img(src = "get_TF_TG_val_Example_1.png", height = "200px")
                 ),
                 column(6,
                        h4("Function: plot_TF_regulon"),
                        p("Visualizes a gene's regulon including regulators and targets."),
                        img(src = "plot_TF_regulon_Example.png", height = "200px")
                 )
               ),
               fluidRow(
                 column(6,
                        h4("Function: plot_TF_TG_val"),
                        p("Plots validity scores for all TGs of a TF."),
                        img(src = "plot_TF_TG_val_Example.png", height = "200px")
                 ),
                 column(6,
                        h4("Function: plot_TF_total_val"),
                        p("Plots average validity scores for a collection of TFs."),
                        img(src = "plot_TF_total_val_Example.png", height = "200px")
                 )
               ),
               fluidRow(
                 column(12,
                        h4("Function: plot_TFs_network"),
                        p("Plots a network for up to 3 genes, showing combined regulons."),
                        img(src = "plot_TFs_network_Example.png", height = "200px")
                 )
               ),
               h4("Datasets"),
               p("The package includes two datasets: TF_TG_Valid_Comb and TF_Avg_Valid."),
               h5("TF_TG_Valid_Comb Dataset"),
               p("This dataset combines TF-TG interactions from four sources, providing a validation score..."),
               img(src = "TF_TG_Valid_Comb_Example.png", height = "200px"),
               h5("TF_Avg_Valid Dataset"),
               p("This dataset maps HGNC standardized TFs to their overall avg validation score..."),
               img(src = "TF_Avg_Valid_Example.png", height = "200px")
             )
    ),
    tabPanel("Validation Scores",
             sidebarLayout(
               sidebarPanel(
      helpText("This app retrieves validation scores for target genes (TG) of a specified transcription factor (TF)."),
      textInput("tf_name", "Transcription Factor Name", value = ""),
      helpText("Enter the name of the Transcription Factor (TF) for which you want to retrieve target genes and their validation scores."),
      numericInput("validation_freq", "Validation Frequency", value = 1, min = 1, max = 3),
      helpText("Enter a validation frequency threshold (1 to 3). This represents the frequency of validation of the TF-TG interactions."),
      numericInput("max_size", "Max Size (0 for no limit)", value = 0, min = 0),
      helpText("Specify the maximum number of target genes to display. Enter 0 for no limit."),
      actionButton("submit", "Submit"),
               ),
      mainPanel(
        dataTableOutput("results")
      )
             )
    ),
    tabPanel("TF Regulon Plot",
             sidebarLayout(
               sidebarPanel(
                 helpText("This section plots a graph showing all transcription factors (TFs) that regulate a given gene and all target genes regulated by it. You can limit the number of TFs and targets shown."),
                 textInput("gene_name", "Gene Name", value = ""),
                 helpText("Enter the name of the gene for which you want to visualize its regulatory network."),
                 numericInput("max_TFs", "Max TFs", value = 30, min = 1, max = 100),
                 helpText("Set the maximum number of TFs to display. Default is 30."),
                 numericInput("max_targets", "Max Targets", value = 30, min = 1, max = 100),
                 helpText("Set the maximum number of target genes to display. Default is 30."),
                 actionButton("plot", "Plot")
               ),
               mainPanel(
                 plotOutput("regulonPlot", height = "500px", width = "100%")
               )
             )
    ),
    tabPanel("TF-TG Validation Score Plot",
             sidebarLayout(
               sidebarPanel(
                 helpText("This section plots target genes against their validation scores for a specified TF. Target genes are shown in different colors."),
                 textInput("tf_name_val", "Transcription Factor Name", value = ""),
                 helpText("Enter the name of the Transcription Factor for which to plot target gene validation scores."),
                 numericInput("validation_freq_val", "Validation Frequency", value = 1, min = 1, max = 3),
                 helpText("Set the validation frequency threshold (1 to 3)."),
                 numericInput("max_size_val", "Max Size", value = 30, min = 1, max = 100),
                 helpText("Set the maximum number of target genes to plot. Default is 30 for optimal visualization."),
                 actionButton("plot_val", "Plot")
               ),
               mainPanel(
                 plotOutput("validationPlot", height = "600px", width = "100%")
               )
             )
    ),
    tabPanel("Multiple TF Validation Scores",
             sidebarLayout(
               sidebarPanel(
                 helpText("This section plots the normalized average validation scores for multiple TFs. Enter TF names separated by commas."),
                 textAreaInput("tf_names", "Transcription Factor Names", value = ""),
                 helpText("Enter a comma-separated list of Transcription Factor names for which to plot validation scores."),
                 actionButton("plot_multi_tf", "Plot")
               ),
               mainPanel(
                 plotOutput("multiTfPlot", height = "600px", width = "100%")
               )
             )
    ),
    tabPanel("Combined TFs Network",
             sidebarLayout(
               sidebarPanel(
                 helpText("This section plots a combined graph of up to three genes, showing all TFs that regulate these genes and all their target genes."),
                 textAreaInput("gene_names_network", "Gene Names", value = ""),
                 helpText("Enter up to three gene names, separated by commas. For optimal visualization, limit to 3 genes."),
                 numericInput("max_TFs_network", "Max TFs per Gene", value = 10, min = 1, max = 30),
                 helpText("Set the maximum number of TFs shown for each gene. Default is 10."),
                 numericInput("max_targets_network", "Max Targets per Gene", value = 10, min = 1, max = 30),
                 helpText("Set the maximum number of target genes shown for each gene. Default is 10."),
                 actionButton("plot_network", "Plot")
               ),
               mainPanel(
                 plotOutput("networkPlot", height = "600px", width = "100%")
               )
             )
    ),
    tabPanel("View Datasets",
             sidebarLayout(
               sidebarPanel(
                 helpText("Explore two key datasets: TF_TG_Valid_Comb and TF_Avg_Valid. TF_TG_Valid_Comb contains information on TF-TG interactions across various datasets, with validation scores. TF_Avg_Valid provides an overall average validation score for each TF."),
                 selectInput("dataset_choice", "Choose a Dataset", choices = c("TF_TG_Valid_Comb", "TF_Avg_Valid")),
                 conditionalPanel(
                   condition = "input.dataset_choice == 'TF_TG_Valid_Comb'",
                   helpText("TF_TG_Valid_Comb: Explore TF-TG interactions with various filters."),
                   textAreaInput("tf_names_filter", "Filter TF Names (comma-separated)", value = ""),
                   textAreaInput("tg_names_filter", "Filter TG Names (comma-separated)", value = ""),
                   sliderInput("count_filter", "Count Range", min = 0, max = 3, value = c(0, 3)),
                   sliderInput("exp_qual_score_filter", "TF_TG_Exp_qual_score Range", min = 0.5, max = 1, value = c(0.5, 1)),
                   sliderInput("ratio_to_tf_avg_filter", "Ratio_to_TF_Avg Range", min = 0, max = 0.2, value = c(0, 0.2))
                 ),
                 conditionalPanel(
                   condition = "input.dataset_choice == 'TF_Avg_Valid'",
                   helpText("TF_Avg_Valid: View overall validation scores for TFs."),
                   textAreaInput("tf_avg_tf_names_filter", "Filter TF Names", value = ""),
                   sliderInput("ratio_to_overall_avg_filter", "Ratio_to_Overall_Avg Range", min = 0.95, max = 1.2, value = c(0.95, 1.2))
                 ),
                 actionButton("view_data", "View Data")
               ),
               mainPanel(
                 dataTableOutput("datasetView")
               )
             )
    )
  )
)


server <- function(input, output, session) {
  observeEvent(input$submit, {
    req(input$tf_name)
    max_size <- ifelse(input$max_size == 0, 0, input$max_size)

    if (max_size == 0) {
      output$results <- renderDataTable({
        get_TF_TG_val(input$tf_name, input$validation_freq)
      })
    } else {
      output$results <- renderDataTable({
        get_TF_TG_val(input$tf_name, input$validation_freq, max_size)
      })
    }
  })

  # Logic for plot_TF_regulon
  observeEvent(input$plot, {
    output$regulonPlot <- renderPlot({
      plot_TF_regulon(input$gene_name, input$max_TFs, input$max_targets)
    })
  })

  # Logic for the plot_TF_TG_val function
  observeEvent(input$plot_val, {
    output$validationPlot <- renderPlot({
      plot_TF_TG_val(input$tf_name_val, input$validation_freq_val, input$max_size_val)
    })
  })

  # Logic for the plot_TF_Total_Val function
  observeEvent(input$plot_multi_tf, {
    tf_names_vector <- strsplit(input$tf_names, ",\\s*")[[1]]  # Splitting input string into vector
    output$multiTfPlot <- renderPlot({
      plot_TF_total_val(tf_names_vector)
    })
  })

  # Logic for plot_TFs_network
  observeEvent(input$plot_network, {
    gene_names_vector <- strsplit(input$gene_names_network, ",\\s*")[[1]]  # Splitting input string into vector
    output$networkPlot <- renderPlot({
      plot_TFs_network(gene_names_vector, input$max_TFs_network, input$max_targets_network)
    })
  })

  # Logic for the view datasets tab
  observeEvent(input$view_data, {
    if (input$dataset_choice == "TF_TG_Valid_Comb") {
      data(TF_TG_Valid_Comb, package = "TRNValStandVis")
      dataset <- TF_TG_Valid_Comb
      if (input$tf_names_filter != "") {
        tf_names <- unlist(strsplit(input$tf_names_filter, ",\\s*"))
        dataset <- dataset[dataset$TF %in% tf_names, ]
      }
      if (input$tg_names_filter != "") {
        tg_names <- unlist(strsplit(input$tg_names_filter, ",\\s*"))
        dataset <- dataset[dataset$Target_Gene %in% tg_names, ]
      }
      dataset <- dataset[dataset$Count >= input$count_filter[1] & dataset$Count <= input$count_filter[2], ]
      dataset <- dataset[dataset$TF_TG_Exp_qual_score >= input$exp_qual_score_filter[1] & dataset$TF_TG_Exp_qual_score <= input$exp_qual_score_filter[2], ]
      dataset <- dataset[dataset$Ratio_to_TF_Avg >= input$ratio_to_tf_avg_filter[1] & dataset$Ratio_to_TF_Avg <= input$ratio_to_tf_avg_filter[2], ]
    } else {
      data(TF_Avg_Valid, package = "TRNValStandVis")
      dataset <- TF_Avg_Valid
      if (input$tf_avg_tf_names_filter != "") {
        tf_names <- unlist(strsplit(input$tf_avg_tf_names_filter, ",\\s*"))
        dataset <- dataset[dataset$TF %in% tf_names, ]
      }
      dataset <- dataset[dataset$Ratio_to_Overall_Avg >= input$ratio_to_overall_avg_filter[1] & dataset$Ratio_to_Overall_Avg <= input$ratio_to_overall_avg_filter[2], ]
    }
    output$datasetView <- renderDataTable({
      dataset
    })
  })


}


shinyApp(ui = ui, server = server)
