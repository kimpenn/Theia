blastUI <- function(id) {
  ns <- NS(id)
  fluidPage(tabsetPanel(
    tabUI_handler(tab_name = "Parameters",
                  table_name = ns("parameters")),
    tabUI_handler(tab_name = "Results",
                  table_name = ns("results"))
  ))
}

blast <- function(id, metadataTable) {
  moduleServer(id, function(input, output, session) {
    observe({
      metadata_table <- metadataTable()

      output$parameters <-
        update_table_handler(metadata_table, "BLAST", "Parameters")

      output$results <-
        update_table_handler(metadata_table, "BLAST", "Result")
    })
    
    
  })
}