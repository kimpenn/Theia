numericInputHandler <-
  function(field, numInputId, default_val, flg, ns) {
    the_max <- NA
    the_min <- 1
    
    if (grepl("perc", numInputId, fixed = TRUE)) {
      the_max <- 100
    }
    if (flg) {
      title <- paste0(field, " > :")
    } else{
      title <- paste0(field, " < :")
    }
    numericInput(
      ns(numInputId),
      title,
      value = default_val,
      min = the_min,
      max = the_max
    )
    
  }
numericInputUpdateHandler <-
  function(numInputId, default_val, session) {
    updateNumericInput(session, numInputId, value = default_val)
  }

getNumericInputHandler <- function(numInputId) {
  input[[numInputId]]
}
# numericInput(
#   ns("totalReads"),
#   "Total Reads After Trim > :",
#   value = TOT_READS_AFTER_TRIM,
#   min = 1
#   # max = 100
# ),
# numericInput(
#   ns("uniqueReads"),
#   "Unique Mapped Reads > :",
#   value = UNIQUE_MAPPED_READS,
#   min = 1
#   # max = 100
# ),
# numericInput(
#   ns("uniqueReads"),
#   "Unique Mapped Reads > :",
#   value = UNIQUE_MAPPED_READS,
#   min = 1
#   # max = 100
# ),
# numericInput(
#   ns("noMapReads"),
#   "Not Mapped Percentage < :",
#   value = NOMAP_READS,
#   min = 1,
#   max = 100
# ),
# numericInput(
#   ns("exonReads"),
#   "Exons level 1,2: non-spike-in Reads Counts > :",
#   value = EXON_READS,
#   min = 1
#   # max = 100
# ),