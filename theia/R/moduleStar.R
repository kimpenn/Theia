starUI <- function(id) {
  ns <- NS(id)
  fluidPage(tabsetPanel(
    tabUI_handler(tab_name = "All",
                  table_name = ns("all")),
    tabUI_handler(tab_name = "Parameters",
                  table_name = ns("parameters")),
    tabUI_handler(tab_name = "Results",
                  table_name = ns("results"))
  ))
}

star <- function(id, metadataTable) {
  moduleServer(id, function(input, output, session) {
    observe({
      metadata_table <- metadataTable()
      
      output$all <-
        update_table_handler(metadata_table, "STAR", NULL)
      
      output$parameters <-
        update_table_handler(metadata_table, "STAR", "Parameters")
      
      output$results <-
        update_table_handler(metadata_table, "STAR", "Result")
    })
    
    
  })
}