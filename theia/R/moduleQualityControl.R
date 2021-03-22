qualityControlUI <- function(id) {
  ns <- NS(id)
  fluidPage(sidebarLayout(sidebarPanel(tabsetPanel(
    tabPanel(
      "QC Metrics",
      h4("A Good sample should have ..."),
      
      pmap(
        list(
          QC_METRICS_TABLE$Field,
          QC_METRICS_TABLE$numInputId,
          QC_METRICS_TABLE$default,
          QC_METRICS_TABLE$is_larger_than_bad_sample
        ),
        numericInputHandler,
        ns
      ),
      actionButton(ns("load_default_button"),
                   "Load Defaults",
                   class = "btn-primary"),
      actionButton(ns("qc_button"),
                   "Start QC!",
                   class = "btn-success"),
      verbatimTextOutput(ns("log"))
    ),
    tabPanel(
      "Outliers",
      fluidRow(
        selectInput(
          ns("outliers"),
          "Select the list of outlier ids.",
          choices = character(0),
          multiple = TRUE
        )
      ),
      fluidRow(
        actionButton(ns("reset_button"),
                     "Reset Table",
                     class = "btn-secondary"),
        actionButton(ns("update_button"),
                     "Update Table",
                     class = "btn-primary")
      ),
      div(style = "margin-top:2em",
          fluidRow(
            downloadButton(ns("export_button"),
                           "Export Outlier Table",
                           class = "btn-success")
          ))
      
      
    )
  ), ),
  mainPanel(tabsetPanel(
    tabPanel(
      "Histogram",
      selectInput(
        inputId = ns("mertics"),
        label = "Choose a mertic:",
        choices = QC_METRICS_TABLE$Field
      ),
      plotOutput(outputId = ns("histPlot"))
    ),
    tabPanel("Data Table", DTOutput(ns("tbl")))
  ))))
}

qualityControl <- function(id, metadataTable) {
  moduleServer(id, function(input, output, session) {
    #####################
    # reactive variables
    #####################
    # For table
    theTable <- reactiveVal()
    outlierList <- reactiveVal()
    # For QC
    react_list <- as.list(rep(NA, nrow(QC_METRICS_TABLE)))
    names(react_list) <- QC_METRICS_TABLE$reactiveValName
    qcMetricsRvs <- do.call("reactiveValues", react_list)

    #####################
    # Build Core QC Table
    #####################
    observe({
      req(metadataTable())
      
      the_table <- metadataTable()[, QC_TABLE_LIST]
      the_table <- cbind(id = seq_len(nrow(the_table)), the_table)
      theTable(the_table)
      updateSelectInput(session,
                        "outliers",
                        choices = the_table$id)
    })
    #####################
    #  Side Bar: QC Metrics Tab
    #####################
    # Load default Metrics
    observeEvent(input$load_default_button, {
      pmap(
        list(QC_METRICS_TABLE$numInputId,
             QC_METRICS_TABLE$default),
        numericInputUpdateHandler,
        session
      )
    })
    
    
    observeEvent(input$qc_button, {
      req(theTable())
      outlierList(qc_handler(reactiveValuesToList(input), theTable()))
      cat("outlierList():", outlierList(), "\n")
      updateSelectInput(session,
                        "outliers",
                        selected = outlierList())
    })
    #####################
    #  Side Bar: Outliers Tab
    #####################
    # Update QC Table by List
    observeEvent(input$update_button, {
      outlierList(input$outliers)
    })
    # Clean Outlier List
    observeEvent(input$reset_button, {
      outlierList(c())
      updateSelectInput(session,
                        "outliers",
                        selected = character(0))
    })
    # Export Current Outlier Table
    output$export_button <- downloadHandler(
      filename = function() {
        paste("theia-outliers-", Sys.Date(), ".csv", sep = "")
      },
      content = function(file) {
        if (length(outlierList()) > 0) {
          the_table <- theTable()[outlierList(),]
        } else{
          the_table <- theTable()
        }
        write_tsv(the_table, file)
      }
    )
    # ################################
    # #  Main Panel: Histogram
    # ###############################
    observe({
      req(input$mertics)
      
      col_data <- theTable()[, input$mertics]
      the_element_id <-
        QC_METRICS_TABLE$numInputId[QC_METRICS_TABLE$Field == input$mertics]
      the_v <- input[[the_element_id]]
      output$histPlot <- renderPlot({
        hist(
          col_data,
          col = "#75AADB",
          border = "white",
          xlab = input$mertic,
          ylab = "Frequency",
          main = paste0("Histogram of ", input$mertics)
        )
        abline(v = the_v,
               lwd = 2,
               col = "red")
      })
      
    })
    ################################
    #  Main Panel: Display Table
    ################################
    observe({
      req(theTable())
      
      for (the_numInputId in QC_METRICS_TABLE$numInputId) {
        req(input[[the_numInputId]])
      }
      
      if (length(outlierList()) > 0) {
        the_table <- theTable()[outlierList(),]
      } else{
        the_table <- theTable()
      }
      
      the_table <- datatable(the_table,
                             filter = "top")
      
      for (idx in seq_along(QC_METRICS_TABLE$numInputId)) {
        the_field <- QC_METRICS_TABLE$Field[idx]
        the_element_id <- QC_METRICS_TABLE$numInputId[idx]
        if (QC_METRICS_TABLE$is_larger_than_bad_sample[idx])
          my_color <- c("#FCF6B1", "#A9E5BB") # Yellow, Green
        else
          my_color <- c("#A9E5BB", "#FCF6B1") # Green, Yellow
        
        the_table <- formatStyle(the_table,
                                 the_field,
                                 backgroundColor =
                                   styleInterval(c(input[[the_element_id]]),
                                                 my_color))
      }
      
      output$tbl <- renderDataTable({
        the_table
      })
    })
  })
}
