qc_handler <- function(input, metadata_table) {
  my_mask <- rep(FALSE, nrow(metadata_table))
  
  for (idx in seq(nrow(QC_METRICS_TABLE))) {
    the_field <- QC_METRICS_TABLE$Field[idx]
    the_element_id <- QC_METRICS_TABLE$numInputId[idx]
    
    if (QC_METRICS_TABLE$is_larger_than_bad_sample[idx])
      the_mask <- metadata_table[[the_field]] < input[[the_element_id]]
    else
      the_mask <- metadata_table[[the_field]] > input[[the_element_id]]

    my_mask <- my_mask | the_mask
  }

  metadata_table$id[my_mask]
}

# ##################
# # Mock Testing
# ##################
# 
# metadata_table <- read_tsv("SampleMetadata.xls")
# metadata_table <- cbind(id = seq_len(nrow(metadata_table)), metadata_table)
#
# # TOTOAL_READS <- 1000000
# # UNIQUE_READS <- 1000000
# # NOMAP_READS <- 100
# # EXON_READS <- 400000
# TOTOAL_READS <- 1000000
# UNIQUE_READS <- 1000000
# NOMAP_READS <- 100
# EXON_READS <- 0
# qc_mertics_list <- list(
#   "total_reads" = TOTOAL_READS,
#   "unique_reads" = UNIQUE_READS,
#   "nomap_reads" = NOMAP_READS,
#   "exon_reads" = EXON_READS
# )
#
# qc_handler(metadata_table, qc_mertics_list)
