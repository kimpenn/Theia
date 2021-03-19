library(tidyverse)
library(DT)
library(shinydashboard)
library(shinyFiles)
library(shinyjs)
library(shinymanager)
library(reactR)
library(listviewer)
library(rjson)
library(shinythemes)

INDEX_COL <- "Sample Name"
THEIA_CONFIG <- read_csv("metadata-config.csv")
x <- filter(THEIA_CONFIG, `level-1` == "exp-info")
# load_dataset <- function(input_path){
#   my_df <- read_csv(input_path) %>%
#     rename(Symbol=X1) %>% as.data.frame()
#   rownames(my_df) <- my_df$Symbol
#   my_df[,-1]
# }
#
# load_coldata <- function(input_path){
#   read_csv(input_path)
# }
