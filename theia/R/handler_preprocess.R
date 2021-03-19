preprocess_handler <- function(metadata, config_table) {
  ###################################
  # Generate metadata table log
  ##################################
  my_table <- metadata
  log_str <- ""
  n_row <- dim(my_table)[1]
  n_col <- dim(my_table)[2]
  log_str <- paste0(log_str, "Loading MetatData File...\n")
  log_str <- paste0(log_str, "\tNumber of Samples: ", n_row, "\n")
  log_str <- paste0(log_str, "\tNumber of Fileds: ", n_col, "\n")
  
  ##################################
  # Build the Theia column list
  #################################
  delta_len <- length(setdiff(colnames(my_table[, -1]),
                              config_table[["Field"]]))
  if (delta_len > 0) {
    log_str <- paste0(log_str, "[Warning:] ", delta_len, " fileds in uploaded metadata file cannot match to Theia Configuration.\n")
  }
  else{
    log_str <- paste0(log_str, "All fileds in uploaded metadata file match to Theia Configuration.\n")
    
  }
  log_str <- paste0(log_str, "Done!\n")
  log_str
}

######################################
# Mock Test
###################################
# file_path <- "SampleMetadata.xls"
# my_table <- read_tsv(file_path)
# file_path <- "metadata-config.csv"
# config_table <- read_csv(file_path)
# length(intersect(colnames(my_table), config_table[["Field"]]))
# setdiff(config_table[["Field"]], colnames(my_table))
# setdiff(colnames(my_table), config_table[["Field"]])


# json_list <- fromJSON(file = "config.json",
#                              simplify = FALSE)
#
# preprocess_handler(my_table, json_list)

######################################
# Remove Empty Column
###################################
# my_clean_table <- select(my_table, where(~ any(!is.na(.))))
# n_col_clean <- dim(my_clean_table)[2]
# log_str <- paste0(log_str, "Filtering Out Empty Columns...\n")
# log_str <- paste0(log_str, "Non-empty Fileds Number: ", n_col_clean, "\n")

######################################
# Exam the quality of the json file
# If there are fields not in the metadata table,
# remove them from the list and generate warning.
######################################
# if (length(setdiff(the_vector, col_list)) > 0){
#   the_vector <- update_vector(the_vector, col_list)
#
#   the_vector_delta <- setdiff(the_vector, col_list)
#   log_str <- paste0(log_str, "[Warnning]: \n")
# }
