miscUI <- function(id) {
  ns <- NS(id)
  
  fluidPage(wellPanel(fluidRow(
    selectInput(
      ns("select"),
      "Hide Columns from Table",
      choices = character(0),
      multiple = TRUE
    )
  ), fluidRow(
    column(2, actionButton(
      ns("hide_button"),
      "Hide Columns",
      class = "btn-primary"
    )),
    column(4,
           checkboxInput(
             ns("check"),
             "Hide Empty Columns",
             value = FALSE
           ))
  )),
  fluidRow(column(12, DTOutput(ns(
    "tbl"
  )))))
}

misc <- function(id, metadataTable) {
  moduleServer(id, function(input, output, session) {
    hideList <- reactiveVal()
    theTable <- reactiveVal()
    ########################
    # Update Selection
    ########################
    observe({
      req(theTable)
      updateSelectInput(session,
                        "select",
                        choices = colnames(theTable())[-1])
    })
    
    observeEvent(input$hide_button, {
      req(metadataTable)
      hideList(input$select)
    })
    
    observe({
      req(metadataTable)
      metadata_table <- metadataTable()
      col_selected <-
        filter(THEIA_CONFIG, `level-1` == "MISC.")[["Field"]]
      col_selected <- c(INDEX_COL, col_selected)
      theTable(metadata_table[, colnames(metadata_table) %in% col_selected])
    })
    
    observe({
      req(theTable)
      col_selected <- !(colnames(theTable()) %in% hideList())
      the_table <- theTable()[, col_selected]
      
      if (input$check) {
        col_selected <- colSums(!is.na(the_table)) > 0
        the_table <- the_table[, col_selected]
      }
      
      output$tbl <- renderDataTable({
        datatable(
          the_table, extensions = 'FixedColumns',
          options = list(
            scrollY = TRUE,
            autoWidth = TRUE,
            scrollX = TRUE,
            fixedColumns = list(leftColumns = 2)
          )
        )
      })
    })
  })
}