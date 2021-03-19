uploadFileUI <- function(id) {
  ns <- NS(id)
  sidebarLayout(sidebarPanel(
    h3("Upload Metadata"),
    fileInput(
      ns("metadata_csv"),
      "Choose CSV File",
      multiple = FALSE,
      accept = c("text",
                 "tsv",
                 "xls")
    ),
    actionButton(ns("load_data_button"),
                 "Upload Data",
                 class = "btn-primary")
  ),
  mainPanel(wellPanel(verbatimTextOutput(ns(
    "log"
  )))))
}


uploadFile <- function(id) {
  moduleServer(id, function(input, output, session) {
    metadataTable <- reactiveVal()
    
    observeEvent(input$load_data_button, {
      req(input$metadata_csv)
      inFile <- input$metadata_csv
      metadata_table <- read_tsv(inFile$datapath)
      res_log <- preprocess_handler(metadata_table, THEIA_CONFIG)
      output$log <- renderText({res_log})
      metadataTable(metadata_table)
    })
    
    metadataTable
  })
}
