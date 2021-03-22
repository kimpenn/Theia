server <- function(input, output) {
  metadataTable <- uploadFile("uploadFile")
  
  qualityControl("qualityControl", metadataTable)
  expInfo("expInfo", metadataTable)
  star("star", metadataTable)
  verse("verse", metadataTable)
  blast("blast", metadataTable)
  trim("trim", metadataTable)
  misc("misc", metadataTable)
  
}