update_table_handler <-
  function(metadata_table,
           l1,
           l2 = NULL,
           l3 = NULL) {
    if (!is.null(l3)) {
      col_selected <-
        filter(THEIA_CONFIG,
               `level-1` == l1,
               `level-2` == l2,
               `level-3` == l3)[["Field"]]
    } else if (!is.null(l2)) {
      col_selected <-
        filter(THEIA_CONFIG,
               `level-1` == l1,
               `level-2` == l2)[["Field"]]
    } else{
      col_selected <-
        filter(THEIA_CONFIG,
               `level-1` == l1)[["Field"]]
    }
    
    col_selected <- c(INDEX_COL, col_selected)
    the_table <-
      metadata_table[, colnames(metadata_table) %in% col_selected]
    renderDataTable({
      datatable(the_table, extensions = 'FixedColumns',
                options = list(
                  autoWidth = TRUE,
                  # dom = 'ft',
                  # scrollX = TRUE,
                  fixedColumns = list(leftColumns = 2)
                ))
    })
  }