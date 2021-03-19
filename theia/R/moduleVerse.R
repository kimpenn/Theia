verseUI <- function(id) {
  ns <- NS(id)
  fluidPage(
    tabsetPanel(
      tabUI_handler(tab_name = "Parameters",
                    table_name = ns("parameters")),
      tabUI_handler(tab_name = "Exons",
                    table_name = ns("exons")),
      tabUI_handler(tab_name = "Anti-exons",
                    table_name = ns("anti_exons")),
      tabUI_handler(tab_name = "Introns",
                    table_name = ns("introns")),
      tabUI_handler(
        tab_name = "Anti-introns",
        table_name = ns("anti_introns")
      ),
      tabUI_handler(tab_name = "Mito",
                    table_name = ns("mito")),
      tabUI_handler(tab_name = "Anti-mito",
                    table_name = ns("anti_mito")),
      tabUI_handler(tab_name = "Intergenic",
                    table_name = ns("intergenic")),
      tabUI_handler(tab_name = "Misc.",
                    table_name = ns("misc")),
      tabUI_handler(tab_name = "Perc",
                    table_name = ns("perc"))
    )
  )
}

verse <- function(id, metadataTable) {
  moduleServer(id, function(input, output, session) {
    observe({
      metadata_table <- metadataTable()
      
      output$parameters <-
        update_table_handler(metadata_table, "VERSE", "Parameters", NULL)
      
      output$exons <-
        update_table_handler(metadata_table, "VERSE", "Result", "exons")
      
      output$anti_exons <-
        update_table_handler(metadata_table, "VERSE", "Result", "anti-exons")
      
      output$introns <-
        update_table_handler(metadata_table, "VERSE", "Result", "introns")
      
      output$anti_introns <-
        update_table_handler(metadata_table, "VERSE", "Result", "anti-introns")
      
      output$mito <-
        update_table_handler(metadata_table, "VERSE", "Result", "mito")
      
      output$anti_mito <-
        update_table_handler(metadata_table, "VERSE", "Result", "anti-mito")
      
      output$intergenic <-
        update_table_handler(metadata_table, "VERSE", "Result", "Intergenic")
      
      output$misc <-
        update_table_handler(metadata_table, "VERSE", "Result", "misc.")
      
      output$perc <-
        update_table_handler(metadata_table, "VERSE", "Result", "Perc")
    })
  })
}
