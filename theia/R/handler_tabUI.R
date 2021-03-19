tabUI_handler <- function(tab_name, table_name) {
  tabPanel(tab_name,
           fluidRow(
             tags$div(
               style = "overflow-x:auto",
               DTOutput(table_name),
               options = list(
                 scrollX = FALSE
               )
             )
           ))
}

# tabUI_handler <- function(tab_name, table_name) {
#   tabPanel(tab_name,
#            fluidRow(
# 
#                DTOutput(table_name)
#              
#            ))
# }